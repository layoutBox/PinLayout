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

typealias Context = () -> String
typealias Size = (width: CGFloat?, height: CGFloat?)

public class EdgeList {
    internal  let view: UIView

    init(view: UIView) {
        self.view = view
    }

    public var top: VerticalEdge { return VerticalEdge(view: view, edgeType: .top) }
    public var left: HorizontalEdge { return HorizontalEdge(view: view, edgeType: .left) }
    public var bottom: VerticalEdge { return VerticalEdge(view: view, edgeType: .bottom) }
    public var right: HorizontalEdge { return HorizontalEdge(view: view, edgeType: .right) }
}

public enum EdgeType: String {
    case top
    case left
    case bottom
    case right

    func point(for view: UIView) -> CGPoint {
        switch self {
        case .top: return CGPoint(x: 0, y: view.frame.origin.y)
        case .left: return CGPoint(x: view.frame.origin.x, y: 0)
        case .bottom: return CGPoint(x: 0, y: Coordinates.bottom(view))
        case .right: return CGPoint(x: Coordinates.right(view), y: 0)
        }
    }
}

public class HorizontalEdge {
    internal let view: UIView
    internal let edgeType: EdgeType

    fileprivate init(view: UIView, edgeType: EdgeType) {
        self.view = view
        self.edgeType = edgeType
    }
}

public class VerticalEdge {
    internal let view: UIView
    internal let edgeType: EdgeType

    fileprivate init(view: UIView, edgeType: EdgeType) {
        self.view = view
        self.edgeType = edgeType
    }
}

public class PinList {
    internal let view: UIView

    init(view: UIView) {
        self.view = view
    }

    public var topLeft: Pin { return Pin(view: view, pinType: .topLeft) }
    public var topCenter: Pin { return Pin(view: view, pinType: .topCenter) }
    public var topRight: Pin { return Pin(view: view, pinType: .topRight) }
    public var leftCenter: Pin { return Pin(view: view, pinType: .leftCenter) }
    public var center: Pin { return Pin(view: view, pinType: .center) }
    public var rightCenter: Pin { return Pin(view: view, pinType: .rightCenter) }
    public var bottomLeft: Pin { return Pin(view: view, pinType: .bottomLeft) }
    public var bottomCenter: Pin { return Pin(view: view, pinType: .bottomCenter) }
    public var bottomRight: Pin { return Pin(view: view, pinType: .bottomRight) }
}

enum PinType: String {
    case topLeft
    case topCenter
    case topRight
    case leftCenter
    case center
    case rightCenter
    case bottomLeft
    case bottomCenter
    case bottomRight

    func point(for view: UIView) -> CGPoint {
        switch self {
        case .topLeft: return Coordinates.topLeft(view)
        case .topCenter: return Coordinates.topCenter(view)
        case .topRight: return Coordinates.topRight(view)
        case .leftCenter: return Coordinates.leftCenter(view)
        case .center: return Coordinates.center(view)
        case .rightCenter: return Coordinates.rightCenter(view)
        case .bottomLeft: return Coordinates.bottomLeft(view)
        case .bottomCenter: return Coordinates.bottomCenter(view)
        case .bottomRight: return Coordinates.bottomRight(view)
        }
    }
}

public class Pin {
    let view: UIView
    let pinType: PinType

    /* var x: CGFloat {
     return point.x
     }

     var y: CGFloat {
     return point.y
     }*/

    /*var point: CGPoint {
     switch pinType {
     case .topLeft: return view.topLeft
     case .topCenter: return view.topCenter
     case .topRight: return view.topRight
     case .leftCenter: return view.leftCenter
     case .center: return view.center
     case .rightCenter: return view.rightCenter
     case .bottomLeft: return view.bottomLeft
     case .bottomCenter: return view.bottomCenter
     case .bottomRight: return view.bottomRight
     }
     }*/

    init(view: UIView, pinType: PinType) {
        self.view = view
        self.pinType = pinType
    }
}
