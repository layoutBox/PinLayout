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

typealias Context = () -> String
typealias Size = (width: CGFloat?, height: CGFloat?)


class EdgeListImpl: EdgeList {
    internal let view: UIView

    init(view: UIView) {
        self.view = view
    }

    var top: VerticalEdge { return VerticalEdgeImpl(view: view, type: .top) }
    var vCenter: VerticalEdge { return VerticalEdgeImpl(view: view, type: .vCenter) }
    var bottom: VerticalEdge { return VerticalEdgeImpl(view: view, type: .bottom) }

    var left: HorizontalEdge { return HorizontalEdgeImpl(view: view, type: .left) }
    var hCenter: HorizontalEdge { return HorizontalEdgeImpl(view: view, type: .hCenter) }
    var right: HorizontalEdge { return HorizontalEdgeImpl(view: view, type: .right) }
    
    // RTL support
    var start: HorizontalEdge { return view.isLTR() ? left : right }
    var end: HorizontalEdge { return view.isLTR() ? right : left }
}

class HorizontalEdgeImpl: HorizontalEdge {
    enum EdgeType: String {
        case left
        case hCenter
        case right
    }

    let view: UIView
    let type: EdgeType

    var x: CGFloat {
        switch type {
        case .left:    return view.frame.origin.x
        case .hCenter: return view.frame.midX
        case .right:   return view.frame.maxX
        }
    }

    internal init(view: UIView, type: EdgeType) {
        self.view = view
        self.type = type
    }
}

class VerticalEdgeImpl: VerticalEdge {
    enum EdgeType: String {
        case top
        case vCenter
        case bottom
    }
    
    internal let view: UIView
    internal let type: EdgeType

    var y: CGFloat {
        switch type {
        case .top:     return view.frame.origin.y
        case .vCenter: return view.frame.midY
        case .bottom:  return view.frame.maxY
        }
    }

    internal init(view: UIView, type: EdgeType) {
        self.view = view
        self.type = type
    }
}

class AnchorListImpl: AnchorList {
    internal let view: UIView

    internal init(view: UIView) {
        self.view = view
    }

    var topLeft: Anchor { return AnchorImpl(view: view, type: .topLeft) }
    var topCenter: Anchor { return AnchorImpl(view: view, type: .topCenter) }
    var topRight: Anchor { return AnchorImpl(view: view, type: .topRight) }
    var centerLeft: Anchor { return AnchorImpl(view: view, type: .centerLeft) }
    var center: Anchor { return AnchorImpl(view: view, type: .center) }
    var centerRight: Anchor { return AnchorImpl(view: view, type: .centerRight) }
    var bottomLeft: Anchor { return AnchorImpl(view: view, type: .bottomLeft) }
    var bottomCenter: Anchor { return AnchorImpl(view: view, type: .bottomCenter) }
    var bottomRight: Anchor { return AnchorImpl(view: view, type: .bottomRight) }

    // RTL support
    var topStart: Anchor { return view.isLTR() ? topLeft : topRight }
    var topEnd: Anchor { return view.isLTR() ? topRight : topLeft }
    var centerStart: Anchor { return view.isLTR() ? centerLeft : centerRight }
    var centerEnd: Anchor { return view.isLTR() ? centerRight : centerLeft }
    var bottomStart: Anchor { return view.isLTR() ? bottomLeft : bottomRight }
    var bottomEnd: Anchor { return view.isLTR() ? bottomRight : bottomLeft }
}

enum AnchorType: String {
    case topLeft
    case topCenter
    case topRight
    case centerLeft
    case center
    case centerRight
    case bottomLeft
    case bottomCenter
    case bottomRight
}

class AnchorImpl: Anchor {
    let view: UIView
    let type: AnchorType

    var point: CGPoint {
        switch type {
        case .topLeft: return Coordinates.topLeft(view)
        case .topCenter: return Coordinates.topCenter(view)
        case .topRight: return Coordinates.topRight(view)
        case .centerLeft: return Coordinates.centerLeft(view)
        case .center: return Coordinates.center(view)
        case .centerRight: return Coordinates.centerRight(view)
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

extension Percent: CustomStringConvertible {
    func of(_ rhs: CGFloat) -> CGFloat {
        return rhs * value / 100
    }
    public var description: String {
        return "\(value)%"
    }
}

#endif
