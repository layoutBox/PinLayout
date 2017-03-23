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
 
 ===============================================
 TODO:
 ===============================================
 - Faire sample avec un scrollview qui contient une viewA et:
    1- pin une view ne faisant pas parti de la scrollview à viewA
    2- pin une view à un coin de viewA et un autre coin de cette view à un coin qui ne bouge pas.
 - Faire un sample avec A pinner à droite avec une largeur de 30. Et pinner viewB.left à gauche de la superview
    et viewB.right à la viewA. Comme ça lorsque la taille de l'écran change uniquement viewB va changer de taille.


 - sizeToFit() devrait prendre un parametre indiquant si on doit caster les nouvelles valeur
     de width et de height (forceSize, castSize, ...?)
 
 - dans le calcul des coordonné, ajouter un relativeView is superview then ...
    optimisation
 - Support hCenter + left or right
 - Support vCenter + top or bottom
 
 - implement sizeThatFits
     - Insets should be applied to width and height before calling view.sizeThatFits()
 
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
    - margins and insets negatifs
 
 - With SwiftyAttributes, you can write the same thing like this:

        let fancyString = "Hello World!".withTextColor(.blue).withUnderlineStyle(.styleSingle)
    Alternatively, SwiftyAttributes provides an Attribute enum:
        let fancyString = "Hello World!".withAttributes([
            .backgroundColor(.magenta),
            .strokeColor(.orange),
            .strokeWidth(1),
            .baselineOffset(5.2)
        ])
*/
fileprivate typealias Context = () -> String
fileprivate typealias Size = (width: CGFloat?, height: CGFloat?)

public class Layout {
    static var logConflicts = true
    // static var useBottomRightCssStyle = false

    fileprivate let view: UIView
    
    fileprivate var top: CGFloat?
    fileprivate var left: CGFloat?
    fileprivate var bottom: CGFloat?
    fileprivate var right: CGFloat?
    
    fileprivate var hCenter: CGFloat?
    fileprivate var vCenter: CGFloat?
    
    fileprivate var width: CGFloat?
    fileprivate var height: CGFloat?

    fileprivate var marginTop: CGFloat?
    fileprivate var marginLeft: CGFloat?
    fileprivate var marginBottom: CGFloat?
    fileprivate var marginRight: CGFloat?
    
    fileprivate var insetTop: CGFloat?
    fileprivate var insetLeft: CGFloat?
    fileprivate var insetBottom: CGFloat?
    fileprivate var insetRight: CGFloat?

    fileprivate var shouldSizeToFit = false

