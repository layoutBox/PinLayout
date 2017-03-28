//
//  PinLayout.swift
//  MCSwiftLayout
//
//  Created by Luc Dion on 2017-03-28.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import UIKit

public extension UIView {
    public var pin: PinLayout {
        return PinLayoutImpl(view: self)
    }

    public var anchor: PinList {
        return PinList(view: self)
    }

    public var edge: EdgeList {
        return EdgeList(view: self)
    }
}

public protocol PinLayout {
    @discardableResult func top(_ value: CGFloat) -> PinLayout
    @discardableResult func left(_ value: CGFloat) -> PinLayout
    @discardableResult func bottom(_ value: CGFloat) -> PinLayout
    @discardableResult func right(_ value: CGFloat) -> PinLayout

    @discardableResult func top(to edge: VerticalEdge) -> PinLayout
    @discardableResult func left(to edge: HorizontalEdge) -> PinLayout
    @discardableResult func bottom(to edge: VerticalEdge) -> PinLayout
    @discardableResult func right(to edge: HorizontalEdge) -> PinLayout
    
    @discardableResult func topLeft(to point: CGPoint) -> PinLayout
    @discardableResult func topLeft(to pin: Pin) -> PinLayout
    @discardableResult func topLeft() -> PinLayout

    @discardableResult func topCenter(to point: CGPoint) -> PinLayout
    @discardableResult func topCenter(to pin: Pin) -> PinLayout
    @discardableResult func topCenter() -> PinLayout

    @discardableResult func topRight(to point: CGPoint) -> PinLayout
    @discardableResult func topRight(to pin: Pin) -> PinLayout
    @discardableResult func topRight() -> PinLayout

    @discardableResult func leftCenter(to point: CGPoint) -> PinLayout
    @discardableResult func leftCenter(to pin: Pin) -> PinLayout
    @discardableResult func leftCenter() -> PinLayout

    @discardableResult func center(to point: CGPoint) -> PinLayout
    @discardableResult func center(to pin: Pin) -> PinLayout
    @discardableResult func center() -> PinLayout

    @discardableResult func rightCenter(to point: CGPoint) -> PinLayout
    @discardableResult func rightCenter(to pin: Pin) -> PinLayout
    @discardableResult func rightCenter() -> PinLayout

    @discardableResult func bottomLeft(to point: CGPoint) -> PinLayout
    @discardableResult func bottomLeft(to pin: Pin) -> PinLayout
    @discardableResult func bottomLeft() -> PinLayout

    @discardableResult func bottomCenter(to point: CGPoint) -> PinLayout
    @discardableResult func bottomCenter(to pin: Pin) -> PinLayout
    @discardableResult func bottomCenter() -> PinLayout

    @discardableResult func bottomRight(to point: CGPoint) -> PinLayout
    @discardableResult func bottomRight(to pin: Pin) -> PinLayout
    @discardableResult func bottomRight() -> PinLayout

    @discardableResult func above(of relativeView: UIView) -> PinLayout
    @discardableResult func above(of relativeView: UIView, aligned: HorizontalAlignment) -> PinLayout
    @discardableResult func below(of relativeView: UIView) -> PinLayout
    @discardableResult func below(of relativeView: UIView, aligned: HorizontalAlignment) -> PinLayout
    @discardableResult func left(of relativeView: UIView) -> PinLayout
    @discardableResult func left(of relativeView: UIView, aligned: VerticalAlignment) -> PinLayout
    @discardableResult func right(of relativeView: UIView) -> PinLayout
    @discardableResult func right(of relativeView: UIView, aligned: VerticalAlignment) -> PinLayout

    @discardableResult func width(_ width: CGFloat) -> PinLayout
    @discardableResult func width(percent: CGFloat) -> PinLayout
    @discardableResult func width(of view: UIView) -> PinLayout
    @discardableResult func height(_ height: CGFloat) -> PinLayout
    @discardableResult func height(percent: CGFloat) -> PinLayout
    @discardableResult func height(of view: UIView) -> PinLayout
    @discardableResult func size(_ size: CGSize) -> PinLayout
    @discardableResult func size(of view: UIView) -> PinLayout
    @discardableResult func sizeToFit() -> PinLayout

    @discardableResult func margin(_ value: CGFloat) -> PinLayout
    @discardableResult func marginHorizontal(_ value: CGFloat) -> PinLayout
    @discardableResult func marginVertical(_ value: CGFloat) -> PinLayout
    @discardableResult func marginTop(_ value: CGFloat) -> PinLayout
    @discardableResult func marginLeft(_ value: CGFloat) -> PinLayout
    @discardableResult func marginBottom(_ value: CGFloat) -> PinLayout
    @discardableResult func marginRight(_ value: CGFloat) -> PinLayout

    @discardableResult func inset(_ value: CGFloat) -> PinLayout
    @discardableResult func insetTop(_ value: CGFloat) -> PinLayout
    @discardableResult func insetLeft(_ value: CGFloat) -> PinLayout
    @discardableResult func insetBottom(_ value: CGFloat) -> PinLayout
    @discardableResult func insetRight(_ value: CGFloat) -> PinLayout
    @discardableResult func insetHorizontal(_ value: CGFloat) -> PinLayout
    @discardableResult func insetVertical(_ value: CGFloat) -> PinLayout
}

// RELATIVE POSITION
public enum HorizontalAlignment: String {
    case left
    case center
    case right
}

public enum VerticalAlignment: String {
    case top
    case center
    case bottom
}


