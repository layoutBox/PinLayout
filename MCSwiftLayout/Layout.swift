//
//  Layout.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-17.
//  Copyright © 2017 Mirego. All rights reserved.
//
import UIKit

/*
 TODO:
    - implement sizeThatFits
            - Insets should be applied to width and height before calling view.sizeThatFits()
 
    - Implement Layout + Layout operator
 
    - layout.snapTopLeft(to: .bottomRight, of: view2)
    - layout.snapTopLeft(to: .bottomRight, of: view2)
    - layout.snapTopLeft(to: view2, .bottomRight)
    - layout.topLeft(to: .bottomRight, of: view2)
    - layout.topLeft(view2.bottomRight) -> Ne fonctionne pas si pas le même parent!
    - layout.snapTop(to: .bottom, of: view2)
    - layout.top(to: .bottom, of: view2)
 
 
    - Implement 
            - marginHorizontal
            - marginVertical
            - insetHorizontal
            - insetVertical
            - inset(t:? = nil l:? = nil  b:? = nil  r:? = nil ) ??
            - margin(t:? = nil  l:? = nil  b:? = nil  r:? = nil ) ??
 */

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


public class Layout {
    static var logConflicts = true

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
    
    public init (view: UIView/*? = nil*/) {
        self.view = view
    }
    
    deinit {
        apply()
    }
    
    //
    // top, left, bottom, right, topLeft, topCenter, topRight, ...
    //
    @discardableResult
    public func top(_ value: CGFloat) -> Layout {
        setTopCoordinate(value, setterContext: "top(\(value))")
        return self
    }
    
    @discardableResult
    public func left(_ value: CGFloat) -> Layout {
        setLeftCoordinate(value, setterContext: "left(\(value))")
        return self
    }
    
    @discardableResult
    public func bottom(_ value: CGFloat) -> Layout {
        setBottomCoordinate(value, setterContext: "bottom(\(value))")
        return self
    }
    
    @discardableResult
    public func right(_ value: CGFloat) -> Layout {
        setRightCoordinate(value, setterContext: "right(\(value))")
        return self
    }
    
    //TODO: Add hCenter and vCenter
    
