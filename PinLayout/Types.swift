//
//  Types.swift
//  PinLayout
//
//  Created by Luc Dion on 2017-03-22.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

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
