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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

class Coordinates {
    static func hCenter(_ view: UIView) -> CGFloat {
        let rect = getUntransformedViewRect(view)
        return rect.minX + (rect.width / 2)
    }

    static func vCenter(_ view: UIView) -> CGFloat {
        let rect = getUntransformedViewRect(view)
        return rect.minY + (rect.height / 2)
    }

    static func topLeft(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX, y: rect.minY)
    }

    static func topCenter(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: hCenter(view), y: rect.minY)
    }

    static func topRight(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX + rect.width, y: rect.minY)
    }

    static func centerLeft(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX, y: vCenter(view))
    }
    
    static func center(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: vCenter(view))
    }

    static func centerRight(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX + rect.width, y: vCenter(view))
    }
    
    static func bottomLeft(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX, y: rect.minY + rect.height)
    }

    static func bottomCenter(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: hCenter(view), y: rect.minY + rect.height)
    }

    static func bottomRight(_ view: UIView) -> CGPoint {
        let rect = getUntransformedViewRect(view)
        return CGPoint(x: rect.minX + rect.width, y: rect.minY + rect.height)
    }

    internal static var displayScale: CGFloat = UIScreen.main.scale

    static func adjustRectToDisplayScale(_ rect: CGRect) -> CGRect {
        return CGRect(x: roundFloatToDisplayScale(rect.origin.x),
                      y: roundFloatToDisplayScale(rect.origin.y),
                      width: ceilFloatToDisplayScale(rect.size.width),
                      height: ceilFloatToDisplayScale(rect.size.height))
    }
    
    static func setUntransformedViewRect(_ view: UIView, toRect rect: CGRect) {
        /*
         To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
         view's transform (UIView.transform).
         By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
         the view's transform. So view's transforms won't be affected/altered by PinLayout.
         */
        let adjustedRect = Coordinates.adjustRectToDisplayScale(rect)
        view.center = CGPoint(x: adjustedRect.midX, y: adjustedRect.midY)
        view.bounds = CGRect(origin: .zero, size: adjustedRect.size)
    }
    
    static func getUntransformedViewRect(_ view: UIView) -> CGRect {
        /*
         To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
         view's transform (UIView.transform).
         By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
         the view's transform. So view's transforms won't be affected/altered by PinLayout.
         */
        let bounds = view.bounds
        let origin = CGPoint(x: view.center.x - bounds.width / 2, y: view.center.y - bounds.height / 2)

        return CGRect(origin: origin, size: bounds.size)
    }

    static func roundFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(roundf(Float(pointValue * displayScale))) / displayScale
    }

    static func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(ceilf(Float(pointValue * displayScale))) / displayScale
    }
}

#endif
