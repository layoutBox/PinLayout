//
//  UIView+PinLayout.swift
//  PinLayout
//
//  Created by Luc Dion on 2017-03-22.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import UIKit

// Could be part of another GitHub repo?
public extension UIView {
    public var top: CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(x: left, y: Coordinates.roundFloatToDisplayScale(newValue), width: width, height: height) }
    }
        
    public var left: CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(x: Coordinates.roundFloatToDisplayScale(newValue), y: top, width: width, height: height) }
    }
    
    public var bottom: CGFloat {
        get { return frame.maxY }
        set { height = Coordinates.roundFloatToDisplayScale(newValue - top) }
    }
    
    public var right: CGFloat {
        get { return frame.maxX }
        set { width = Coordinates.roundFloatToDisplayScale(newValue - left) }
    }

    public var hCenter: CGFloat {
        get { return left + (width / 2) }
        set { left = newValue - (width / 2) }
    }
    
    public var vCenter: CGFloat {
        get { return top + (height / 2) }
        set { top = newValue - (height / 2) }
    }
    
    /* public var topLeft: CGPoint {
        get { return CGPoint(x: left, y: top) }
        set {
            left = newValue.x
            top = newValue.y
        }
    }
    
    public var topCenter: CGPoint {
        get { return CGPoint(x: hCenter, y: top) }
        set {
            left = newValue.x - (width / 2)
            top = newValue.y
        }
    }
    
    public var topRight: CGPoint {
        get { return CGPoint(x: left + width, y: top) }
        set {
            left = newValue.x - width
            top = newValue.y
        }
    }
    
    public var rightCenter: CGPoint {
        get { return CGPoint(x: left + width, y: vCenter) }
        set {
            left = newValue.x - width
            top = newValue.y - (width / 2)
        }
    }
    
    public var centers: CGPoint {
        get { return CGPoint(x: hCenter, y: vCenter) }
        set {
            left = newValue.x - (width / 2)
            top = newValue.y - (width / 2)
        }
    }
    
    public var leftCenter: CGPoint {
        get { return CGPoint(x: left, y: vCenter) }
        set {
            left = newValue.x
            top = newValue.y - (width / 2)
        }
    }
    
    public var bottomLeft: CGPoint {
        get { return CGPoint(x: left, y: top + height) }
        set {
            left = newValue.x
            top = newValue.y - height
        }
    }
    
    public var bottomCenter: CGPoint {
        get { return CGPoint(x: hCenter, y: top + height) }
        set {
            left = newValue.x - (width / 2)
            top = newValue.y - height
        }
    }
    
    public var bottomRight: CGPoint {
        get { return CGPoint(x: left + width, y: top + height) }
        set {
            left = newValue.x - width
            top = newValue.y - height
        }
    } */
    
    public var size: CGSize {
        get { return CGSize(width: frame.size.width, height: frame.size.height) }
        set { frame = CGRect(x: frame.origin.x, y: frame.origin.y,
                             width: Coordinates.ceilFloatToDisplayScale(newValue.width),
                             height: Coordinates.ceilFloatToDisplayScale(newValue.height)) }
    }

    public var width: CGFloat {
        get { return frame.size.width }
        set { frame = CGRect(x: frame.origin.x, y: frame.origin.y,
                             width: Coordinates.ceilFloatToDisplayScale(newValue), height: height) }
    }
    
    public var height: CGFloat {
        get { return frame.size.height }
        set { frame = CGRect(x: frame.origin.x, y: frame.origin.y,
                             width: width, height: Coordinates.ceilFloatToDisplayScale(newValue)) }
    }
}
