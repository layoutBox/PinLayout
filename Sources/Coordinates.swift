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
        return view.frame.minX + (view.frame.width / 2)
    }

    static func vCenter(_ view: UIView) -> CGFloat {
        return view.frame.minY + (view.frame.height / 2)
    }

    static func topLeft(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX, y: view.frame.minY)
    }

    static func topCenter(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: view.frame.minY)
    }

    static func topRight(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX + view.frame.width, y: view.frame.minY)
    }

    static func centerLeft(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX, y: vCenter(view))
    }
    
    static func center(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: vCenter(view))
    }

    static func centerRight(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX + view.frame.width, y: vCenter(view))
    }
    
    static func bottomLeft(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX, y: view.frame.minY + view.frame.height)
    }

    static func bottomCenter(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: view.frame.minY + view.frame.height)
    }

    static func bottomRight(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX + view.frame.width, y: view.frame.minY + view.frame.height)
    }

    internal static var displayScale: CGFloat = UIScreen.main.scale

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

#endif
