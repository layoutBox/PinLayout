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

import UIKit

internal class Coordinates {
    static func top(_ view: UIView) -> CGFloat {
        return view.frame.minY
    }

    static func left(_ view: UIView) -> CGFloat {
        return view.frame.minX
    }

    static func bottom(_ view: UIView) -> CGFloat {
        return view.frame.maxY
    }

    static func right(_ view: UIView) -> CGFloat {
        return view.frame.maxX
    }

    static func hCenter(_ view: UIView) -> CGFloat {
        return view.frame.minX + (view.frame.width / 2)
    }

    static func vCenter(_ view: UIView) -> CGFloat {
        return view.frame.minY + (view.frame.height / 2)
    }

//    static func size(_ view: UIView) -> CGSize {
//        return view.frame.size
//    }
//    static func width(_ view: UIView) -> CGFloat {
//        return view.frame.width
//    }
//
//    static func height(_ view: UIView) -> CGFloat {
//        return view.frame.height
//    }

    static func topLeft(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX, y: view.frame.minY)
    }

    static func topCenter(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: view.frame.minY)
    }

    static func topRight(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX + view.frame.width, y: view.frame.minY)
    }

    static func rightCenter(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX + view.frame.width, y: vCenter(view))
    }

    static func center(_ view: UIView) -> CGPoint {
        return CGPoint(x: hCenter(view), y: vCenter(view))
    }

    static func leftCenter(_ view: UIView) -> CGPoint {
        return CGPoint(x: view.frame.minX, y: vCenter(view))
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

    static let displayScale = UIScreen.main.scale

    static func adjustRectToDisplayScale(_ rect: CGRect) -> CGRect {
        return  CGRect(x: ceilFloatToDisplayScale(rect.origin.x),
                       y: ceilFloatToDisplayScale(rect.origin.y),
                       width: ceilFloatToDisplayScale(rect.size.width),
                       height: ceilFloatToDisplayScale(rect.size.height))
    }

    static func roundFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return (round(pointValue * displayScale) / displayScale)
    }

    static func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return (round(pointValue * displayScale) / displayScale)
    }
}
