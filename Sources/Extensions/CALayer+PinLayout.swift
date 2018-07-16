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

import QuartzCore

extension CALayer: Layoutable {
    public typealias View = CALayer

    public var superview: CALayer? {
        return superlayer
    }

    public var subviews: [CALayer] {
        return sublayers ?? []
    }

    public var pin: PinLayout<CALayer> {
        return PinLayout(view: self, keepTransform: true)
    }

    public var pinFrame: PinLayout<CALayer> {
        return PinLayout(view: self, keepTransform: false)
    }

    public func getRect(keepTransform: Bool) -> CGRect {
        if keepTransform {
            /*
             To adjust the layer's position and size, we don't set the layer's frame directly, because we want to keep the
             layer's transform.
             By setting the layer's center and bounds we really set the frame of the non-transformed layer, and this keep
             the layer's transform. So layer's transforms won't be affected/altered by PinLayout.
             */
            let size = bounds.size
            // See setRect(...) for details about this calculation.
            let origin = CGPoint(x: position.x - (size.width * anchorPoint.x),
                                 y: position.y - (size.height * anchorPoint.y))

            return CGRect(origin: origin, size: size)
        } else {
            return frame
        }
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        let adjustedRect = Coordinates<View>.adjustRectToDisplayScale(rect)

        if keepTransform {
            /*
             To adjust the layer's position and size, we don't set the layer's frame directly, because we want to keep the
             layer's transform.
             By setting the layer's center and bounds we really set the frame of the non-transformed layer, and this keep
             the layer's transform. So layer's transforms won't be affected/altered by PinLayout.
             */

            // NOTE: The center is offset by the layer.anchorPoint, so we have to take it into account.
            position = CGPoint(x: adjustedRect.origin.x + (adjustedRect.width * anchorPoint.x),
                               y: adjustedRect.origin.y + (adjustedRect.height * anchorPoint.y))
            // NOTE: We must set only the bounds's size and keep the origin.
            bounds.size = adjustedRect.size
        } else {
            frame = adjustedRect
        }
    }

    public func isLTR() -> Bool {
        switch Pin.layoutDirection {
        case .auto: return true
        case .ltr:  return true
        case .rtl:  return false
        }
    }
}