    public init(view: UIView) {
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
    public func pinTop(to edge: VerticalEdge) -> Layout {
        func context() -> String { return "pinTop(to: \(edge.edgeType.rawValue), of: \(edge.view))" }
        if let coordinate = computeCoordinates(forEdge: edge.edgeType, of: edge.view, context: context) {
            setTop(coordinate.y, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinLeft(to edge: HorizontalEdge) -> Layout {
        func context() -> String { return "pinLeft(to: \(edge.edgeType.rawValue), of: \(edge.view))" }
        if let coordinate = computeCoordinates(forEdge: edge.edgeType, of: edge.view, context: context) {
            setLeft(coordinate.x, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinBottom(to edge: VerticalEdge) -> Layout {
        func context() -> String { return "pinBottom(to: \(edge.edgeType.rawValue), of: \(edge.view))" }
        if let coordinate = computeCoordinates(forEdge: edge.edgeType, of: edge.view, context: context) {
            setBottom(coordinate.y, context: context)
        }
        return self
    }
    
    @discardableResult
    public func pinRight(to edge: HorizontalEdge) -> Layout {
        func context() -> String { return "pinRight(to: \(edge.edgeType.rawValue), of: \(edge.view))" }
        if let coordinate = computeCoordinates(forEdge: edge.edgeType, of: edge.view, context: context) {
            setRight(coordinate.x, context: context)
        }
        return self
    }
    
    // TODO: Add hCenter and vCenter
    
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
    public func pinTopLeft(to pin: Pin) -> Layout {
        func context() -> String { return "pinTopLeft(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setTopLeft(coordinates, context: context)
        }
        return self
    }

    /// Position on the topLeft corner of the specified view.
//    @discardableResult
//    public func pinTopLeft(to relativeView: UIView) -> Layout {
//        func context() -> String { return "topLeft(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .topLeft, of: relativeView, context: context) {
//            setTopLeft(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinTopCenter(to pin: Pin) -> Layout {
        func context() -> String { return "pinTopCenter(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setTopCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topCenter corner of the specified view.
//    @discardableResult
//    public func pinTopCenter(to relativeView: UIView) -> Layout {
//        func context() -> String { return "topCenter(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .topCenter, of: relativeView, context: context) {
//            setTopCenter(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinTopRight(to pin: Pin) -> Layout {
        func context() -> String { return "pinTopRight(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setTopRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the topRight corner of the specified view.
//    @discardableResult
//    public func pinTopRight(to relativeView: UIView) -> Layout {
//        func context() -> String { return "topRight(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .topRight, of: relativeView, context: context) {
//            setTopRight(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinLeftCenter(to pin: Pin) -> Layout {
        func context() -> String { return "pinLeftCenter(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setLeftCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the leftCenter corner of the specified view.
//    @discardableResult
//    public func pinLeftCenter(to relativeView: UIView) -> Layout {
//        func context() -> String { return "leftCenter(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .leftCenter, of: relativeView, context: context) {
//            setLeftCenter(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinCenter(to pin: Pin) -> Layout {
        func context() -> String { return "pinCenter(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setCenter(coordinates, context: context)
        }
        return self
    }
    
//    @discardableResult
//    public func pinCenter(to relativeView: UIView) -> Layout {
//        func context() -> String { return "centers(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: PinType.center, of: relativeView, context: context) {
//            setCenter(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinRightCenter(to pin: Pin) -> Layout {
        func context() -> String { return "pinRightCenter(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setRightCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the rightCenter corner of the specified view.
//    @discardableResult
//    public func pinRightCenter(to relativeView: UIView) -> Layout {
//        func context() -> String { return "rightCenter(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .rightCenter, of: relativeView, context: context) {
//            setRightCenter(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinBottomLeft(to pin: Pin) -> Layout {
        func context() -> String { return "pinBottomLeft(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setBottomLeft(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomLeft corner of the specified view.
//    @discardableResult
//    public func pinBottomLeft(to relativeView: UIView) -> Layout {
//        func context() -> String { return "bottomLeft(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .bottomLeft, of: relativeView, context: context) {
//            setBottomLeft(coordinates, context: context)
//        }
//        return self
//    }

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
    public func pinBottomCenter(to pin: Pin) -> Layout {
        func context() -> String { return "pinBottomCenter(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setBottomCenter(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomCenter corner of the specified view.
//    @discardableResult
//    public func pinBottomCenter(to relativeView: UIView) -> Layout {
//        func context() -> String { return "bottomCenter(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .bottomCenter, of: relativeView, context: context) {
//            setBottomCenter(coordinates, context: context)
//        }
//        return self
//    }
    
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
    public func pinBottomRight(to pin: Pin) -> Layout {
        func context() -> String { return "pinBottomRight(to: \(pin.pinType.rawValue), of: \(view))" }
        if let coordinates = computeCoordinates(forPin: pin.pinType, of: pin.view, context: context) {
            setBottomRight(coordinates, context: context)
        }
        return self
    }
    
    /// Position on the bottomRight corner of the specified view.
//    @discardableResult
//    public func pinBottomRight(to relativeView: UIView) -> Layout {
//        func context() -> String { return "bottomRight(of: \(view))" }
//        if let coordinates = computeCoordinates(forPin: .bottomRight, of: relativeView, context: context) {
//            setBottomRight(coordinates, context: context)
//        }
//        return self
//    }

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
            setBottom(coordinate.y, context: context)
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
            setTop(coordinate.y, context: context)
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
            setRight(coordinate.x, context: context)
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
            setLeft(coordinate.x, context: context)
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
        return setWidth(View.width(view), context: { return "width(of: \(view))" })
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Layout {
        return setHeight(height, context: { return "height(\(height))" })
    }
    
    @discardableResult
    public func height(of view: UIView) -> Layout {
        return setHeight(View.height(view), context: { return "height(of: \(view))" })
    }
    
    //
    // size, sizeToFit, sizeThatFits
    //
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
            setHeight(View.height(view), context: context)
        }
        return self
    }
    
    @discardableResult
    public func sizeToFit() -> Layout {
        shouldSizeToFit = true
        return self
    }
    
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
}

//
// MARK: Private methods
//
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
        } else {
            return true
        }
    }
    
    fileprivate func computeCoordinates(forPin pin: PinType, of relativeView: UIView, context: Context) -> CGPoint? {
        guard let layoutSuperview = validateLayoutSuperview(context: context) else { return nil }
        guard let relativeSuperview = relativeView.superview else { warn("relative view's superview is nil", context: context); return nil }
        
        return computeCoordinates(View.point(forPin: pin, of: relativeView), layoutSuperview, relativeView, relativeSuperview)
    }
    
    fileprivate func computeCoordinates(_ point: CGPoint, _ layoutSuperview: UIView, _ relativeView: UIView, _ relativeSuperview: UIView) -> CGPoint {
        if layoutSuperview == relativeSuperview {
            return point   // same parent => no coordinates conversion required.
        } else {
            return relativeSuperview.convert(point, to: layoutSuperview)
        }
    }

    fileprivate func computeCoordinates(forEdge edge: EdgeType, of relativeView: UIView, context: Context) -> CGPoint? {
        guard let layoutSuperview = validateLayoutSuperview(context: context) else { return nil }
        guard let relativeSuperview = relativeView.superview else { warn("relative view's superview is nil", context: context); return nil }
        
        return computeCoordinates(View.coordinate(forEdge: edge, of: relativeView), layoutSuperview, relativeView, relativeSuperview)
    }

    fileprivate func validateLayoutSuperview(context: Context) -> UIView? {
        if let parentView = view.superview {
            return parentView
        } else {
            warn("Layout's view must be added to a UIView before being layouted using this method.", context: context)
            return nil
        }
    }
    
    fileprivate func apply() {
        // guard let view = view else { return }
        apply(onView: view)
    }
    
    public func apply(onView view: UIView) {
        //        assert(width != nil && (right == nil || left == nil), "width and right+left shouldn't be set simultaneously")
        //        assert(height != nil || (top == nil || bottom == nil), "height and top+bottom shouldn't be set simultaneously")
        //        assert(hCenter == nil || (left == nil && right == nil), "hCenter and right+left shouldn't be set simultaneously")
        //        assert(vCenter == nil || (top == nil && bottom == nil), "vCenter and top+bottom shouldn't be set simultaneously")
        //        assert(fitSize == nil || (top == nil && bottom == nil), "vCenter and top+bottom shouldn't be set simultaneously")
        
        var newRect = view.frame
        let newSize = computeSize()
        
        // Compute horizontal position
        if let left = left, let right = right {
            // left & right is set
            newRect.origin.x = applyMarginsAndInsets(left: left)
            newRect.size.width = applyMarginsAndInsets(right: right) - newRect.origin.x
        } else if let left = left, let width = newSize.width {
            // left & width is set
            newRect.origin.x = applyMarginsAndInsets(left: left)
            newRect.size.width = width
        } else if let right = right, let width = newSize.width {
            // right & width is set
            newRect.size.width = width
            newRect.origin.x = applyMarginsAndInsets(right: right) - width
        } else if let hCenter = hCenter, let width = newSize.width {
            // hCenter & width is set
            newRect.size.width = width
            newRect.origin.x = hCenter - (width / 2) + (marginLeft ?? 0)
        } else if let left = left {
            // Only left is set
            newRect.origin.x = left + (marginLeft ?? 0)
        } else if let right = right {
            // Only right is set
            newRect.origin.x = right - view.frame.width - (marginRight ?? 0)
        } else if let hCenter = hCenter {
            // Only hCenter is set
            newRect.origin.x = hCenter - (view.frame.width / 2)
        } else if let width = newSize.width {
            // Only widht is set
            newRect.size.width = width
        }
        
        // Compute vertical position
        if let top = top, let bottom = bottom {
            // top & bottom is set
            newRect.origin.y = applyMarginsAndInsets(top: top)
            newRect.size.height = applyMarginsAndInsets(bottom: bottom) - newRect.origin.y
        } else if let top = top, let height = newSize.height {
            // top & height is set
            newRect.origin.y = applyMarginsAndInsets(top: top)
            newRect.size.height = height
        } else if let bottom = bottom, let height = newSize.height {
            // bottom & height is set
            newRect.size.height = height
            newRect.origin.y = applyMarginsAndInsets(bottom: bottom) - height
        } else if let vCenter = vCenter, let height = newSize.height {
            // vCenter & height is set
            newRect.size.height = height
            newRect.origin.y = vCenter - (newRect.size.height / 2) + (marginTop ?? 0)
        } else if let top = top {
            // Only top is set
            newRect.origin.y = top + (marginTop ?? 0)
        } else if let bottom = bottom {
            // Only bottom is set
            newRect.origin.y = bottom - view.frame.height - (marginBottom ?? 0)
        } else if let vCenter = vCenter {
            // Only vCenter is set
            newRect.origin.y = vCenter - (view.frame.height / 2)
        } else if let height = newSize.height {
            // Only height is set
            newRect.size.height = height
        }

        view.frame = View.adjustRectToDisplayScale(newRect)
    }
    
    fileprivate func computeSize() -> Size {
        var newWidth = computeWidth()
        var newHeight = computeHeight()
        
        if shouldSizeToFit && (newWidth != nil || newHeight != nil) {
            let fitSize = CGSize(width: newWidth ?? .greatestFiniteMagnitude,
                                 height: newHeight ?? .greatestFiniteMagnitude)

            let sizeThatFits = view.sizeThatFits(fitSize)

            if fitSize.width != .greatestFiniteMagnitude && sizeThatFits.width > fitSize.width {
                newWidth = fitSize.width
            } else {
                newWidth = sizeThatFits.width
            }

            if fitSize.height != .greatestFiniteMagnitude && sizeThatFits.height > fitSize.height {
                newHeight = fitSize.height
            } else {
                newHeight = sizeThatFits.height
            }
        }

        return (newWidth, newHeight)
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
        print("\n👉 \(text) (\(context()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, context: Context) {
        guard Layout.logConflicts else { return }
        print("\n👉 The \(propertyName) property has already been set to \(propertyValue). (\(context()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, context: Context) {
        print("\n👉 The \(propertyName) property has already been set to CGSize(width: \(propertyValue.width), height: \(propertyValue.height)). (\(context()))\n")
    }
    
    fileprivate func warnConflict(_ context: Context, _ properties: [String: CGFloat]) {
        guard Layout.logConflicts else { return }
        var warning = "\n👉 Layout Conflict: '\(context())' won't be applied since it conflicts with the following already set properties:\n"
        properties.forEach { (key, value) in
            warning += " \(key): \(value)\n"
        }
        
        print(warning)
    }
}
