//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import ObjectiveC

@available(iOS 7.0, *)
public protocol PinSafeAreaInsetsUpdate {
    func safeAreaInsetsDidChange()
}

internal class PinSafeArea {
    fileprivate static var isEnabledCompatibilitySafeAreaInsets = false

    internal static func enableCompatibilitySafeArea() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // Do nothing, let the iOS 11+ safeAreaInsets mecanism do his thing
        } else if !isEnabledCompatibilitySafeAreaInsets {
            swizzleMethod(UIViewController.self, #selector(UIViewController.viewWillLayoutSubviews), #selector(UIViewController.swizzled_viewWillLayoutSubviews))
            isEnabledCompatibilitySafeAreaInsets = true
        }
    }

    private static let swizzleMethod: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
        if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
            let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

extension UIViewController {
    @objc fileprivate func swizzled_viewWillLayoutSubviews() {
        if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }

        self.swizzled_viewWillLayoutSubviews()
        let safeAreaInsets = UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: bottomLayoutGuide.length, right: 0)

        // Set children safeArea up to 3 level, to limit the performance issue of computing this compatibilitySafeAreaInsets
        view.setCompatibilitySafeAreaInsets(safeAreaInsets, recursiveLevel: 3)
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var compatibilitySafeAreaInsets = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }

    private(set) var compatibilitySafeAreaInsets: UIEdgeInsets {
        get {
            if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }
            return objc_getAssociatedObject(self, &AssociatedKeys.compatibilitySafeAreaInsets) as? UIEdgeInsets ?? .zero
        }
        set {
            if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }
            let didChange: Bool = compatibilitySafeAreaInsets != newValue
            objc_setAssociatedObject(self, &AssociatedKeys.compatibilitySafeAreaInsets, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if didChange {
                handleSafeAreaInsetsDidChange()
            }
        }
    }

    fileprivate func setCompatibilitySafeAreaInsets(_ insets: UIEdgeInsets, recursiveLevel: Int = 0) {
        if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }
        compatibilitySafeAreaInsets = insets

        guard recursiveLevel > 0 else { return }
        for subview in subviews {
            guard !(self is UIScrollView) else { return }  // scrollview's children don't have safeAreaInsets

            let subviewSafeAreaInsets = viewSafeAreaInsets(forView: subview, parent: self, parentSafeArea: insets)
            subview.setCompatibilitySafeAreaInsets(subviewSafeAreaInsets, recursiveLevel: recursiveLevel - 1)
        }
    }

    func computeSafeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }

        if let _ = self.next as? UIViewController {
            // The UIView is the UIViewController's UIView, its compatibilitySafeAreaInsets don't need to be recomputed.
            return self.compatibilitySafeAreaInsets
        } else {
            // NOTE: We recompute all view's safeAreaInsets because their position and size may have
            //       been modified since the last UIViewController.viewWillLayoutSubviews() call (see swizzled_viewWillLayoutSubviews).
            var stack: [UIView] = [self]
            var topParent = self

            // 1) Reach the UIViewController's UIView to get its compatibilitySafeAreaInsets, which is the
            //    only one we are sure its value is valid.
            while (topParent.next as? UIViewController) == nil {
                guard let parent = topParent.superview  else { return .zero }  // The view is not attached
                guard !(parent is UIScrollView) else { return .zero }          // scrollview's children don't have safeAreaInsets
                topParent = parent

                if (topParent.next as? UIViewController) == nil {
                    stack.append(topParent)
                }
            }

            // 2) Use this UIViewController's top UIView compatibilitySafeAreaInsets to recompute
            //    all its children UIView's compatibilitySafeAreaInsets until we reach "self" (UIView)
            var safeAreaInsets = topParent.compatibilitySafeAreaInsets

            while let currentView = stack.popLast() {
                safeAreaInsets = viewSafeAreaInsets(forView: currentView, parent: topParent, parentSafeArea: safeAreaInsets)
                currentView.compatibilitySafeAreaInsets = safeAreaInsets

                topParent = currentView
            }
            return safeAreaInsets
        }
    }

    fileprivate func viewSafeAreaInsets(forView view: UIView, parent: UIView, parentSafeArea: UIEdgeInsets) -> UIEdgeInsets {
        // WARNING: On iOS 11, children has never inset values (UIView.safeAreaInsets) greater than their parent insets!!
        //          This looks like a bug, because a children with a negative positition (ex: frame.origin.y = -20) should
        //          have a top inset greater than its parent top inset. But on iOS 11 this is not the case. For that
        //          reason we must limit inset value to their parent inset value (ref: min(newInset, parentInset)).
        let topInsetValue = max(min(parentSafeArea.top - view.frame.origin.y, parentSafeArea.top), 0)
        let bottomInsetValue = max(min(view.frame.maxY - parent.bounds.size.height + parentSafeArea.bottom, parentSafeArea.bottom), 0)

        // Compute only top and bottom inset values. compatibilitySafeAreaInsets is used only for non iOS 11 devices, which
        // only has topLayoutGuide and bottomLayoutGuide.
        return UIEdgeInsets(top: topInsetValue, left: 0, bottom: bottomInsetValue, right: 0)
    }

    fileprivate func handleSafeAreaInsetsDidChange() {
        // iOS 11 invalidates the view's layout when the safeAreaInsets change.
        self.setNeedsLayout()

        switch Pin.safeAreaInsetsDidChangeMode {
        case .optIn:
            if let updatable = self as? PinSafeAreaInsetsUpdate {
                updatable.safeAreaInsetsDidChange()
            }
        case .always:
            let methodName = "safeAreaInsetsDidChange"
            if let safeAreaInsetsDidChangeMethod = extractMethodFrom(owner: self, selector: Selector(methodName)) {
                safeAreaInsetsDidChangeMethod()
            }
        }
    }

    fileprivate func extractMethodFrom(owner: AnyObject, selector: Selector) -> (() -> Void)? {
        let method = owner is AnyClass ? class_getClassMethod(owner as! AnyClass, selector) :
                                         class_getInstanceMethod(type(of: owner), selector)
        guard method != nil else { return nil }
        let implementation = method_getImplementation(method)

        typealias Function = @convention(c) (AnyObject, Selector) -> Void
        let function = unsafeBitCast(implementation, to: Function.self)

        return { bool in function(owner, selector) }
    }
}
