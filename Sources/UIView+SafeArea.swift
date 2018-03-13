// Copyright (c) 2016, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import UIKit
import ObjectiveC

internal class PinSafeArea {
    internal static var isEnabledCompatibilitySafeAreaInsets = false

    internal static func enableCompatibilitySafeArea() {
        if #available(iOS 11.0, *) {
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
        if #available(iOS 11.0, *) { assertionFailure() }

        self.swizzled_viewWillLayoutSubviews()
        let safeAreaInsets = UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: bottomLayoutGuide.length, right: 0)
        view.assignSafeAreaInsetsRecursively(insets: safeAreaInsets)
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var compatibilitySafeAreaInsets = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }

    private(set) var compatibilitySafeAreaInsets: UIEdgeInsets {
        get {
            if #available(iOS 11.0, *) { assertionFailure() }
            return objc_getAssociatedObject(self, &AssociatedKeys.compatibilitySafeAreaInsets) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            if #available(iOS 11.0, *) { assertionFailure() }
            let didChange: Bool = compatibilitySafeAreaInsets != newValue
            objc_setAssociatedObject(self, &AssociatedKeys.compatibilitySafeAreaInsets, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if didChange {
                callSafeAreaInsetsDidChange()
            }
        }
    }

    fileprivate func assignSafeAreaInsetsRecursively(insets: UIEdgeInsets) {
        if #available(iOS 11.0, *) { assertionFailure() }
        compatibilitySafeAreaInsets = insets

        for subview in subviews {
            guard !(self is UIScrollView) else { return }
            let topSafeInsetValue = max(insets.top - subview.frame.origin.y, 0)
            let leftSafeInsetValue = max(insets.left - subview.frame.origin.x, 0)
            let bottomSafeInsetValue = max((subview.frame.origin.y + subview.frame.size.height) - bounds.size.height - insets.bottom, 0)
            let rightSafeInsetValue = max((subview.frame.origin.x + subview.frame.size.width) - bounds.size.width - insets.right, 0)
            let subviewSafeAreaInsets = UIEdgeInsets(top: topSafeInsetValue, left: leftSafeInsetValue, bottom: bottomSafeInsetValue, right: rightSafeInsetValue)

            subview.assignSafeAreaInsetsRecursively(insets: subviewSafeAreaInsets)
        }
    }

    fileprivate func callSafeAreaInsetsDidChange() {
        let methodName = "safeAreaInsetsDidChange"
        if let safeAreaInsetsDidChangeMethod = extractMethodFrom(owner: self, selector: Selector(methodName)) {
            safeAreaInsetsDidChangeMethod()
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
