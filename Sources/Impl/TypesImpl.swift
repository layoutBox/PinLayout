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

typealias Context = () -> String
typealias Size = (width: CGFloat?, height: CGFloat?)

extension HorizontalAlign {
    var description: String {
        switch self {
        case .left: return "left"
        case .center: return "center"
        case .right: return "right"
        case .start: return "start"
        case .end: return "end"
        }
    }
}

extension VerticalAlign {
    var description: String {
        switch self {
        case .top: return "top"
        case .center: return "center"
        case .bottom: return "bottom"
        }
    }
}
    
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

extension Percent {
    func of(_ rhs: CGFloat) -> CGFloat {
        return rhs * value / 100
    }
    public var description: String {
        if value.truncatingRemainder(dividingBy: 1) == 0.0 {
            return "\(Int(value))%"
        } else {
            return "\(value)%"
        }
    }
}
    
extension CGFloat {
    public var description: String {
        if self.truncatingRemainder(dividingBy: 1) == 0.0 {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
}
    
internal extension FitType {
    var name: String {
        switch self {
        case .width: return ".width"
        case .height: return ".height"
        case .widthFlexible: return ".widthFlexible"
        case .heightFlexible: return ".heightFlexible"
        }
    }
    
    var isFlexible: Bool {
        return self == .widthFlexible || self == .heightFlexible
    }
}

#endif
