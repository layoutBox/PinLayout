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

internal var displayScale: CGFloat = getDisplayScale()
internal var onePixelLength: CGFloat = 1 / displayScale

public func _pinlayoutSetUnitTest(scale: CGFloat?) {
    if let scale = scale {
        displayScale = scale
    } else {
        displayScale = getDisplayScale()
    }
}

final class Coordinates<View: Layoutable> {
    static func hCenter(_ view: View, keepTransform: Bool) -> CGFloat {
        let rect = view.getRect(keepTransform: keepTransform)
        return rect.minX + (rect.width / 2)
    }

    static func vCenter(_ view: View, keepTransform: Bool) -> CGFloat {
        let rect = view.getRect(keepTransform: keepTransform)
        return rect.minY + (rect.height / 2)
    }

    static func topLeft(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX, y: rect.minY)
    }

    static func topCenter(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + (rect.width / 2), y: rect.minY)
    }

    static func topRight(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + rect.width, y: rect.minY)
    }

    static func centerLeft(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX, y: rect.minY + (rect.height / 2))
    }
    
    static func center(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + (rect.width / 2), y: rect.minY + (rect.height / 2))
    }

    static func centerRight(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + rect.width, y: rect.minY + (rect.height / 2))
    }
    
    static func bottomLeft(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX, y: rect.minY + rect.height)
    }

    static func bottomCenter(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + (rect.width / 2), y: rect.minY + rect.height)
    }

    static func bottomRight(_ view: View, keepTransform: Bool) -> CGPoint {
        let rect = view.getRect(keepTransform: keepTransform)
        return CGPoint(x: rect.minX + rect.width, y: rect.minY + rect.height)
    }

    static func adjustRectToDisplayScale(_ rect: CGRect) -> CGRect {
        return CGRect(x: roundFloatToDisplayScale(rect.origin.x),
                      y: roundFloatToDisplayScale(rect.origin.y),
                      width: ceilFloatToDisplayScale(rect.size.width),
                      height: ceilFloatToDisplayScale(rect.size.height))
    }

    static func roundFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(roundf(Float(pointValue * displayScale))) / displayScale
    }

    static func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return CGFloat(ceilf(Float(pointValue * displayScale))) / displayScale
    }
}

private func getDisplayScale() -> CGFloat {
    #if os(iOS) || os(tvOS)
        return UIScreen.main.scale
    #elseif os(OSX)
        #if swift(>=4.1)
        return NSScreen.main?.backingScaleFactor ?? 2.0
        #else
        return NSScreen.main()?.backingScaleFactor ?? 2.0
        #endif
    #endif
}
