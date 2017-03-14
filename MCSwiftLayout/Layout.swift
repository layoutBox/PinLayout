//
//  Layout.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-17.
//  Copyright © 2017 Mirego. All rights reserved.
//
import UIKit

/*
 
 ===============================================
 QUESTIONS:
 ===============================================
 
     - Names:
        Attach to a Pin of another
         - view.layout.topLeft(backgroundView.pin.bottomLeft).margin(10)
         - view.layout.pinTopLeft(backgroundView.pin.bottomLeft).margin(10)
         - equivalent to: view.layout.below(of: backgroundView, aligned: .left)
 
        Use a CGPoint
         - view.layout.topLeft(CGPoint(x: 10, y: 20)).margin(10)
         - view.layout.pinTopLeft(CGPoint(x: 10, y: 20)).margin(10)
 
        Attach related to its superview
         - view.layout.topLeft().margin(10)
         - view.layout.topLeftToSuperview().margin(10)
         - view.layout.pinTopLeftToSuperview().margin(10)
 
 
         - view.layout.pinTopLeft(.bottomLeft, of: backgroundView).margin(10)
         - view.layout.pinTopLeft(to: .bottomLeft, of: backgroundView).margin(10)
         - view.layout.pinTopLeft(to: backgroundView, .bottomLeft).margin(10)
         - view.layout.pinTopLeft(backgroundView, .bottomLeft).margin(10)
         - view.layout.pinTopLeft(equal: backgroundView, .bottomLeft).margin(10)
 
         - view.pin.topLeft(to: .bottomLeft, of: backgroundView).margin(10)
         - view.pin.topLeft(.bottomLeft, of: backgroundView).margin(10)
 
         - view.layout.snapTopLeft(.bottomLeft, of: backgroundView)
         - view.layout.snapTopLeft(to: .bottomLeft, of: backgroundView).margin(10)
         - view.layout.snapTopLeft(to: backgroundView, .bottomLeft).margin(10)
         - view.layout.snapTop(to: .bottom, of: backgroundView).margin(10)
         
         - layout.snapTopLeft(to: backgroundView, .bottomLeft)
         
         - layout.top(to: .bottom, of: backgroundView)

    - position related to superview
         - layout.bottomLeft().margin(10)
         - layout.bottomLeftOfSuperview().margin(10)

    - enum Snap ou Pin ou Point?
    - UIView.topLeft, .topRight, ... are not really necessary. Tout peut être accessible avec UIView.pin.point.
        eg: myView.topLeft -> myView.pin.topLeft.point OR myView.pin.topLeft.x & myView.pin.topLeft.y
 
 TODO:
 ===============================================
    - implement sizeThatFits
         - Insets should be applied to width and height before calling view.sizeThatFits()
 
    - Implement Layout + Layout operator
 
    - left(of), above(of), below(of), ... devrait fonctionner même si les des view n'ont pas le même parent!
        comme pour pinTopLeft(of), ...
    
    - width(percentage: CGFloat, of view: UIView)
    - maxWidth(), minWidth(), maxHeight(), minHeight()
 
    - marginHorizontal
    - marginVertical
    - insetHorizontal
    - insetVertical
    - inset(t:? = nil l:? = nil  b:? = nil  r:? = nil ) ??
    - margin(t:? = nil  l:? = nil  b:? = nil  r:? = nil ) ??

 */
fileprivate typealias Context = () -> String

public extension UIView {
    public var top: CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(x: left, y: roundFloatToDisplayScale(newValue), width: width, height: height) }
    }
        
    public var left: CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(x: roundFloatToDisplayScale(newValue), y:top, width: width, height: height) }
    }
    
    public var bottom: CGFloat {
        get { return frame.maxY }
        set { height = roundFloatToDisplayScale(newValue - top) }
    }
    
    public var right: CGFloat {
        get { return frame.maxX }
        set { width = roundFloatToDisplayScale(newValue - left) }
    }

    public var hCenter: CGFloat {
        get { return left + (width / 2) }
        set { left = newValue - (width / 2) }
    }
    
    public var vCenter: CGFloat {
        get { return top + (height / 2) }
        set { top = newValue - (height / 2) }
    }
    
    public var topLeft: CGPoint {
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
    }
    
    public var size: CGSize {
        get { return CGSize(width: width, height: height) }
        set { frame = CGRect(x: left, y: top, width: ceilFloatToDisplayScale(newValue.width), height: ceilFloatToDisplayScale(newValue.height)) }
    }
    
    public var width: CGFloat {
        get { return frame.size.width }
        set { frame = CGRect(x: left, y: top, width: ceilFloatToDisplayScale(newValue), height: height) }
    }
    
    public var height: CGFloat {
        get { return frame.size.height }
        set { frame = CGRect(x: left, y: top, width: width, height: ceilFloatToDisplayScale(newValue)) }
    }
}

