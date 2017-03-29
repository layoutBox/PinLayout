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

public enum HorizontalEdgeType: String {
    case left
    case right
}

public enum VerticalEdgeType: String {
    case top
    case bottom
}

public class EdgeList {
    internal  let view: UIView

    init(view: UIView) {
        self.view = view
    }

    public var top: VerticalEdge { return VerticalEdge(view: view, type: .top) }
    public var left: HorizontalEdge { return HorizontalEdge(view: view, type: .left) }
    public var bottom: VerticalEdge { return VerticalEdge(view: view, type: .bottom) }
    public var right: HorizontalEdge { return HorizontalEdge(view: view, type: .right) }
}

public class HorizontalEdge {
    internal let view: UIView
    internal let type: HorizontalEdgeType

    var value: CGFloat {
        switch type {
        case .left: return view.frame.origin.x
        case .right: return Coordinates.right(view)
        }
    }

    internal init(view: UIView, type: HorizontalEdgeType) {
        self.view = view
        self.type = type
    }
}

public class VerticalEdge {
    internal let view: UIView
    internal let type: VerticalEdgeType

    var value: CGFloat {
        switch type {
        case .top: return view.frame.origin.y
        case .bottom: return Coordinates.bottom(view)
        }
    }

    internal init(view: UIView, type: VerticalEdgeType) {
        self.view = view
        self.type = type
    }
}

public class AnchorList {
    internal let view: UIView

    internal init(view: UIView) {
        self.view = view
    }

    public var topLeft: Anchor { return Anchor(view: view, type: .topLeft) }
    public var topCenter: Anchor { return Anchor(view: view, type: .topCenter) }
    public var topRight: Anchor { return Anchor(view: view, type: .topRight) }
    public var leftCenter: Anchor { return Anchor(view: view, type: .leftCenter) }
    public var center: Anchor { return Anchor(view: view, type: .center) }
    public var rightCenter: Anchor { return Anchor(view: view, type: .rightCenter) }
    public var bottomLeft: Anchor { return Anchor(view: view, type: .bottomLeft) }
    public var bottomCenter: Anchor { return Anchor(view: view, type: .bottomCenter) }
    public var bottomRight: Anchor { return Anchor(view: view, type: .bottomRight) }
}

enum AnchorType: String {
    case topLeft
    case topCenter
    case topRight
    case leftCenter
    case center
    case rightCenter
    case bottomLeft
    case bottomCenter
    case bottomRight
}

public class Anchor {
    let view: UIView
    let type: AnchorType

    var point: CGPoint {
        switch type {
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

    fileprivate init(view: UIView, type: AnchorType) {
        self.view = view
        self.type = type
    }
}
