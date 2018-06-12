//
//  View+Rect.swift
//  PinLayout-iOS
//
//  Created by Luc Dion on 2018-06-08.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

extension UIView {
    public func getRect(keepTransform: Bool) -> CGRect {
        if keepTransform {
            /*
             To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
             view's transform (UIView.transform).
             By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
             the view's transform. So view's transforms won't be affected/altered by PinLayout.
             */
            let size = bounds.size
            // See setRect(...) for details about this calculation.
            let origin = CGPoint(x: center.x - (size.width * layer.anchorPoint.x),
                                 y: center.y - (size.height * layer.anchorPoint.y))

            return CGRect(origin: origin, size: size)
        } else {
            return frame
        }
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        let adjustedRect = Coordinates<View>.adjustRectToDisplayScale(rect)

        if keepTransform {
            /*
             To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
             view's transform (UIView.transform).
             By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
             the view's transform. So view's transforms won't be affected/altered by PinLayout.
             */

            // NOTE: The center is offset by the layer.anchorPoint, so we have to take it into account.
            center = CGPoint(x: adjustedRect.origin.x + (adjustedRect.width * layer.anchorPoint.x),
                             y: adjustedRect.origin.y + (adjustedRect.height * layer.anchorPoint.y))
            // NOTE: We must set only the bounds's size and keep the origin.
            bounds.size = adjustedRect.size
        } else {
            frame = adjustedRect
        }
    }
}
#else

import AppKit

extension NSView {
    public func getRect(keepTransform: Bool) -> CGRect {
        if let superview = superview, !superview.isFlipped {
            var flippedRect = frame
            flippedRect.origin.y = superview.frame.height - flippedRect.height - flippedRect.origin.y
            return flippedRect
        } else {
            return frame
        }
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        let adjustedRect = Coordinates<View>.adjustRectToDisplayScale(rect)

        if let superview = superview, !superview.isFlipped {
            var flippedRect = adjustedRect
            flippedRect.origin.y = superview.frame.height - flippedRect.height - flippedRect.origin.y
            frame = flippedRect
        } else {
            frame = adjustedRect
        }
    }
}
#endif