public extension UIView {
    public var layout: Layout {
        return Layout(view: self)
    }
    
    func layout(with layout: Layout) {
        layout.apply(onView: self)
    }
}

public enum Pin: String {
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

public enum VerticalEdge: String {
    case top
    case bottom
}

public enum HorizontalEdge: String {
    case left
    case right
}

public class Layout {
    static var logConflicts = true
    //static var useBottomRightCssStyle = false

    fileprivate let view: UIView
    
    fileprivate var top: CGFloat?
    fileprivate var left: CGFloat?
    fileprivate var bottom: CGFloat?
    fileprivate var right: CGFloat?
    
    fileprivate var hCenter: CGFloat?
    fileprivate var vCenter: CGFloat?
    
    fileprivate var width: CGFloat?
    fileprivate var height: CGFloat?
    fileprivate var fitSize: CGSize?
    
    fileprivate var topMargin: CGFloat?
    fileprivate var leftMargin: CGFloat?
    fileprivate var bottomMargin: CGFloat?
    fileprivate var rightMargin: CGFloat?
    
    fileprivate var topInset: CGFloat?
    fileprivate var leftInset: CGFloat?
    fileprivate var bottomInset: CGFloat?
    fileprivate var rightInset: CGFloat?
    
    public init (view: UIView) {
        self.view = view
    }
    
    deinit {
        apply()
    }
    
    //
    // top, left, bottom, right
    //
    @discardableResult
    public func top(_ value: CGFloat) -> Layout {
        setTop(value, context: { return "top(\(value))" })
        return self
    }
    
    @discardableResult
    public func left(_ value: CGFloat) -> Layout {
        setLeft(value, context: { return "left(\(value))" })
        return self
    }
    
    @discardableResult
    public func bottom(_ value: CGFloat) -> Layout {
        setBottom(value, context: { return "bottom(\(value))" })
        return self
    }
    
