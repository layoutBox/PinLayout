//
//  View.swift
//  MCSwiftLayout
//
//  Created by Luc Dion on 2017-03-22.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

internal class Coordinates {
//    static func top(_ view: UIView) -> CGFloat {
//        return view.frame.origin.y
//    }
//
//    static func left(_ view: UIView) -> CGFloat {
//        return view.frame.origin.x
//    }

    static func bottom(_ view: UIView) -> CGFloat {
        return view.frame.maxY
    }

    static func right(_ view: UIView) -> CGFloat {
        return view.frame.maxX
    }

    static func hCenter(_ view: UIView) -> CGFloat {
        return view.frame.origin.x + (view.frame.size.width / 2)
    }

    static func vCenter(_ view: UIView) -> CGFloat {
        return view.frame.origin.y + (view.frame.size.height / 2)
    }

//    static func size(_ view: UIView) -> CGSize {
//        return view.frame.size
//    }
//    static func width(_ view: UIView) -> CGFloat {
//        return view.frame.size.width
//    }
//
//    static func height(_ view: UIView) -> CGFloat {
//        return view.frame.size.height
//    }

    static func topLeft(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x, y: view.frame.origin.y)
    }

    static func topCenter(_ view: UIView) ->  CGPoint {
        return CGPoint(x: hCenter(view), y: view.frame.origin.y)
    }

    static func topRight(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x + view.frame.size.width, y: view.frame.origin.y)
    }

    static func rightCenter(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x + view.frame.size.width, y: vCenter(view))
    }

    static func center(_ view: UIView) ->  CGPoint {
        return CGPoint(x: hCenter(view), y: vCenter(view))
    }

    static func leftCenter(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x, y: vCenter(view))
    }

    static func bottomLeft(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + view.frame.size.height)
    }

    static func bottomCenter(_ view: UIView) ->  CGPoint {
        return CGPoint(x: hCenter(view), y: view.frame.origin.y + view.frame.size.height)
    }

    static func bottomRight(_ view: UIView) ->  CGPoint {
        return CGPoint(x: view.frame.origin.x + view.frame.size.width, y: view.frame.origin.y + view.frame.size.height)
    }

    static let displayScale = UIScreen.main.scale

    static func adjustRectToDisplayScale(_ rect: CGRect) -> CGRect {
        return  CGRect(x: ceilFloatToDisplayScale(rect.origin.x),
                       y: ceilFloatToDisplayScale(rect.origin.y),
                       width: ceilFloatToDisplayScale(rect.size.width),
                       height: ceilFloatToDisplayScale(rect.size.height))
    }

    static func roundFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return (round(pointValue * displayScale) / displayScale)
    }

    static func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
        return (round(pointValue * displayScale) / displayScale)
    }
}
