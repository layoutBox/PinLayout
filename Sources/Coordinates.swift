// Copyright (c) 2017, Mirego
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