    @discardableResult
    public func right(_ value: CGFloat) -> Layout {
        setRight(value, context: { return "right(\(value))" })
        return self
    }
    
    
    //
    // pinTop, pinLeft, pinBottom, pinRight
    //
    @discardableResult
    public func pinTop(_ edge: VerticalEdge, of relativeView: UIView) -> Layout {
        func context() -> String { return "pinTop(\(edge.rawValue), of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: edge, of: relativeView, context: context) {
            setTop(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinLeft(_ edge: HorizontalEdge, of relativeView: UIView) -> Layout {
        func context() -> String { return "pinLeft(\(edge.rawValue), of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: edge, of: relativeView, context: context) {
            setLeft(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinBottom(_ edge: VerticalEdge, of relativeView: UIView) -> Layout {
        func context() -> String { return "pinBottom(\(edge.rawValue), of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: edge, of: relativeView, context: context) {
            setBottom(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinRight(_ edge: HorizontalEdge, of relativeView: UIView) -> Layout {
        func context() -> String { return "pinRight(\(edge.rawValue), of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: edge, of: relativeView, context: context) {
            setRight(coordinate, context: context)
        }
        return self
    }
    
    //TODO: Add hCenter and vCenter
    
    //
    // pinTopLeft, pinTopCenter, pinTopRight,
    // pinLeftCenter, pinCenter, pinRightCenter,
    // pinBottomLeft, pinBottomCenter, pinBottomRight,
    //
    @discardableResult
    public func pinTopLeft(to point: CGPoint) -> Layout {
        return setTopLeft(point, context: { return "topLeft(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the topLeft on the specified view's pin.
    @discardableResult
    public func pinTopLeft(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "topLeft(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setTopLeft(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topLeft corner of the specified view.
    @discardableResult
    public func pinTopLeft(to relativeView: UIView) -> Layout {
        func context() -> String { return "topLeft(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .topLeft, of: relativeView, context: context) {
            setTopLeft(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topLeft corner of its parent.
    @discardableResult
    public func pinTopLeft() -> Layout {
        func context() -> String { return "topLeft()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .topLeft, of: layoutSuperview, context: context) {
                setTopLeft(coordinates, context: context)
            }
        }
        return self
    }
    
    @discardableResult
    public func pinTopCenter(to point: CGPoint) -> Layout {
        return setTopCenter(point, context: { return "topCenter(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the topCenter on the specified view's pin.
    @discardableResult
    public func pinTopCenter(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "topCenter(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setTopCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topCenter corner of the specified view.
    @discardableResult
    public func pinTopCenter(to relativeView: UIView) -> Layout {
        func context() -> String { return "topCenter(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .topCenter, of: relativeView, context: context) {
            setTopCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topCenter corner of its parent.
    @discardableResult
    public func pinTopCenter() -> Layout {
        func context() -> String { return "topCenter()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .topCenter, of: layoutSuperview, context: context) {
                setTopCenter(coordinates, context: context)
            }
        }
        return self
    }

    @discardableResult
    public func pinTopRight(to point: CGPoint) -> Layout {
        return setTopRight(point, context: { return "topRight(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the topRight on the specified view's pin.
    @discardableResult
    public func pinTopRight(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "topRight(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setTopRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topRight corner of the specified view.
    @discardableResult
    public func pinTopRight(to relativeView: UIView) -> Layout {
        func context() -> String { return "topRight(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .topRight, of: relativeView, context: context) {
            setTopRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topRight corner of its parent.
    @discardableResult
    public func pinTopRight() -> Layout {
        func context() -> String { return "topRight()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .topRight, of: layoutSuperview, context: context) {
                setTopRight(coordinates, context: context)
            }
        }
        return self
    }
    
    @discardableResult
    public func pinLeftCenter(to point: CGPoint) -> Layout {
        return setLeftCenter(point, context: { return "leftCenter(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the leftCenter on the specified view's pin.
    @discardableResult
    public func pinLeftCenter(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "leftCenter(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setLeftCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the leftCenter corner of the specified view.
    @discardableResult
    public func pinLeftCenter(to relativeView: UIView) -> Layout {
        func context() -> String { return "leftCenter(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .leftCenter, of: relativeView, context: context) {
            setLeftCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the leftCenter corner of its parent.
    @discardableResult
    public func pinLeftCenter() -> Layout {
        func context() -> String { return "leftCenter()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .leftCenter, of: layoutSuperview, context: context) {
                setLeftCenter(coordinates, context: context)
            }
        }
        return self
    }

    @discardableResult
    public func pinCenter(to point: CGPoint) -> Layout {
        return setCenter(point, context: { return "centers(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the centers on the specified view's pin.
    @discardableResult
    public func pinCenter(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "centers(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setCenter(coordinates, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinCenter(to relativeView: UIView) -> Layout {
        func context() -> String { return "centers(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: Pin.center, of: relativeView, context: context) {
            setCenter(coordinates, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinCenter() -> Layout {
        func context() -> String { return "center()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .center, of: layoutSuperview, context: context) {
                setCenter(coordinates, context: context)
            }
        }
        return self
    }
    
    @discardableResult
    public func pinRightCenter(to point: CGPoint) -> Layout {
        return setRightCenter(point, context: { return "rightCenter(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the rightCenter on the specified view's pin.
    @discardableResult
    public func pinRightCenter(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "rightCenter(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setRightCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the rightCenter corner of the specified view.
    @discardableResult
    public func pinRightCenter(to relativeView: UIView) -> Layout {
        func context() -> String { return "rightCenter(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .rightCenter, of: relativeView, context: context) {
            setRightCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the rightCenter corner of its parent.
    @discardableResult
    public func pinRightCenter() -> Layout {
        func context() -> String { return "rightCenter()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .rightCenter, of: layoutSuperview, context: context) {
                setRightCenter(coordinates, context: context)
            }
        }
        return self
    }
    
    @discardableResult
    public func pinBottomLeft(to point: CGPoint) -> Layout {
        return setBottomLeft(point, context: { return "bottomLeft(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the bottomLeft on the specified view's pin.
    @discardableResult
    public func pinBottomLeft(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "bottomLeft(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setBottomLeft(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomLeft corner of the specified view.
    @discardableResult
    public func pinBottomLeft(to relativeView: UIView) -> Layout {
        func context() -> String { return "bottomLeft(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: Pin.bottomLeft, of: relativeView, context: context) {
            setBottomLeft(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomLeft corner of its parent.
    @discardableResult
    public func pinBottomLeft() -> Layout {
        func context() -> String { return "bottomLeft()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .bottomLeft, of: layoutSuperview, context: context) {
                setBottomLeft(coordinates, context: context)
            }
        }
        return self
    }

    @discardableResult
    public func pinBottomCenter(to point: CGPoint) -> Layout {
        return setBottomCenter(point, context: { return "bottomCenter(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the bottomCenter on the specified view's pin.
    @discardableResult
    public func pinBottomCenter(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "bottomCenter(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setBottomCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomCenter corner of the specified view.
    @discardableResult
    public func pinBottomCenter(to relativeView: UIView) -> Layout {
        func context() -> String { return "bottomCenter(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: Pin.bottomCenter, of: relativeView, context: context) {
            setBottomCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomCenter corner of its parent.
    @discardableResult
    public func pinBottomCenter() -> Layout {
        func context() -> String { return "bottomCenter()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .bottomCenter, of: layoutSuperview, context: context) {
                setBottomCenter(coordinates, context: context)
            }
        }
        return self
    }

    @discardableResult
    public func pinBottomRight(to point: CGPoint) -> Layout {
        return setBottomRight(point, context: { return "bottomRight(CGPoint(x: \(point.x), y: \(point.y)))" })
    }
    
    /// Position the bottomRight on the specified view's pin.
    @discardableResult
    public func pinBottomRight(_ pin: Pin, of relativeView: UIView) -> Layout {
        func context() -> String { return "bottomRight(\(pin.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin, of: relativeView, context: context) {
            setBottomRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomRight corner of the specified view.
    @discardableResult
    public func pinBottomRight(to relativeView: UIView) -> Layout {
        func context() -> String { return "bottomRight(of: \(view))" }
        if let coordinates = computeCoordinates(forPin: .bottomRight, of: relativeView, context: context) {
            setBottomRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomRight corner of its parent.
    @discardableResult
    public func pinBottomRight() -> Layout {
        func context() -> String { return "bottomRight()" }
        if let layoutSuperview = validateLayoutSuperview(context: context) {
            if let coordinates = computeCoordinates(forPin: .bottomRight, of: layoutSuperview, context: context) {
                setBottomRight(coordinates, context: context)
            }
        }
        return self
    }

    // RELATIVE POSITION
    public enum HorizontalAlignment {
        case left
        case center
        case right
    }
    
    public enum VerticalAlignment {
        case top
        case center
        case bottom
    }
    
    /// Set the view's bottom coordinate above of the specified view.
    @discardableResult
    public func above(of view: UIView) -> Layout {
        setBottom(view.top, context: { return "above(of: \(view))" })
        return self
    }
    @discardableResult
    public func above(of view: UIView, aligned: HorizontalAlignment) -> Layout {
        switch aligned {
        case .left:   return setBottomLeft(view.topLeft, context: { return "above(of: \(view), aligned: .left)" })
        case .center: return setBottomCenter(view.topCenter, context: { return "above(of: \(view), aligned: .center)" })
        case .right:  return setBottomRight(view.topRight, context: { return "above(of: \(view), aligned: .right)" })
        }
    }
    
    /// Set the view's top coordinate below of the specified view.
    @discardableResult
    public func below(of view: UIView) -> Layout {
        setTop(view.bottom, context: { return "below(of: \(view))" })
        return self
    }
    
    @discardableResult
    public func below(of view: UIView, aligned: HorizontalAlignment) -> Layout {
        switch aligned {
        case .left:   return setTopLeft(view.bottomLeft, context: { return "below(of: \(view), aligned: .left)" })
        case .center: return setTopCenter(view.bottomCenter, context: { return "below(of: \(view), aligned: .center)" })
        case .right:  return setTopRight(view.bottomRight, context: { return "below(of: \(view), aligned: .right)" })
        }
    }
    
    /// Set the view's right coordinate left of the specified view.
    @discardableResult
    public func left(of view: UIView) -> Layout {
        setRight(view.left, context: { return "left(of: \(view))" })
        return self
    }
    
    @discardableResult
    public func left(of view: UIView, aligned: VerticalAlignment) -> Layout {
        switch aligned {
        case .top:    return setTopRight(view.topLeft, context: { return "left(of: \(view), aligned: .top)" })
        case .center: return setRightCenter(view.leftCenter, context: { return "left(of: \(view), aligned: .center)" })
        case .bottom: return setBottomRight(view.bottomLeft, context: { return "left(of: \(view), aligned: .bottom)" })
        }
    }
    
    /// Set the view's left coordinate right of the specified view.
    @discardableResult
    public func right(of view: UIView) -> Layout {
        setLeft(view.right, context: { return "right(of: \(view))" })
        return self
    }
    
    @discardableResult
    public func right(of view: UIView, aligned: VerticalAlignment) -> Layout {
        switch aligned {
        case .top:    return setTopLeft(view.topRight, context: { return "right(of: \(view), aligned: .top)" })
        case .center: return setLeftCenter(view.rightCenter, context: { return "right(of: \(view), aligned: .center)" })
        case .bottom: return setBottomLeft(view.bottomRight, context: { return "right(of: \(view), aligned: .bottom)" })
        }
    }
    
    //
    // width, height
    //
    @discardableResult
    public func width(_ width: CGFloat) -> Layout {
        return setWidth(width, context: { return "width(\(width))" })
    }
    
    @discardableResult
    public func width(of view: UIView) -> Layout {
        return setWidth(view.width, context: { return "width(of: \(view))" })
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Layout {
        return setHeight(height, context: { return "height(\(height))" })
    }
    
    @discardableResult
    public func height(of view: UIView) -> Layout {
        return setHeight(view.height, context: { return "height(of: \(view))" })
    }
    
    @discardableResult
    public func size(_ size: CGSize) -> Layout {
        if isSizeNotSet(context: { return "size(CGSize(width: \(size.width), height: \(size.height)))" }) {
            width(size.width)
            height(size.height)
        }
        return self
    }
    
    @discardableResult
    public func size(of view: UIView) -> Layout {
        func context() -> String { return "size(of \(view))" }
        let viewSize = view.frame.size
        
        if isSizeNotSet(context: context) {
            setWidth(viewSize.width, context: context)
            setHeight(view.height, context: context)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(size: CGSize) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFits(CGSize(width: \(size.width), height: \(size.height)))" }) {
            fitSize = size
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(sizeOf view: UIView) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFitsViewSize(\(view))" }) {
            fitSize = view.size
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(width: CGFloat) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFitsWidth(\(width))" }) {
            fitSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(widthOf view: UIView) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFitsWidth(of: \(view))" }) {
            fitSize = CGSize(width: view.size.width, height: .greatestFiniteMagnitude)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(height: CGFloat) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFitsHeight(\(height))" }) {
            fitSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(heightOf view: UIView) -> Layout {
        if isSizeNotSet(context: { return "sizeThatFitsHeightof: \(view))" }) {
            fitSize = CGSize(width: .greatestFiniteMagnitude, height: view.size.height)
        }
        return self
    }
    
    /*@discardableResult
    func matchSize(_ view: UIView) -> Layout {
        self.size = view.size
        return self
    }
    
    @discardableResult
    func widthMatch(_ view: UIView) -> Layout {
        size.width = view.width
        return self
    }
    
    @discardableResult
    func widthSpaceBetween(view: UIView, andView: UIView) -> Layout {
        if view.right <= andView.left {
            // first view is on the left of the second view
            size.width = andView.left - view.right
        } else if view.right > andView.right {
            // first view is on the right of the second view
            size.width = view.left - andView.right
        } else {
            warnings("widthSpaceBetween(view:andView:): The horizontal space between specified are smaller than 0")
        }
        
        return self
    }
    
    @discardableResult
    func heightMatch(_ view: UIView) -> Layout {
        size.height = view.height
        return self
    }
    
    @discardableResult
    func heightSpaceBetween(view: UIView, andView: UIView) -> Layout {
        if view.bottom <= andView.top {
            // first view is above the second view
            size.height = andView.top - view.bottom
        } else if view.top > andView.bottom {
            // first view is below the second view
            size.width = view.top - andView.bottom
        } else {
            warnings("widthSpaceBetween(view:andView:): The horizontal space between specified are smaller than 0")
        }
        
        return self
    }*/
    
    //
    // Margins
    //
    @discardableResult
    public func margins(_ value: CGFloat) -> Layout {
        topMargin(value)
        leftMargin(value)
        bottomMargin(value)
        rightMargin(value)
        return self
    }
    
    @discardableResult
    public func topMargin(_ value: CGFloat) -> Layout {
        topMargin = value
        return self
    }
    
    @discardableResult
    public func leftMargin(_ value: CGFloat) -> Layout {
        leftMargin = value
        return self
    }
    
    @discardableResult
    public func bottomMargin(_ value: CGFloat) -> Layout {
        bottomMargin = value
        return self
    }
    
    @discardableResult
    public func rightMargin(_ value: CGFloat) -> Layout {
        rightMargin = value
        return self
    }
    
    //
    // Insets
    //
    @discardableResult
    public func insets(_ value: CGFloat) -> Layout {
        topInset(value)
        leftInset(value)
        bottomInset(value)
        rightInset(value)
        return self
    }
    
    @discardableResult
    public func topInset(_ value: CGFloat) -> Layout {
        topInset = value
        return self
    }
    
    @discardableResult
    public func leftInset(_ value: CGFloat) -> Layout {
        leftInset = value
        return self
    }
    
    @discardableResult
    public func bottomInset(_ value: CGFloat) -> Layout {
        bottomInset = value
        return self
    }
    
    @discardableResult
    public func rightInset(_ value: CGFloat) -> Layout {
        rightInset = value
        return self
    }
    
    fileprivate func apply() {
        //guard let view = view else { return }
        apply(onView: view)
    }
    
    public func apply(onView view: UIView) {
        assert(width == nil || (right == nil || left == nil))
        assert(height == nil || (top == nil || bottom == nil))
        assert(hCenter == nil || (left == nil && right == nil))
        assert(vCenter == nil || (top == nil && bottom == nil))
        
        var newRect = view.frame
        var isVerticalPositionApplied = false
        var isHorizontalPositionApplied = false
        
        if let fitSize = fitSize {
            let size = view.sizeThatFits(fitSize)
            width = size.width
            height = size.height
        }
        
        //
        // Compute vertical position
        //
        if let top = top {
            if bottom == nil && height == nil {
                // bottom and Height aren't set => adjust the origin
                newRect.origin.y = top + (topMargin ?? 0)
            } else if bottom != nil {
                // bottom is set => adjust the origin and the height
                newRect.origin.y = applyMarginsAndInsets(top: top)
                newRect.size.height = applyMarginsAndInsets(bottom: bottom! - newRect.origin.y)
            } else if height != nil {
                // height is set => adjust the origin and the height
                newRect.origin.y = applyMarginsAndInsets(top: top)
                newRect.size.height = applyTopBottomInsets(height!)
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let bottom = bottom {
            if top == nil && height == nil {
                // top and Height aren't set => Move the view and keeps the current height
                newRect.origin.y = bottom - newRect.height - (bottomMargin ?? 0)
            } else if top != nil {
                // nop, case already handled in the "top" case above
                assert(false)
            } else if height != nil {
                // height is set => adjust the top and the height
                newRect.origin.y = applyMarginsAndInsets(top: bottom - height!)
                newRect.size.height = applyTopBottomInsets(height!)
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let vCenter = vCenter {
            if height == nil {
                newRect.origin.y = vCenter - (newRect.size.height / 2)
            } else {
                // height is set => adjust the top and the height
                newRect.size.height = applyTopBottomInsets(height!)
                newRect.origin.y = vCenter - (newRect.size.height / 2) + (topMargin ?? 0)
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let height = height {
            newRect.size.height = height
        }
        
        //
        // Compute horizontal position
        //

        if let left = left {
            if right == nil && width == nil {
                // right and width aren't set => adjust the origin
                newRect.origin.x = left + (leftMargin ?? 0)
            } else if right != nil {
                // right is set => adjust the origin and the width
                newRect.origin.x = applyMarginsAndInsets(left: left)
                newRect.size.width = applyMarginsAndInsets(right: right!) - newRect.origin.x//! - newRect.origin.x - (rightMargin ?? 0) - (rightInset ?? 0)
            } else if width != nil {
                // width is set => adjust the origin and the height
                newRect.origin.x = applyMarginsAndInsets(left: left)
                newRect.size.width = applyLeftRightInsets(width!)
            }
            
            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let right = right {
            if left == nil && width == nil {
                // left and width aren't set => Move the view and keeps the current width
                newRect.origin.x = right - newRect.width - (rightMargin ?? 0)
            } else if left != nil {
                // nop, case already handled in the "left" case above
                assert(false)
            } else if width != nil {
                // width is set => adjust the origin
                newRect.origin.x = applyMarginsAndInsets(left: right - width!)
                newRect.size.width = applyLeftRightInsets(width!)
            }
            
            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let hCenter = hCenter {
            if width == nil {
                newRect.origin.x = hCenter - (newRect.size.width / 2)
            } else {
                // width is set => adjust the right and the width
                newRect.size.width = applyLeftRightInsets(width!)
                newRect.origin.x = hCenter - (newRect.size.width / 2) + (leftMargin ?? 0)
            }

            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let width = width {
            newRect.size.width = width
        }
        
        view.frame = CGRect(x: ceilFloatToDisplayScale(newRect.origin.x), y: ceilFloatToDisplayScale(newRect.origin.y),
                            width: ceilFloatToDisplayScale(newRect.size.width), height: ceilFloatToDisplayScale(newRect.size.height))
    }
}


// MARK: Private methods
extension Layout {
    fileprivate func setTop(_ value: CGFloat, context: Context) {
        if bottom != nil && height != nil {
            warnConflict(context, ["bottom": bottom!, "height": height!])
        } else if vCenter != nil {
            warnConflict(context, ["Vertical Center": vCenter!])
        } else if top != nil {
            warnPropertyAlreadySet("top", propertyValue: top!, context: context)
        } else {
            top = value
        }
    }
    
    fileprivate func setLeft(_ value: CGFloat, context: Context) {
        if right != nil && width != nil  {
            warnConflict(context, ["right": right!, "width": width!])
        } else if hCenter != nil {
            warnConflict(context, ["Horizontal Center": hCenter!])
        } else if left != nil {
            warnPropertyAlreadySet("left", propertyValue: left!, context: context)
        } else {
            left = value
        }
    }
    
    fileprivate func setRight(_ value: CGFloat, context: Context) {
        if left != nil && width != nil  {
            warnConflict(context, ["left": left!, "width": width!])
        } else if hCenter != nil {
            warnConflict(context, ["Horizontal Center": hCenter!])
        } else if right != nil {
            warnPropertyAlreadySet("right", propertyValue: right!, context: context)
        } else {
            right = value
        }
    }
    
    fileprivate func setBottom(_ value: CGFloat, context: Context) {
        if top != nil && height != nil {
            warnConflict(context, ["top": top!, "height": height!])
        } else if vCenter != nil {
            warnConflict(context, ["Vertical Center": vCenter!])
        } else if bottom != nil {
            warnPropertyAlreadySet("bottom", propertyValue: bottom!, context: context)
        } else {
            bottom = value
        }
    }
    
    fileprivate func setHorizontalCenter(_ value: CGFloat, context: Context) {
        if left != nil {
            warnConflict(context, ["left": left!])
        } else if right != nil {
            warnConflict(context, ["right": right!])
        } else if hCenter != nil {
            warnPropertyAlreadySet("hCenter", propertyValue: hCenter!, context: context)
        } else {
            hCenter = value
        }
    }
    
    fileprivate func setVerticalCenter(_ value: CGFloat, context: Context) {
        if top != nil {
            warnConflict(context, ["top": top!])
        } else if bottom != nil {
            warnConflict(context, ["bottom": bottom!])
        } else if vCenter != nil {
            warnPropertyAlreadySet("vCenter", propertyValue: vCenter!, context: context)
        } else {
            vCenter = value
        }
    }
    
    @discardableResult
    fileprivate func setTopLeft(_ point: CGPoint, context: Context) -> Layout {
        setLeft(point.x, context: context)
        setTop(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setTopCenter(_ point: CGPoint, context: Context) -> Layout {
        setHorizontalCenter(point.x, context: context)
        setTop(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setTopRight(_ point: CGPoint, context: Context) -> Layout {
        setRight(point.x, context: context)
        setTop(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setLeftCenter(_ point: CGPoint, context: Context) -> Layout {
        setLeft(point.x, context: context)
        setVerticalCenter(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setCenter(_ point: CGPoint, context: Context) -> Layout {
        setHorizontalCenter(point.x, context: context)
        setVerticalCenter(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setRightCenter(_ point: CGPoint, context: Context) -> Layout {
        setRight(point.x, context: context)
        setVerticalCenter(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomLeft(_ point: CGPoint, context: Context) -> Layout {
        setLeft(point.x, context: context)
        setBottom(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomCenter(_ point: CGPoint, context: Context) -> Layout {
        setHorizontalCenter(point.x, context: context)
        setBottom(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomRight(_ point: CGPoint, context: Context) -> Layout {
        setRight(point.x, context: context)
        setBottom(point.y, context: context)
        return self
    }
    
    @discardableResult
    fileprivate func setWidth(_ value: CGFloat, context: Context) -> Layout {
        guard value >= 0 else {
            warn("The width (\(value)) must be greater or equal to 0.", context: context); return self
        }
        
        if left != nil && right != nil {
            warnConflict(context, ["left": left!, "right": right!])
        } else if fitSize != nil {
            warnConflict(context, ["fitSize.width": fitSize!.width, "fitSize.height": fitSize!.height])
        } else if width != nil {
            warnPropertyAlreadySet("width", propertyValue: width!, context: context)
        } else {
            width = value
        }
        return self
    }
    
    @discardableResult
    fileprivate func setHeight(_ value: CGFloat, context: Context) -> Layout {
        guard value >= 0 else {
            warn("The height (\(value)) must be greater or equal to 0.", context: context); return self
        }
        
        if top != nil && bottom != nil {
            warnConflict(context, ["top": top!, "bottom": bottom!])
        } else if fitSize != nil {
            warnConflict(context, ["fitSize.width": fitSize!.width, "fitSize.height": fitSize!.height])
        } else if height != nil {
            warnPropertyAlreadySet("height", propertyValue: height!, context: context)
        } else {
            height = value
        }
        return self
    }
    
    fileprivate func isSizeNotSet(context: Context) -> Bool {
        if top != nil && bottom != nil {
            warnConflict(context, ["top": top!, "bottom": bottom!])
            return false
        } else if height != nil {
            warnConflict(context, ["height": height!])
            return false
        } else if width != nil {
            warnConflict(context, ["width": width!])
            return false
        } else if fitSize != nil {
            warnPropertyAlreadySet("fitSize", propertyValue: fitSize!, context: context)
            return false
        } else {
            return true
        }
    }
    
    fileprivate func computeCoordinates(forPin pin: Pin, of relativeView: UIView, context: Context) -> CGPoint? {
        guard let layoutSuperview = validateLayoutSuperview(context: context) else { return nil }
        guard let relativeSuperview = relativeView.superview else { warn("relative view's superview is nil", context: context); return nil }
        
        return computeCoordinates(point(forPin: pin, of: relativeView), layoutSuperview, relativeView, relativeSuperview)
    }
    
    fileprivate func computeCoordinates(_ point: CGPoint, _ layoutSuperview: UIView, _ relativeView: UIView, _ relativeSuperview: UIView) -> CGPoint {
        if layoutSuperview == relativeSuperview {
            return point   // same parent => no coordinates conversion required.
        } else {
            return relativeSuperview.convert(point, to: layoutSuperview)
        }
    }
    
    fileprivate func point(forPin pin: Pin, of view: UIView) -> CGPoint {
        switch pin {
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
    }
    
    fileprivate func computeCoordinates(forEdge edge: VerticalEdge, of relativeView: UIView, context: Context) -> CGFloat? {
        guard let layoutSuperview = validateLayoutSuperview(context: context) else { return nil }
        guard let relativeSuperview = relativeView.superview else { warn("relative view's superview is nil", context: context); return nil }
        
        return computeCoordinates(coordinate(forEdge: edge, of: relativeView), layoutSuperview, relativeView, relativeSuperview).y
    }
    
    fileprivate func coordinate(forEdge edge: VerticalEdge, of view: UIView) -> CGPoint {
        switch edge {
        case .top: return CGPoint(x: 0, y: view.top)
        case .bottom: return CGPoint(x: 0, y: view.bottom)
        }
    }
    
    fileprivate func computeCoordinates(forEdge edge: HorizontalEdge, of relativeView: UIView, context: Context) -> CGFloat? {
        guard let layoutSuperview = validateLayoutSuperview(context: context) else { return nil }
        guard let relativeSuperview = relativeView.superview else { warn("relative view's superview is nil", context: context); return nil }
        
        return computeCoordinates(coordinate(forEdge: edge, of: relativeView), layoutSuperview, relativeView, relativeSuperview).x
    }

    fileprivate func coordinate(forEdge edge: HorizontalEdge, of view: UIView) -> CGPoint {
        switch edge {
        case .left: return CGPoint(x: view.left, y: 0)
        case .right: return CGPoint(x: view.right, y: 0)
        }
    }
    
    fileprivate func validateLayoutSuperview(context: Context) -> UIView? {
        if let parentView = view.superview {
            return parentView
        } else {
            warn("Layout's view must be added to a UIView before being layouted using this method.", context: context)
            return nil
        }
    }
    
    fileprivate func applyMarginsAndInsets(top: CGFloat) -> CGFloat {
        return top + (topMargin ?? 0) + (topInset ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(bottom: CGFloat) -> CGFloat {
        return bottom -  (bottomMargin ?? 0) - (bottomInset ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(left: CGFloat) -> CGFloat {
        return left + (leftMargin ?? 0) + (leftInset ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(right: CGFloat) -> CGFloat {
        return right - (rightMargin ?? 0) - (rightInset ?? 0)
    }
    
    fileprivate func applyTopBottomInsets(_ height: CGFloat) -> CGFloat {
        return height - (topInset ?? 0) - (bottomInset ?? 0)
    }
    
    fileprivate func applyLeftRightInsets(_ width: CGFloat) -> CGFloat {
        return width - (leftInset ?? 0) - (rightInset ?? 0)
    }
    
    fileprivate func warn(_ text: String, context: Context) {
        guard Layout.logConflicts else { return }
        print("\n\(text)(\(context()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, context: Context) {
        guard Layout.logConflicts else { return }
        print("\nLayou2: The \(propertyName) property has already been set to \(propertyValue). (\(context()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, context: Context) {
        print("\nLayou2: The \(propertyName) property has already been set to CGSize(width: \(propertyValue.width), height: \(propertyValue.height)). (\(context()))\n")
    }
    
    fileprivate func warnConflict(_ context: Context, _ properties: [String: CGFloat]) {
        guard Layout.logConflicts else { return }
        var warning = "\nLayout Conflict: '\(context())' won't be applied since it conflicts with the following already set properties:\n"
        properties.forEach { (key, value) in
            warning += " \(key): \(value)\n"
        }
        
        print(warning)
    }
}


fileprivate let displayScale = UIScreen.main.scale

fileprivate func roundFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
    return (round(pointValue * displayScale) / displayScale)
}

fileprivate func ceilFloatToDisplayScale(_ pointValue: CGFloat) -> CGFloat {
    return (round(pointValue * displayScale) / displayScale)
}
