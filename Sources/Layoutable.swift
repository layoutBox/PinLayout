//
//  Layoutable.swift
//  PinLayout
//
//  Created by Antoine Lamy on 2018-06-11.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

public protocol Layoutable: AnyObject, Equatable {
    associatedtype View: Layoutable

    var superview: View? { get }
    var subviews: [View] { get }

    func getRect(keepTransform: Bool) -> CGRect
    func setRect(_ rect: CGRect, keepTransform: Bool)

    func sizeThatFits(_ size: CGSize) -> CGSize
    func sizeToFit()

    func convert(_ point: CGPoint, toView view: View) -> CGPoint

    func isLTR() -> Bool
}

extension Layoutable {
    public var pin: PinLayout<View> {
        return PinLayout(view: self as! Self.View, keepTransform: true)
    }

    public var pinFrame: PinLayout<View> {
        return PinLayout(view: self as! Self.View, keepTransform: false)
    }

    public var anchor: AnchorList {
        return AnchorListImpl(view: self as! View)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self as! View)
    }
}
