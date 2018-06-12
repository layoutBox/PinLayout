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

    func convert(_ point: CGPoint, toView view: View) -> CGPoint

    func isLTR() -> Bool
}
