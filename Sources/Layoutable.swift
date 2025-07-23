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

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol Layoutable: AnyObject, Equatable, CustomDebugStringConvertible {
    associatedtype PinView: Layoutable

    var superview: PinView? { get }
    var subviews: [PinView] { get }

    func getRect(keepTransform: Bool) -> CGRect
    func setRect(_ rect: CGRect, keepTransform: Bool)

    func convert(_ point: CGPoint, to view: PinView?) -> CGPoint

    func isLTR() -> Bool
}

private struct pinlayoutAssociatedKeys {
    static var pinlayoutIsIncludedInSizeCalculation = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
}

extension Layoutable {

    var isIncludedInSizeCalculation: Bool {
        get {
            return objc_getAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutIsIncludedInSizeCalculation) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutIsIncludedInSizeCalculation, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var subviewsIncludedInSizeCalculation: [PinView] {
        return subviews.filter(\.isIncludedInSizeCalculation)
    }
}
