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
        Attach to a Pin of another view
         - view.layout.topLeft(backgroundView.pin.bottomLeft).margin(10)
         - view.layout.pinTopLeft(backgroundView.pin.bottomLeft).margin(10)
         
        Attach a coordinate relative to another UIView
         - view.layout.left(of: UIView).margin(10)
         - view.layout.left(of: UIView).margin(10)
         - view.layout.above(of: UIView).margin(10)
 
         Q: Une méthode avec paramêtre optionnel OU deux méthodes?
         - view.layout.left(of: backgroundView, aligned: .top)
         - view.layout.left(of: backgroundView)
 
        Use a CGPoint
         - view.layout.topLeft(CGPoint(x: 10, y: 20)).margin(10)
         - view.layout.pinTopLeft(CGPoint(x: 10, y: 20)).margin(10)
 
        Attach a point related to its superview
         - view.layout.topLeft().margin(10)
         - view.layout.topLeftToSuperview().margin(10)
         - view.layout.pinTopLeftToSuperview().margin(10)
 
         Attach a coordinate relative to another UIView
         - view.layout.left(backgroundView.edge.left)
         - view.layout.top(backgroundView.edge.bottom)
 
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
 
    - Avoir uniquement sizeToFit() et enlever tous les sizeThatFits()?
 
    - UIView.topLeft, .topRight, ... are not really necessary. Tout peut être accessible avec UIView.pin.point.
        eg: myView.topLeft -> myView.pin.topLeft.point OR myView.pin.topLeft.x & myView.pin.topLeft.y
 
 TODO:
 ===============================================
 - implement sizeThatFits
     - Insets should be applied to width and height before calling view.sizeThatFits()
 - implement sizeThatFits() without parameter that use set width and/or height

 - Est-ce que aView.layout.pinTopLeft(superview.pin.center) fonctionne?
 
 - peut-être enlever tous les UIView.topLeft, UIView.topCenter, ....?

 - Implement this: ??
 - view.layout.left(backgroundView.edge.left)
 - view.layout.top(backgroundView.edge.bottom)
 
 - Implement Layout + Layout operator
 
 - width(percentage: CGFloat, of view: UIView)
 - maxWidth(), minWidth(), maxHeight(), minHeight()
 
 - inset(t:? = nil l:? = nil  b:? = nil  r:? = nil ) ??
 - margin(t:? = nil  l:? = nil  b:? = nil  r:? = nil ) ??
 
 - Unit tests TODO:
     - pinTopLeft(to: Pin, of: UIView), pinTopCenter(to: Pin, of: UIView), ...
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
    fileprivate var fitSize: CGSize? // needed?
    fileprivate var shouldSizeToFit = false
    
    fileprivate var marginTop: CGFloat?
    fileprivate var marginLeft: CGFloat?
    fileprivate var marginBottom: CGFloat?
    fileprivate var marginRight: CGFloat?
    
    fileprivate var insetTop: CGFloat?
    fileprivate var insetLeft: CGFloat?
    fileprivate var insetBottom: CGFloat?
    fileprivate var insetRight: CGFloat?
    
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
    
    /// Set the view's bottom coordinate above of the specified view.
    @discardableResult
    public func above(of relativeView: UIView) -> Layout {
        func context() -> String { return "below(of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: .top, of: relativeView, context: context) {
            setBottom(coordinate, context: context)
        }
        return self
    }
    @discardableResult
    public func above(of relativeView: UIView, aligned: HorizontalAlignment) -> Layout {
        func context() -> String { return "above(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .left:
            if let coordinates = computeCoordinates(forPin: .topLeft, of: relativeView, context: context) {
                setBottomLeft(coordinates, context: context)
            }
        case .center:
            if let coordinates = computeCoordinates(forPin: .topCenter, of: relativeView, context: context) {
                setBottomCenter(coordinates, context: context)
            }
        case .right:
            if let coordinates = computeCoordinates(forPin: .topRight, of: relativeView, context: context) {
                setBottomRight(coordinates, context: context)
            }
        }
        return self
    }
    
    /// Set the view's top coordinate below of the specified view.
    @discardableResult
    public func below(of relativeView: UIView) -> Layout {
        func context() -> String { return "below(of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: .bottom, of: relativeView, context: context) {
            setTop(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func below(of relativeView: UIView, aligned: HorizontalAlignment) -> Layout {
        func context() -> String { return "below(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .left:
            if let coordinates = computeCoordinates(forPin: .bottomLeft, of: relativeView, context: context) {
                setTopLeft(coordinates, context: context)
            }
        case .center:
            if let coordinates = computeCoordinates(forPin: .bottomCenter, of: relativeView, context: context) {
                setTopCenter(coordinates, context: context)
            }
        case .right:
            if let coordinates = computeCoordinates(forPin: .bottomRight, of: relativeView, context: context) {
                setTopRight(coordinates, context: context)
            }
        }
        return self
    }
    
    /// Set the view's right coordinate left of the specified view.
    @discardableResult
    public func left(of relativeView: UIView) -> Layout {
        func context() -> String { return "left(of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: .left, of: relativeView, context: context) {
            setRight(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func left(of relativeView: UIView, aligned: VerticalAlignment) -> Layout {
        func context() -> String { return "left(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .top:
            if let coordinates = computeCoordinates(forPin: .topLeft, of: relativeView, context: context) {
                setTopRight(coordinates, context: context)
            }
        case .center:
            if let coordinates = computeCoordinates(forPin: .leftCenter, of: relativeView, context: context) {
                setRightCenter(coordinates, context: context)
            }
        case .bottom:
            if let coordinates = computeCoordinates(forPin: .bottomLeft, of: relativeView, context: context) {
                setBottomRight(coordinates, context: context)
            }
        }
        return self
    }
    
    /// Set the view's left coordinate right of the specified view.
    @discardableResult
    public func right(of relativeView: UIView) -> Layout {
        func context() -> String { return "left(of: \(view))" }
        if let coordinate = computeCoordinates(forEdge: .right, of: relativeView, context: context) {
            setLeft(coordinate, context: context)
        }
        return self
    }
    
    @discardableResult
    public func right(of relativeView: UIView, aligned: VerticalAlignment) -> Layout {
        func context() -> String { return "right(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .top:
            if let coordinates = computeCoordinates(forPin: .topRight, of: relativeView, context: context) {
                setTopLeft(coordinates, context: context)
            }
        case .center:
            if let coordinates = computeCoordinates(forPin: .rightCenter, of: relativeView, context: context) {
                setLeftCenter(coordinates, context: context)
            }
        case .bottom:
            if let coordinates = computeCoordinates(forPin: .bottomRight, of: relativeView, context: context) {
                setBottomLeft(coordinates, context: context)
            }
        }
        return self
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
    public func sizeToFit() -> Layout {
        if let _ = fitSize {
            warn("Call to sizeToFit() conflict with a previous call of sizeThatFit(). sizeToFit() won't be applied", context: { return "sizeToFit()" })
        } else {
            shouldSizeToFit = true
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
    
    /*
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
    public func margin(_ value: CGFloat) -> Layout {
        marginTop = value
        marginLeft = value
        marginBottom = value
        marginRight = value
        return self
    }
    
    @discardableResult
    public func marginHorizontal(_ value: CGFloat) -> Layout {
        marginLeft = value
        marginRight = value
        return self
    }

    @discardableResult
    public func marginVertical(_ value: CGFloat) -> Layout {
        marginTop = value
        marginBottom = value
        return self
    }

    @discardableResult
    public func marginTop(_ value: CGFloat) -> Layout {
        marginTop = value
        return self
    }
    
    @discardableResult
    public func marginLeft(_ value: CGFloat) -> Layout {
        marginLeft = value
        return self
    }
    
    @discardableResult
    public func marginBottom(_ value: CGFloat) -> Layout {
        marginBottom = value
        return self
    }
    
    @discardableResult
    public func marginRight(_ value: CGFloat) -> Layout {
        marginRight = value
        return self
    }
    
    //
    // Insets
    //
    @discardableResult
    public func inset(_ value: CGFloat) -> Layout {
        insetTop(value)
        insetLeft(value)
        insetBottom(value)
        insetRight(value)
        return self
    }
    
    @discardableResult
    public func insetTop(_ value: CGFloat) -> Layout {
        insetTop = value
        return self
    }
    
    @discardableResult
    public func insetLeft(_ value: CGFloat) -> Layout {
        insetLeft = value
        return self
    }
    
    @discardableResult
    public func insetBottom(_ value: CGFloat) -> Layout {
        insetBottom = value
        return self
    }
    
    @discardableResult
    public func insetRight(_ value: CGFloat) -> Layout {
        insetRight = value
        return self
    }
    
    @discardableResult
    public func insetHorizontal(_ value: CGFloat) -> Layout {
        insetLeft = value
        insetRight = value
        return self
    }
    
    @discardableResult
    public func insetVertical(_ value: CGFloat) -> Layout {
        insetTop(value)
        insetBottom(value)
        return self
    }
    
//    -
//    - insetVertical
//    
    
    fileprivate func apply() {
        //guard let view = view else { return }
        apply(onView: view)
    }
    
    public func apply(onView view: UIView) {
//        assert(width != nil && (right == nil || left == nil), "width and right+left shouldn't be set simultaneously")
//        assert(height != nil || (top == nil || bottom == nil), "height and top+bottom shouldn't be set simultaneously")
//        assert(hCenter == nil || (left == nil && right == nil), "hCenter and right+left shouldn't be set simultaneously")
//        assert(vCenter == nil || (top == nil && bottom == nil), "vCenter and top+bottom shouldn't be set simultaneously")
//        assert(fitSize == nil || (top == nil && bottom == nil), "vCenter and top+bottom shouldn't be set simultaneously")
        
        let currentFrame = view.frame
        var newX: CGFloat?
        var newY: CGFloat?
        var newWidth: CGFloat?
        var newHeight: CGFloat?
        
        var isVerticalPositionApplied = false
        var isHorizontalPositionApplied = false
        
        var newComputedWidth = computeWidth()
        var newComputedHeight = computeHeight()
        
        if shouldSizeToFit && (newComputedWidth != nil || newComputedHeight != nil) {
            fitSize = CGSize(width: newComputedWidth ?? .greatestFiniteMagnitude,
                             height: newComputedHeight ?? .greatestFiniteMagnitude)
        } 
    
        if let fitSize = fitSize {
            let newSize = view.sizeThatFits(fitSize)
            
            if fitSize.width != .greatestFiniteMagnitude && newSize.width > fitSize.width {
                newComputedWidth = fitSize.width
            } else {
                newComputedWidth = newSize.width
            }
            
            if fitSize.height != .greatestFiniteMagnitude && newSize.height > fitSize.height {
                newComputedHeight = fitSize.height
            } else {
                newComputedHeight = newSize.height
            }
        }
        
        //
        // Compute vertical position
        //
        if let top = top {
            if bottom == nil && newComputedHeight == nil {
                // bottom and Height aren't set => adjust the origin
                newY = top + (marginTop ?? 0)
            } else if bottom != nil {
                // bottom is set => adjust the origin and the height
                newY = applyMarginsAndInsets(top: top)
                newHeight = newComputedHeight! - newY!
            } else if let newComputedHeight = newComputedHeight {
                // height is set => adjust the origin and the height
                newY = applyMarginsAndInsets(top: top)
                newHeight = newComputedHeight
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let bottom = bottom {
            if top == nil && newComputedHeight == nil {
                // top and Height aren't set => Move the view and keeps the current height
                newY = bottom - currentFrame.height - (marginBottom ?? 0)
            } else if top != nil {
                // nop, case already handled in the "top" case above
                assert(false)
            } else if let newComputedHeight = newComputedHeight {
                // height is set => adjust the top and the height
                newHeight = newComputedHeight
                newY = applyMarginsAndInsets(bottom: bottom) - newComputedHeight
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let vCenter = vCenter {
            if let newComputedHeight = newComputedHeight {
                // height is set => adjust the top and the height
                newHeight = newComputedHeight
                newY = vCenter - (newHeight! / 2) + (marginTop ?? 0)
            } else {
                newY = vCenter - (currentFrame.height / 2)
            }
            
            isVerticalPositionApplied = true
        }
        
        if !isVerticalPositionApplied, let newComputedHeight = newComputedHeight {
            newHeight = newComputedHeight
        }
        
        //
        // Compute horizontal position
        //

        if let left = left {
            if right == nil && newComputedWidth == nil {
                // right and width aren't set => adjust the origin
                newX = left + (marginLeft ?? 0)
            } else if right != nil {
                // right is set => adjust the origin and the width
                newX = applyMarginsAndInsets(left: left)
                newWidth = newComputedWidth! - newX!
            } else if let newComputedWidth = newComputedWidth {
                // width is set => adjust the origin and the height
                newX = applyMarginsAndInsets(left: left)
                newWidth = newComputedWidth
            }
            
            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let right = right {
            if left == nil && newComputedWidth == nil {
                // left and width aren't set => Move the view and keeps the current width
                newX = right - currentFrame.width - (marginRight ?? 0)
            } else if left != nil {
                // nop, case already handled in the "left" case above
                assert(false)
            } else if let newComputedWidth = newComputedWidth {
                // width is set => adjust the origin and the width
                newWidth = newComputedWidth
                newX = applyMarginsAndInsets(right: right) - newWidth!
            }
            
            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let hCenter = hCenter {
            if let newComputedWidth = newComputedWidth {
                // width is set => adjust the right and the width
                newWidth = newComputedWidth
                newX = hCenter - (newComputedWidth / 2) + (marginLeft ?? 0)
            } else {
                newX = hCenter - (currentFrame.width / 2)
            }
            
            isHorizontalPositionApplied = true
        }
        
        if !isHorizontalPositionApplied, let newComputedWidth = newComputedWidth {
            newWidth = newComputedWidth
        }
        
        view.frame = CGRect(x: ceilFloatToDisplayScale(newX ?? currentFrame.origin.x),
                            y: ceilFloatToDisplayScale(newY ?? currentFrame.origin.y),
                            width: ceilFloatToDisplayScale(newWidth ?? currentFrame.width),
                            height: ceilFloatToDisplayScale(newHeight ?? currentFrame.height))
    }
    
    fileprivate func computeWidth() -> CGFloat? {
        if let _ = left, let right = right {
            return applyMarginsAndInsets(right: right)
        } else if let width = width {
            return applyLeftRightInsets(width: width)
        } else {
            return nil
        }
    }
    
    fileprivate func computeHeight() -> CGFloat? {
        if let _ = top, let bottom = bottom {
            return applyMarginsAndInsets(bottom: bottom)
        } else if let height = height {
            return applyTopBottomInsets(height: height)
        } else {
            return nil
        }
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
        return top + (marginTop ?? 0) + (insetTop ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(bottom: CGFloat) -> CGFloat {
        return bottom - (marginBottom ?? 0) - (insetBottom ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(left: CGFloat) -> CGFloat {
        return left + (marginLeft ?? 0) + (insetLeft ?? 0)
    }
    
    fileprivate func applyMarginsAndInsets(right: CGFloat) -> CGFloat {
        return right - (marginRight ?? 0) - (insetRight ?? 0)
    }
    
    fileprivate func applyTopBottomInsets(height: CGFloat) -> CGFloat {
        return height - (insetTop ?? 0) - (insetBottom ?? 0)
    }
    
    fileprivate func applyLeftRightInsets(width: CGFloat) -> CGFloat {
        return width - (insetLeft ?? 0) - (insetRight ?? 0)
    }
    
    fileprivate func warn(_ text: String, context: Context) {
        guard Layout.logConflicts else { return }
        print("\n\(text) (\(context()))\n")
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
