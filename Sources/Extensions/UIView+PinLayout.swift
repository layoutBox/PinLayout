//  Copyright (c) 2018 Luc Dion
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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

extension UIView: Layoutable, SizeCalculable {
    public typealias View = UIView

    public var pin: PinLayout<UIView> {
        return PinLayout(view: self, keepTransform: true)
    }

    public var pinFrame: PinLayout<UIView> {
        return PinLayout(view: self, keepTransform: false)
    }

    @objc public var pinObjc: PinLayoutObjC {
        return PinLayoutObjCImpl(view: self, keepTransform: true)
    }

    public func getRect(keepTransform: Bool) -> CGRect {
        return layer.getRect(keepTransform: keepTransform)
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        layer.setRect(rect, keepTransform: keepTransform)
    }

    public func isLTR() -> Bool {
        switch Pin.layoutDirection {
        case .auto:
            if #available(iOS 9.0, *) {
                return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight
            } else if let shared = UIApplication.value(forKey: "sharedApplication") as? UIApplication {
                return shared.userInterfaceLayoutDirection == .leftToRight
            } else {
                return true
            }
        case .ltr: return true
        case .rtl: return false
        }
    }
}

#endif