    @discardableResult
    public func topLeft(_ point: CGPoint) -> Layout {
        return setTopLeft(x: point.x, y: point.y, setterContext: "topLeft(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func topLeft(x: CGFloat, y: CGFloat) -> Layout {
//        return setTopLeft(x: x, y: y, setterContext: "topLeft(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func topCenter(_ point: CGPoint) -> Layout {
        return setTopCenter(x: point.x, y: point.y, setterContext: "topCenter(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func topCenter(x: CGFloat, y: CGFloat) -> Layout {
//        return setTopCenter(x: x, y: y, setterContext: "topCenter(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func topRight(_ point: CGPoint) -> Layout {
        return setTopRight(x: point.x, y: point.y, setterContext: "topRight(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func topRight(x: CGFloat, y: CGFloat) -> Layout {
//        return setTopRight(x: x, y: y, setterContext: "topRight(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func leftCenter(_ point: CGPoint) -> Layout {
        return setLeftCenter(x: point.x, y: point.y, setterContext: "leftCenter(CGPoint(\(point.x), \(point.y)))")
    }

//    @discardableResult
//    public func leftCenter(x: CGFloat, y: CGFloat) -> Layout {
//        return setLeftCenter(x: x, y: y, setterContext: "leftCenter(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func centers(_ point: CGPoint) -> Layout {
        return setCenters(x: point.x, y: point.y, setterContext: "centers(CGPoint(\(point.x), \(point.y)))")
    }
    
    @discardableResult
    public func centers(of relativeView: UIView) -> Layout {        
        if let layoutSuperview = validateLayoutSuperview(setterContext: "centers(of: \(view))") {
            if let relativeSuperview = relativeView.superview {
                let center: CGPoint
                if layoutSuperview == relativeSuperview {
                    center = relativeView.centers   // same parent => no coordinates conversion required.
                } else {
                    center = relativeSuperview.convert(relativeView.centers, to: layoutSuperview)
                }
                setCenters(x: center.x, y: center.y, setterContext: "centers(of: \(view))")
            } else {
                warn("relative view's superview is nil", setterContext: "centers(of: \(view))")
            }
        }
        return self
    }

    @discardableResult
    public func centers() -> Layout {
        if let layoutSuperview = validateLayoutSuperview(setterContext: "centers()") {
            let center = layoutSuperview.center
            setCenters(x: center.x, y: center.y, setterContext: "centers()")
        }
        return self
    }
    
    fileprivate func validateLayoutSuperview(setterContext: @autoclosure () -> String) -> UIView? {
        if let parentView = view.superview {
            return parentView
        } else {
            warn("Layout's view must be added to a UIView before being layouted using this method.", setterContext: setterContext)
            return nil
        }
    }

    
//    @discardableResult
//    public func centers(x: CGFloat, y: CGFloat) -> Layout {
//        return setCenters(x: x, y: y, setterContext: "centers(x: \(x), y:\(y))")
//    }

    @discardableResult
    public func rightCenter(_ point: CGPoint) -> Layout {
        return setRightCenter(x: point.x, y: point.y, setterContext: "rightCenter(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func rightCenter(x: CGFloat, y: CGFloat) -> Layout {
//        return setRightCenter(x: x, y: y, setterContext: "rightCenter(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func bottomLeft(_ point: CGPoint) -> Layout {
        return setBottomLeft(x: point.x, y: point.y, setterContext: "bottomLeft(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func bottomLeft(x: CGFloat, y: CGFloat) -> Layout {
//        return setBottomLeft(x: x, y: y, setterContext: "bottomLeft(x: \(x), y:\(y))")
//    }

    @discardableResult
    public func bottomCenter(_ point: CGPoint) -> Layout {
        return setBottomCenter(x: point.x, y: point.y, setterContext: "bottomCenter(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func bottomCenter(x: CGFloat, y: CGFloat) -> Layout {
//        return setBottomCenter(x: x, y: y, setterContext: "bottomCenter(x: \(x), y:\(y))")
//    }
    
    @discardableResult
    public func bottomRight(_ point: CGPoint) -> Layout {
        return setBottomRight(x: point.x, y: point.y, setterContext: "bottomRight(CGPoint(\(point.x), \(point.y)))")
    }
    
//    @discardableResult
//    public func bottomRight(x: CGFloat, y: CGFloat) -> Layout {
//        return setBottomRight(x: x, y: y, setterContext: "bottomRight(x: \(x), y:\(y))")
//    }
    
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
    
    @discardableResult
    public func above(of view: UIView) -> Layout {
        setBottomCoordinate(view.top, setterContext: "above(of: \(view))")
        return self
    }
    @discardableResult
    public func above(of view: UIView, aligned: HorizontalAlignment) -> Layout {
        switch aligned {
        case .left:   return setBottomLeft(x: view.topLeft.x, y: view.topLeft.y, setterContext: "above(of: \(view), aligned: .left)")
        case .center: return setBottomCenter(x: view.topCenter.x, y: view.topCenter.y, setterContext: "above(of: \(view), aligned: .center)")
        case .right:  return setBottomRight(x: view.topRight.x, y: view.topRight.y, setterContext: "above(of: \(view), aligned: .right)")
        }
    }
    
    @discardableResult
    public func below(of view: UIView) -> Layout {
        setTopCoordinate(view.bottom, setterContext: "below(of: \(view))")
        return self
    }
    
    @discardableResult
    public func below(of view: UIView, aligned: HorizontalAlignment) -> Layout {
        switch aligned {
        case .left:   return setTopLeft(x: view.bottomLeft.x, y: view.bottomLeft.y, setterContext: "below(of: \(view), aligned: .left)")
        case .center: return setTopCenter(x: view.bottomCenter.x, y: view.bottomCenter.y, setterContext: "below(of: \(view), aligned: .center)")
        case .right:  return setTopRight(x: view.bottomRight.x, y: view.bottomRight.y, setterContext: "below(of: \(view), aligned: .right)")
        }
    }
    
    @discardableResult
    public func left(of view: UIView) -> Layout {
        setRightCoordinate(view.left, setterContext: "left(of: \(view))")
        return self
    }
    
    @discardableResult
    public func left(of view: UIView, aligned: VerticalAlignment) -> Layout {
        switch aligned {
        case .top:    return setTopRight(x: view.topLeft.x, y: view.topLeft.y, setterContext: "left(of: \(view), aligned: .top)")
        case .center: return setRightCenter(x: view.leftCenter.x, y: view.leftCenter.y, setterContext: "left(of: \(view), aligned: .center)")
        case .bottom: return setBottomRight(x: view.bottomLeft.x, y: view.bottomLeft.y, setterContext: "left(of: \(view), aligned: .bottom)")
        }
    }
    
    @discardableResult
    public func right(of view: UIView) -> Layout {
        setLeftCoordinate(view.right, setterContext: "right(of: \(view))")
        return self
    }
    
    @discardableResult
    public func right(of view: UIView, aligned: VerticalAlignment) -> Layout {
        switch aligned {
        case .top:    return setTopLeft(x: view.topRight.x, y: view.topRight.y, setterContext: "right(of: \(view), aligned: .top)")
        case .center: return setLeftCenter(x: view.rightCenter.x, y: view.rightCenter.y, setterContext: "right(of: \(view), aligned: .center)")
        case .bottom: return setBottomLeft(x: view.bottomRight.x, y: view.bottomRight.y, setterContext: "right(of: \(view), aligned: .bottom)")
        }
    }
    
    //
    // width, height
    //
    @discardableResult
    public func width(_ width: CGFloat) -> Layout {
        return setWidth(width, setterContext: "width(\(width))")
    }
    
    @discardableResult
    public func width(of view: UIView) -> Layout {
        return setWidth(view.width, setterContext: "width(of: \(view))")
    }
    
    @discardableResult
    public func height(_ height: CGFloat) -> Layout {
        return setHeight(height, setterContext: "height(\(height))")
    }
    
    @discardableResult
    public func height(of view: UIView) -> Layout {
        return setHeight(view.height, setterContext: "height(of: \(view))")
    }
    
    @discardableResult
    public func size(_ size: CGSize) -> Layout {
        if isSizeNotSet(setterContext: "size(CGSize(width: \(size.width), height: \(size.height)))") {
            width(size.width)
            height(size.height)
        }
        return self
    }
    
    @discardableResult
    public func size(of view: UIView) -> Layout {
        let viewSize = view.frame.size
        
        if isSizeNotSet(setterContext: "size(of \(viewSize))") {
            setWidth(viewSize.width)
            setHeight(view.height)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(size: CGSize) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFits(CGSize(width: \(size.width), height: \(size.height)))") {
            fitSize = size
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(sizeOf view: UIView) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFitsViewSize(\(view))") {
            fitSize = view.size
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(width: CGFloat) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFitsWidth(\(width))") {
            if fitSize == nil {
                fitSize = CGSize(width: width, height: .greatestFiniteMagnitude)
            } else {
                fitSize!.width = width
            }
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(widthOf view: UIView) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFitsWidth(of: \(view))") {
            sizeThatFits(width: view.size.width)
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(height: CGFloat) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFitsHeight(\(height))") {
            if fitSize == nil {
                fitSize = CGSize(width: .greatestFiniteMagnitude, height: height)
            } else {
                fitSize!.height = height
            }
        }
        return self
    }
    
    @discardableResult
    public func sizeThatFits(heightOf view: UIView) -> Layout {
        if isSizeNotSet(setterContext: "sizeThatFitsHeightof: \(view))") {
            sizeThatFits(height: view.size.height)
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
    fileprivate func setTopCoordinate(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if bottom != nil && height != nil {
            warnConflict(setterContext, ["bottom": bottom!, "height": height!])
        } else if vCenter != nil {
            warnConflict(setterContext, ["Vertical Center": vCenter!])
        } else if top != nil {
            warnPropertyAlreadySet("top", propertyValue: top!, setterContext: setterContext)
        } else {
            top = value
        }
    }
    
    fileprivate func setLeftCoordinate(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if right != nil && width != nil  {
            warnConflict(setterContext, ["right": right!, "width": width!])
        } else if hCenter != nil {
            warnConflict(setterContext, ["Horizontal Center": hCenter!])
        } else if left != nil {
            warnPropertyAlreadySet("left", propertyValue: left!, setterContext: setterContext)
        } else {
            left = value
        }
    }
    
    fileprivate func setRightCoordinate(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if left != nil && width != nil  {
            warnConflict(setterContext, ["left": left!, "width": width!])
        } else if hCenter != nil {
            warnConflict(setterContext, ["Horizontal Center": hCenter!])
        } else if right != nil {
            warnPropertyAlreadySet("right", propertyValue: right!, setterContext: setterContext)
        } else {
            right = value
        }
    }
    
    fileprivate func setBottomCoordinate(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if top != nil && height != nil {
            warnConflict(setterContext, ["top": top!, "height": height!])
        } else if vCenter != nil {
            warnConflict(setterContext, ["Vertical Center": vCenter!])
        } else if bottom != nil {
            warnPropertyAlreadySet("bottom", propertyValue: bottom!, setterContext: setterContext)
        } else {
            bottom = value
        }
    }
    
    fileprivate func setHorizontalCenter(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if left != nil {
            warnConflict(setterContext, ["left": left!])
        } else if right != nil {
            warnConflict(setterContext, ["right": right!])
        } else if hCenter != nil {
            warnPropertyAlreadySet("hCenter", propertyValue: hCenter!, setterContext: setterContext)
        } else {
            hCenter = value
        }
    }
    
    fileprivate func setVerticalCenter(_ value: CGFloat, setterContext: @autoclosure () -> String) {
        if top != nil {
            warnConflict(setterContext, ["top": top!])
        } else if bottom != nil {
            warnConflict(setterContext, ["bottom": bottom!])
        } else if vCenter != nil {
            warnPropertyAlreadySet("vCenter", propertyValue: vCenter!, setterContext: setterContext)
        } else {
            vCenter = value
        }
    }
    
    fileprivate func setTopLeft(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setLeftCoordinate(x, setterContext: setterContext)
        setTopCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setTopCenter(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setHorizontalCenter(x, setterContext: setterContext)
        setTopCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setTopRight(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setRightCoordinate(x, setterContext: setterContext)
        setTopCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setLeftCenter(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setLeftCoordinate(x, setterContext: setterContext)
        setVerticalCenter(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setCenters(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setHorizontalCenter(x, setterContext: setterContext)
        setVerticalCenter(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setRightCenter(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setRightCoordinate(x, setterContext: setterContext)
        setVerticalCenter(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomLeft(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setLeftCoordinate(x, setterContext: setterContext)
        setBottomCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomCenter(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setHorizontalCenter(x, setterContext: setterContext)
        setBottomCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setBottomRight(x: CGFloat, y: CGFloat, setterContext: @autoclosure () -> String) -> Layout {
        setRightCoordinate(x, setterContext: setterContext)
        setBottomCoordinate(y, setterContext: setterContext)
        return self
    }
    
    @discardableResult
    fileprivate func setWidth(_ value: CGFloat, setterContext: @autoclosure () -> String = "") -> Layout {
        guard value >= 0 else {
            warn("The width (\(value)) must be greater or equal to 0.", setterContext: setterContext); return self
        }
        
        if left != nil && right != nil {
            warnConflict(setterContext, ["left": left!, "right": right!])
        } else if fitSize != nil {
            warnConflict(setterContext, ["fitSize.width": fitSize!.width, "fitSize.height": fitSize!.height])
        } else if width != nil {
            warnPropertyAlreadySet("width", propertyValue: width!, setterContext: setterContext)
        } else {
            width = value
        }
        return self
    }
    
    @discardableResult
    fileprivate func setHeight(_ value: CGFloat, setterContext: @autoclosure () -> String = "") -> Layout {
        guard value >= 0 else {
            warn("The height (\(value)) must be greater or equal to 0.", setterContext: setterContext); return self
        }
        
        if top != nil && bottom != nil {
            warnConflict(setterContext, ["top": top!, "bottom": bottom!])
        } else if fitSize != nil {
            warnConflict(setterContext, ["fitSize.width": fitSize!.width, "fitSize.height": fitSize!.height])
        } else if height != nil {
            warnPropertyAlreadySet("height", propertyValue: height!, setterContext: setterContext)
        } else {
            height = value
        }
        return self
    }
    
    fileprivate func isSizeNotSet(setterContext: String) -> Bool {
        if top != nil && bottom != nil {
            warnConflict(setterContext, ["top": top!, "bottom": bottom!])
            return false
        } else if height != nil {
            warnConflict(setterContext, ["height": height!])
            return false
        } else if width != nil {
            warnConflict(setterContext, ["width": width!])
            return false
        } else if fitSize != nil {
            warnPropertyAlreadySet("fitSize", propertyValue: fitSize!, setterContext: setterContext)
            return false
        } else {
            return true
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
    
    fileprivate func warn(_ text: String, setterContext: @autoclosure () -> String) {
        guard Layout.logConflicts else { return }
        print("\n\(text)(\(setterContext()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, setterContext: @autoclosure () -> String) {
        guard Layout.logConflicts else { return }
        print("\nLayou2: The \(propertyName) property has already been set to \(propertyValue). (\(setterContext()))\n")
    }
    
    fileprivate func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, setterContext: @autoclosure () -> String) {
        print("\nLayou2: The \(propertyName) property has already been set to CGSize(width: \(propertyValue.width), height: \(propertyValue.height)). (\(setterContext()))\n")
    }
    
    fileprivate func warnConflict(_ setterContext: @autoclosure () -> String, _ properties: [String: CGFloat]) {
        guard Layout.logConflicts else { return }
        var warning = "\nLayout Conflict: '\(setterContext())' won't be applied since it conflicts with the following already set properties:\n"
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
