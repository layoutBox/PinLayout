// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
 
         - view.pin.topLeft(to: .bottomLeft, of: backgroundView).margin(10)
         - view.pin.topLeft(.bottomLeft, of: backgroundView).margin(10)
 
         - view.layout.snapTopLeft(.bottomLeft, of: backgroundView)
         - view.layout.snapTopLeft(to: .bottomLeft, of: backgroundView).margin(10)
         - view.layout.snapTopLeft(to: backgroundView, .bottomLeft).margin(10)
         - view.layout.snapTop(to: .bottom, of: backgroundView).margin(10)
         
         - layout.snapTopLeft(to: backgroundView, .bottomLeft)
         
         - layout.top(to: .bottom, of: backgroundView)
 
    - enum Snap ou Pin ou Point?

 ===============================================
 TODO:
 ===============================================
 - Antoine Lamy: Suggestion pour ton système de layout (pt déjà le cas): Utiliser une interface entre l'engin de layout et
    UIKit afin de potentiellement être capable de le bridger vers d'autres entitées visuelles qu'une 
    UIView (exemple: CALayer, NSView, ASDisplayNode, etc). L'engin n'a probablement à dealer qu'avec des 
    primitives de CoreGraphics.

    Cette abstraction a été fait dans le framework d'animation POP ce qui fait qu'on peut virtuellement animer 
    n'importe quelle valeur, qu'elle soit liée à une vue ou pas. Ça rend le truc vraiment flexible.
        https://github.com/facebook/pop

 - applyMarginsAsInsets, marginsAsInsets, insetsMargins, stickyBounds, pinBounds, pinEdges
 - pinEdgesHorizontal, pinEdgesVertical ??
 - Add parameter to sizeToFit indiquant si on doit caster ou pas le résultat
 - Add minHeight, maxHeight, ...
 - Add size(_ width: CGFloat, _ height: CGFloat)
 
 - frame(of: UIView)
 - frame()
  
 - In CSS
        - negative width and height is not applied, also for percentages
        - right/bottom: negative value and percentage is applyed 
                right: -20px  increase the width by an extra 20 pixels
                right: -50%   increase the width by an extra 50% (width = parent's width * 1.50)
        - negative margins affect the top, left, bottom, right. pixel or percent

 
 - sizeToFit() devrait prendre un parametre indiquant si on doit caster les nouvelles valeur
     de width et de height (forceSize, castSize, ...?)
 
 - dans le calcul des coordonné, ajouter un referenceView is superview then ...
    optimisation

 - Support hCenter + left or right
 - Support vCenter + top or bottom
 
 - maxWidth(), minWidth(), maxHeight(), minHeight()
 
 - Unit tests TODO:
    - pinTopLeft(to: Pin, of: UIView), topCenter(to: Pin, of: UIView), ...
    - margins and insets negatifs
    - margin(t: l: b: r:)

 - With SwiftyAttributes, you can write the same thing like this:

        let fancyString = "Hello World!".withTextColor(.blue).withUnderlineStyle(.styleSingle)
    Alternatively, SwiftyAttributes provides an Attribute enum:
        let fancyString = "Hello World!".withAttributes([
            .backgroundColor(.magenta),
            .strokeColor(.orange),
            .strokeWidth(1),
            .baselineOffset(5.2)
        ])
 
 - Inspired by https://github.com/robb/Cartography
     // Other possible syntax
    layout(viewA) { viewA in {
        viewA.pinTopLeft(to: viewB.pin.topLeft).margin(20)
        viewA.width(20).height(20)
    }
 
 //constrain(button1, button2) { button1, button2 in
 //    button1.right == button2.left - 12
 //}
*/
#if DEBUG
    public var PinLayoutLogConflicts = true
#else
    public var PinLayoutLogConflicts = false
#endif


class PinLayoutImpl: PinLayout {
       fileprivate let view: UIView

    fileprivate var _top: CGFloat?       // offset from superview's top edge
    fileprivate var _left: CGFloat?      // offset from superview's left edge
    fileprivate var _bottom: CGFloat?    // offset from superview's top edge
    fileprivate var _right: CGFloat?     // offset from superview's left edge
    
    fileprivate var hCenter: CGFloat?
    fileprivate var vCenter: CGFloat?
    
    fileprivate var width: CGFloat?
    fileprivate var height: CGFloat?

    fileprivate var marginTop: CGFloat?
    fileprivate var marginLeft: CGFloat?
    fileprivate var marginBottom: CGFloat?
    fileprivate var marginRight: CGFloat?
    fileprivate var shouldPinEdges = false
    
    fileprivate var shouldSizeToFit = false

    fileprivate var _marginTop: CGFloat { return marginTop ?? 0  }
    fileprivate var _marginLeft: CGFloat { return marginLeft ?? 0 }
    fileprivate var _marginBottom: CGFloat { return marginBottom ?? 0 }
    fileprivate var _marginRight: CGFloat { return marginRight ?? 0 }

    init(view: UIView) {
        self.view = view
    }
    
    deinit {
        apply()
    }
    
    //
    // top, left, bottom, right
    //
    @discardableResult func top() -> PinLayout {
        setTop(0, { return "top()" })
        return self
    }

    @discardableResult
    func top(_ value: CGFloat) -> PinLayout {
        setTop(value, { return "top(\(value))" })
        return self
    }
    
    @discardableResult func left() -> PinLayout {
        setLeft(0, { return "left()" })
        return self
    }

    @discardableResult
    func left(_ value: CGFloat) -> PinLayout {
        setLeft(value, { return "left(\(value))" })
        return self
    }
    
    @discardableResult func bottom() -> PinLayout {
        func context() -> String { return "bottom()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottom(layoutSuperview.frame.height, context)
        return self
    }

    @discardableResult
    func bottom(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "bottom(\(value))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottom(layoutSuperview.frame.height - value, context)
        return self
    }

    @discardableResult func right() -> PinLayout {
        func context() -> String { return "right()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width, context)
        return self
    }

    @discardableResult
    func right(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "right(\(value))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width - value, context)
        return self
    }

    @discardableResult
    func hCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "vCenter(\(value))" }
        setHorizontalCenter(value, context)
        return self
    }

    @discardableResult
    func vCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "vCenter(\(value))" }
        setVerticalCenter(value, context)
        return self
    }

    //
    // top, left, bottom, right
    //
    @discardableResult
    func top(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "top", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setTop(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func left(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "left", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setLeft(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func bottom(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "bottom", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setBottom(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func right(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "right", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setRight(coordinate, context)
        }
        return self
    }
    
    //
    // topLeft, topCenter, topRight,
    // leftCenter, center, rightCenter,
    // bottomLeft, bottomCenter, bottomRight,
    //
    /// Position the topLeft on the specified view's Anchor.
    @discardableResult
    func topLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topLeft", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setTopLeft(coordinates, context)
        }
        return self
    }

    /// Position on the topLeft corner of its superview.
    @discardableResult
    func topLeft() -> PinLayout {
        func context() -> String { return "topLeft()" }
        setTop(0, context)
        setLeft(0, context)
        return self
    }
    
    /// Position the topCenter on the specified view's pin.
    @discardableResult
    func topCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setTopCenter(coordinates, context)
        }
        return self
    }

    /// Position on the topCenter corner of its superview.
    @discardableResult
    func topCenter() -> PinLayout {
        func context() -> String { return "topCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setTop(0, context)
        setHorizontalCenter(layoutSuperview.frame.width / 2, context)
        return self
    }

    /// Position the topRight on the specified view's pin.
    @discardableResult
    func topRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topRight", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setTopRight(coordinates, context)
        }
        return self
    }

    /// Position on the topRight corner of its superview.
    @discardableResult
    func topRight() -> PinLayout {
        func context() -> String { return "topRight()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setTop(0, context)
        setRight(layoutSuperview.frame.width, context)
        return self
    }
    
    /// Position the leftCenter on the specified view's pin.
    @discardableResult
    func leftCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "leftCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setLeftCenter(coordinates, context)
        }
        return self
    }
    
    /// Position on the leftCenter corner of its superview.
    @discardableResult
    func leftCenter() -> PinLayout {
        func context() -> String { return "leftCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setLeft(0, context)
        setVerticalCenter(layoutSuperview.frame.height / 2, context)
        return self
    }

    /// Position the centers on the specified view's pin.
    @discardableResult
    func center(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "center", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setCenter(coordinates, context)
        }
        return self
    }
    
    @discardableResult
    func center() -> PinLayout {
        func context() -> String { return "center()" }

        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setHorizontalCenter(layoutSuperview.frame.width / 2, context)
        setVerticalCenter(layoutSuperview.frame.height / 2, context)
        return self
    }
    
    /// Position the rightCenter on the specified view's pin.
    @discardableResult
    func rightCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "rightCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setRightCenter(coordinates, context)
        }
        return self
    }
    
    /// Position on the rightCenter corner of its superview.
    @discardableResult
    func rightCenter() -> PinLayout {
        func context() -> String { return "rightCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width, context)
        setVerticalCenter(layoutSuperview.frame.height / 2, context)
        return self
    }
    
    /// Position the bottomLeft on the specified view's pin.
    @discardableResult
    func bottomLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomLeft", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setBottomLeft(coordinates, context)
        }
        return self
    }

    /// Position on the bottomLeft corner of its superview.
    @discardableResult
    func bottomLeft() -> PinLayout {
        func context() -> String { return "bottomLeft()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setLeft(0, context)
        setBottom(layoutSuperview.frame.height, context)
        return self
    }

    /// Position the bottomCenter on the specified view's pin.
    @discardableResult
    func bottomCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setBottomCenter(coordinates, context)
        }
        return self
    }

    /// Position on the bottomCenter corner of its superview.
    @discardableResult
    func bottomCenter() -> PinLayout {
        func context() -> String { return "bottomCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setHorizontalCenter(layoutSuperview.frame.width / 2, context)
        setBottom(layoutSuperview.frame.height, context)
        return self
    }

    /// Position the bottomRight on the specified view's pin.
    @discardableResult
    func bottomRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomRight", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchor: anchor, context) {
            setBottomRight(coordinates, context)
        }
        return self
    }

    /// Position on the bottomRight corner of its superview.
    @discardableResult
    func bottomRight() -> PinLayout {
        func context() -> String { return "bottomRight()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottom(layoutSuperview.frame.height, context)
        setRight(layoutSuperview.frame.width, context)
        return self
    }

    /// Set the view's bottom coordinate above of the specified view.
    @discardableResult
    func above(of referenceView: UIView) -> PinLayout {
        func context() -> String { return "above(of: \(view))" }
        if let coordinate = computeCoordinate(forEdge: referenceView.edge.top, context) {
            setBottom(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func above(of referenceView: UIView, aligned: HorizontalAlignment) -> PinLayout {
        func context() -> String { return "above(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .left:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.topLeft, context) {
                setBottomLeft(coordinates, context)
            }
        case .center:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.topCenter, context) {
                setBottomCenter(coordinates, context)
            }
        case .right:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.topRight, context) {
                setBottomRight(coordinates, context)
            }
        }
        return self
    }
    
    /// Set the view's top coordinate below of the specified view.
    @discardableResult
    func below(of referenceView: UIView) -> PinLayout {
        func context() -> String { return "below(of: \(view))" }
        if let coordinate = computeCoordinate(forEdge: referenceView.edge.bottom, context) {
            setTop(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func below(of referenceView: UIView, aligned: HorizontalAlignment) -> PinLayout {
        func context() -> String { return "below(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .left:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.bottomLeft, context) {
                setTopLeft(coordinates, context)
            }
        case .center:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.bottomCenter, context) {
                setTopCenter(coordinates, context)
            }
        case .right:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.bottomRight, context) {
                setTopRight(coordinates, context)
            }
        }
        return self
    }
    
    /// Set the view's right coordinate left of the specified view.
    @discardableResult
    func left(of referenceView: UIView) -> PinLayout {
        func context() -> String { return "left(of: \(view))" }
        if let coordinate =  computeCoordinate(forEdge: referenceView.edge.left, context) {
            setRight(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func left(of referenceView: UIView, aligned: VerticalAlignment) -> PinLayout {
        func context() -> String { return "left(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .top:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.topLeft, context) {
                setTopRight(coordinates, context)
            }
        case .center:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.leftCenter, context) {
                setRightCenter(coordinates, context)
            }
        case .bottom:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.bottomLeft, context) {
                setBottomRight(coordinates, context)
            }
        }
        return self
    }
    
    /// Set the view's left coordinate right of the specified view.
    @discardableResult
    func right(of referenceView: UIView) -> PinLayout {
        func context() -> String { return "right(of: \(view))" }
        if let coordinate = computeCoordinate(forEdge: referenceView.edge.right, context) {
            setLeft(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func right(of referenceView: UIView, aligned: VerticalAlignment) -> PinLayout {
        func context() -> String { return "right(of: \(view), aligned: \(aligned))" }
        
        switch aligned {
        case .top:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.topRight, context) {
                setTopLeft(coordinates, context)
            }
        case .center:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.rightCenter, context) {
                setLeftCenter(coordinates, context)
            }
        case .bottom:
            if let coordinates = computeCoordinates(forAnchor: referenceView.anchor.bottomRight, context) {
                setBottomLeft(coordinates, context)
            }
        }
        return self
    }
    
    //
    // width, height
    //
    @discardableResult
    func width(_ width: CGFloat) -> PinLayout {
        return setWidth(width, { return "width(\(width))" })
    }
    
    @discardableResult
    func width(percent: CGFloat) -> PinLayout {
        func context() -> String { return "width(percent: \(percent)%)" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setWidth(layoutSuperview.frame.width * percent / 100, context)
    }

    @discardableResult
    func width(of view: UIView) -> PinLayout {
        return setWidth(view.frame.width, { return "width(of: \(view))" })
    }

    @discardableResult
    func height(_ height: CGFloat) -> PinLayout {
        return setHeight(height, { return "height(\(height))" })
    }
    
    @discardableResult
    func height(percent: CGFloat) -> PinLayout {
        func context() -> String { return "height(percent: \(percent)%)" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setHeight(layoutSuperview.frame.height * percent / 100, context)
    }

    @discardableResult
    func height(of view: UIView) -> PinLayout {
        return setHeight(view.frame.height, { return "height(of: \(view))" })
    }
    
    //
    // size, sizeToFit
    //
    @discardableResult
    func size(_ size: CGSize) -> PinLayout {
        if isSizeNotSet({ return "size(CGSize(width: \(size.width), height: \(size.height)))" }) {
            width(size.width)
            height(size.height)
        }
        return self
    }
    
    @discardableResult
    func size(of view: UIView) -> PinLayout {
        func context() -> String { return "size(of \(view))" }
        let viewSize = view.frame.size
        
        if isSizeNotSet(context) {
            setWidth(viewSize.width, context)
            setHeight(viewSize.height, context)
        }
        return self
    }
    
    @discardableResult
    func sizeToFit() -> PinLayout {
        shouldSizeToFit = true
        return self
    }
    
    //
    // Margins
    //
    @discardableResult
    func marginTop(_ value: CGFloat) -> PinLayout {
        marginTop = value
        return self
    }

    @discardableResult
    func marginLeft(_ value: CGFloat) -> PinLayout {
        marginLeft = value
        return self
    }

    @discardableResult
    func marginBottom(_ value: CGFloat) -> PinLayout {
        marginBottom = value
        return self
    }

    @discardableResult
    func marginRight(_ value: CGFloat) -> PinLayout {
        marginRight = value
        return self
    }

    func marginHorizontal(_ value: CGFloat) -> PinLayout {
        marginLeft = value
        marginRight = value
        return self
    }

    @discardableResult
    func marginVertical(_ value: CGFloat) -> PinLayout {
        marginTop = value
        marginBottom = value
        return self
    }

    @discardableResult
    func margin(_ value: CGFloat) -> PinLayout {
        marginTop = value
        marginLeft = value
        marginBottom = value
        marginRight = value
        return self
    }

    @discardableResult
    func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = left
        marginBottom = bottom
        marginRight = right
        return self
    }


    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> PinLayout {
        return self
    }

    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayout {
        return self
    }

    @discardableResult
    func pinEdges() -> PinLayout {
        shouldPinEdges = true
        return self
    }
}

//
// MARK: Private methods
//
extension PinLayoutImpl {
    fileprivate func setTop(_ value: CGFloat, _ context: Context) {
        if _bottom != nil && height != nil {
            warnConflict(context, ["bottom": _bottom!, "height": height!])
        } else if vCenter != nil {
            warnConflict(context, ["Vertical Center": vCenter!])
        } else if _top != nil && _top! != value {
            warnPropertyAlreadySet("top", propertyValue: _top!, context)
        } else {
            _top = value
        }
    }
    
    fileprivate func setLeft(_ value: CGFloat, _ context: Context) {
        if _right != nil && width != nil  {
            warnConflict(context, ["right": _right!, "width": width!])
        } else if hCenter != nil {
            warnConflict(context, ["Horizontal Center": hCenter!])
        } else if _left != nil && _left! != value {
            warnPropertyAlreadySet("left", propertyValue: _left!, context)
        } else {
            _left = value
        }
    }
    
    fileprivate func setRight(_ value: CGFloat, _ context: Context) {
        if _left != nil && width != nil  {
            warnConflict(context, ["left": _left!, "width": width!])
        } else if hCenter != nil {
            warnConflict(context, ["Horizontal Center": hCenter!])
        } else if _right != nil && _right! != value {
            warnPropertyAlreadySet("right", propertyValue: _right!, context)
        } else {
            _right = value
        }
    }
    
    fileprivate func setBottom(_ value: CGFloat, _ context: Context) {
        if _top != nil && height != nil {
            warnConflict(context, ["top": _top!, "height": height!])
        } else if vCenter != nil {
            warnConflict(context, ["Vertical Center": vCenter!])
        } else if _bottom != nil && _bottom! != value {
            warnPropertyAlreadySet("bottom", propertyValue: _bottom!, context)
        } else {
            _bottom = value
        }
    }

    fileprivate func setHorizontalCenter(_ value: CGFloat, _ context: Context) {
        if _left != nil {
            warnConflict(context, ["left": _left!])
        } else if _right != nil {
            warnConflict(context, ["right": _right!])
        } else if hCenter != nil && hCenter! != value {
            warnPropertyAlreadySet("Horizontal Center", propertyValue: hCenter!, context)
        } else {
            hCenter = value
        }
    }
    
    fileprivate func setVerticalCenter(_ value: CGFloat, _ context: Context) {
        if _top != nil {
            warnConflict(context, ["top": _top!])
        } else if _bottom != nil {
            warnConflict(context, ["bottom": _bottom!])
        } else if vCenter != nil && vCenter! != value {
            warnPropertyAlreadySet("Vertical Center", propertyValue: vCenter!, context)
        } else {
            vCenter = value
        }
    }
    
    @discardableResult
    fileprivate func setTopLeft(_ point: CGPoint, _ context: Context) -> PinLayout {
        setLeft(point.x, context)
        setTop(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setTopCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setHorizontalCenter(point.x, context)
        setTop(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setTopRight(_ point: CGPoint, _ context: Context) -> PinLayout {
        setRight(point.x, context)
        setTop(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setLeftCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setLeft(point.x, context)
        setVerticalCenter(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setHorizontalCenter(point.x, context)
        setVerticalCenter(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setRightCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setRight(point.x, context)
        setVerticalCenter(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomLeft(_ point: CGPoint, _ context: Context) -> PinLayout {
        setLeft(point.x, context)
        setBottom(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setHorizontalCenter(point.x, context)
        setBottom(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomRight(_ point: CGPoint, _ context: Context) -> PinLayout {
        setRight(point.x, context)
        setBottom(point.y, context)
        return self
    }
    
    @discardableResult
    fileprivate func setWidth(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard value >= 0 else {
            warn("The width (\(value)) must be greater or equal to 0.", context); return self
        }
        
        if _left != nil && _right != nil {
            warnConflict(context, ["left": _left!, "right": _right!])
        } else if width != nil {
            warnPropertyAlreadySet("width", propertyValue: width!, context)
        } else {
            width = value
        }
        return self
    }
    
    @discardableResult
    fileprivate func setHeight(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard value >= 0 else {
            warn("The height (\(value)) must be greater or equal to 0.", context); return self
        }
        
        if _top != nil && _bottom != nil {
            warnConflict(context, ["top": _top!, "bottom": _bottom!])
        } else if height != nil {
            warnPropertyAlreadySet("height", propertyValue: height!, context)
        } else {
            height = value
        }
        return self
    }
    
    fileprivate func isSizeNotSet(_ context: Context) -> Bool {
        if _top != nil && _bottom != nil {
            warnConflict(context, ["top": _top!, "bottom": _bottom!])
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
    
    fileprivate func computeCoordinates(_ point: CGPoint, _ layoutSuperview: UIView, _ referenceView: UIView, _ referenceSuperview: UIView) -> CGPoint {
        if layoutSuperview == referenceSuperview {
            return point   // same superview => no coordinates conversion required.
        } else {
            return referenceSuperview.convert(point, to: layoutSuperview)
        }
    }

    fileprivate func computeCoordinates(forAnchor anchor: Anchor, _ context: Context) -> CGPoint? {
        let anchor = anchor as! AnchorImpl
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(anchor.view, context) else { return nil }
        
        return computeCoordinates(anchor.point, layoutSuperview, anchor.view, referenceSuperview)
    }
    
    fileprivate func computeCoordinate(forEdge edge: HorizontalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! HorizontalEdgeImpl
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }
        
        return computeCoordinates(CGPoint(x: edge.x, y: 0), layoutSuperview, edge.view, referenceSuperview).x
    }

    fileprivate func computeCoordinate(forEdge edge: VerticalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! VerticalEdgeImpl
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }

        return computeCoordinates(CGPoint(x: 0, y: edge.y), layoutSuperview, edge.view, referenceSuperview).y
    }

    fileprivate func layoutSuperview(_ context: Context) -> UIView? {
        if let superview = view.superview {
            return superview
        } else {
            warn("The view must be added to a UIView before being layouted using this method.", context)
            return nil
        }
    }

    fileprivate func referenceSuperview(_ referenceView: UIView, _ context: Context) -> UIView? {
        if let superview = referenceView.superview {
            return superview
        } else {
            warn("The view must be added to a UIView before being used as a reference.", context)
            return nil
        }
    }
    
    fileprivate func apply() {
        apply(onView: view)
    }
    
    fileprivate func apply(onView view: UIView) {
        var newRect = view.frame

        handleMarginsAsInsets()

        let newSize = computeSize()
        
        // Compute horizontal position
        if let left = _left, let right = _right {
            // left & right is set
            newRect.origin.x = left + _marginLeft
            newRect.size.width = right - _marginRight - newRect.origin.x
        } else if let left = _left, let width = newSize.width {
            // left & width is set
            newRect.origin.x = left + _marginLeft
            newRect.size.width = width
        } else if let right = _right, let width = newSize.width {
            // right & width is set
            newRect.size.width = width
            newRect.origin.x = right - _marginRight - width
        } else if let hCenter = hCenter, let width = newSize.width {
            // hCenter & width is set
            newRect.size.width = width
            newRect.origin.x = hCenter - (width / 2) + _marginLeft
        } else if let left = _left {
            // Only left is set
            newRect.origin.x = left + _marginLeft
        } else if let right = _right {
            // Only right is set
            newRect.origin.x = right - view.frame.width - _marginRight
        } else if let hCenter = hCenter {
            // Only hCenter is set
            newRect.origin.x = hCenter - (view.frame.width / 2)
        } else if let width = newSize.width {
            // Only widht is set
            newRect.size.width = width
        }
        
        // Compute vertical position
        if let top = _top, let bottom = _bottom {
            // top & bottom is set
            newRect.origin.y = top + _marginTop
            newRect.size.height = bottom - _marginBottom - newRect.origin.y
        } else if let top = _top, let height = newSize.height {
            // top & height is set
            newRect.origin.y = top + _marginTop
            newRect.size.height = height
        } else if let bottom = _bottom, let height = newSize.height {
            // bottom & height is set
            newRect.size.height = height
            newRect.origin.y = bottom - _marginBottom - height
        } else if let vCenter = vCenter, let height = newSize.height {
            // vCenter & height is set
            newRect.size.height = height
            newRect.origin.y = vCenter - (newRect.size.height / 2) + _marginTop
        } else if let top = _top {
            // Only top is set
            newRect.origin.y = top + _marginTop
        } else if let bottom = _bottom {
            // Only bottom is set
            newRect.origin.y = bottom - view.frame.height - _marginBottom
        } else if let vCenter = vCenter {
            // Only vCenter is set
            newRect.origin.y = vCenter - (view.frame.height / 2)
        } else if let height = newSize.height {
            // Only height is set
            newRect.size.height = height
        }

        view.frame = Coordinates.adjustRectToDisplayScale(newRect)
    }

    fileprivate func handleMarginsAsInsets() {
        guard shouldPinEdges else { return }

        if let width = width {
            if let left = _left {
                // convert the width into a right
                assert(self._right == nil)
                self._right = left + width
                self.width = nil
            } else if let right = _right {
                // convert the width into a left
                assert(self._left == nil)
                self._left = right - width
                self.width = nil
            } else if let hCenter = hCenter {
                // convert the width & hCenter into a left & right
                assert(self._left == nil && self._right == nil)
                let halfWidth = width / 2
                self._left = hCenter - halfWidth
                self._right = hCenter + halfWidth
                self.hCenter = nil
                self.width = nil
            }
        }

        if let height = height {
            if let top = _top {
                // convert the height into a bottom
                assert(self._right == nil)
                self._bottom = top + height
                self.height = nil
            } else if let bottom = _bottom {
                // convert the height into a top
                assert(self._top == nil)
                self._top = bottom - height
                self.height = nil
            } else if let vCenter = vCenter {
                // convert the height & vCenter into a top & bottom
                assert(self._top == nil && self._bottom == nil)
                let halfHeight = height / 2
                self._top = vCenter - halfHeight
                self._bottom = vCenter + halfHeight
                self.vCenter = nil
                self.height = nil
            }
        }
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
        if let _ = _left, let right = _right {
            return right - _marginRight
        } else if let width = width {
            return width
        } else {
            return nil
        }
    }
    
    fileprivate func computeHeight() -> CGFloat? {
        if let _ = _top, let bottom = _bottom {
            return bottom - _marginBottom
        } else if let height = height {
            return height
        } else {
            return nil
        }
    }

    fileprivate func pointContext(method: String, point: CGPoint) -> String {
        return "\(method)(to: CGPoint(x: \(point.x), y: \(point.y)))"
    }

    fileprivate func relativeEdgeContext(method: String, edge: VerticalEdge) -> String {
        let edge = edge as! VerticalEdgeImpl
        return "\(method)(to: \(edge.type.rawValue), of: \(edge.view))"
    }

    fileprivate func relativeEdgeContext(method: String, edge: HorizontalEdge) -> String {
        let edge = edge as! HorizontalEdgeImpl
        return "\(method)(to: \(edge.type.rawValue), of: \(edge.view))"
    }

    fileprivate func relativeAnchorContext(method: String, anchor: Anchor) -> String {
        let anchor = anchor as! AnchorImpl
        return "\(method)(to: \(anchor.type.rawValue), of: \(anchor.view))"
    }

    fileprivate func warn(_ text: String, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        print("\n👉 Layout Warning: \(context()). \(text)\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        print("\n👉 Layout Conflict: \(context()) won't be applied since it value has already been set to \(propertyValue).\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, _ context: Context) {
        guard PinLayoutLogConflicts else { return }
        print("\n👉 Layout Conflict: \(context()) won't be applied since it value has already been set to CGSize(width: \(propertyValue.width), height: \(propertyValue.height)).\n")
    }
    
    fileprivate func warnConflict(_ context: Context, _ properties: [String: CGFloat]) {
        guard PinLayoutLogConflicts else { return }
        var warning = "\n👉 Layout Conflict: \(context()) won't be applied since it conflicts with the following already set properties:\n"
        properties.forEach { (key, value) in
            warning += " \(key): \(value)\n"
        }
        
        print(warning)
    }
}
