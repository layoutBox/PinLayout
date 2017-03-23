//
//  Types.swift
//  MCSwiftLayout
//
//  Created by Luc Dion on 2017-03-22.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

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
}

public class Pin {
    internal  let view: UIView
    internal  let pinType: PinType

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

    fileprivate init(view: UIView, pinType: PinType) {
        self.view = view
        self.pinType = pinType
    }
}
