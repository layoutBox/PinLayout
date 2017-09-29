//
//  PinLayoutImpl+Coordinates.swift
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-06-17.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
#if os(iOS) || os(tvOS)
import UIKit

extension PinLayoutImpl {
    internal func setTop(_ value: CGFloat, _ context: Context) {
        if let _bottom = _bottom, let height = height {
            warnConflict(context, ["bottom": _bottom, "height": height])
        } else if let _vCenter = _vCenter {
            warnConflict(context, ["Vertical Center": _vCenter])
        } else if let _top = _top, _top != value {
            warnPropertyAlreadySet("top", propertyValue: _top, context)
        } else {
            _top = value
        }
    }
    
    @discardableResult
    internal func left(_ context: Context) -> PinLayout {
        setLeft(0, context)
        return self
    }
    
    @discardableResult
    internal func left(_ value: CGFloat, _ context: Context) -> PinLayout {
        setLeft(value, context)
        return self
    }
    
    @discardableResult
    internal func left(_ percent: Percent, _ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setLeft(percent.of(layoutSuperview.frame.width), context)
        return self
    }
    
    internal func setLeft(_ value: CGFloat, _ context: Context) {
        if let _right = _right, let width = width  {
            warnConflict(context, ["right": _right, "width": width])
        } else if let _hCenter = _hCenter {
            warnConflict(context, ["Horizontal Center": _hCenter])
        } else if let _left = _left, _left != value {
            warnPropertyAlreadySet("left", propertyValue: _left, context)
        } else {
            _left = value
        }
    }
    
    internal func setStart(_ value: CGFloat, _ context: Context) {
        if isLTR() {
            setLeft(value, context)
        } else {
            setRight(value, context)
        }
    }
    
    @discardableResult
    internal func right(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width, context)
        return self
    }
    
    @discardableResult
    internal func right(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width - value, context)
        return self
    }
    
    @discardableResult
    internal func right(_ percent: Percent, _ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setRight(layoutSuperview.frame.width - percent.of(layoutSuperview.frame.width), context)
        return self
    }
    
    internal func setRight(_ value: CGFloat, _ context: Context) {
        if let _left = _left, let width = width  {
            warnConflict(context, ["left": _left, "width": width])
        } else if let _hCenter = _hCenter {
            warnConflict(context, ["Horizontal Center": _hCenter])
        } else if let _right = _right, _right != value {
            if let layoutSuperview = layoutSuperview(context) {
                warnPropertyAlreadySet("right", propertyValue: layoutSuperview.frame.width - _right, context)
            } else {
                warnPropertyAlreadySet("right", propertyValue: _right, context)
            }
        } else {
            _right = value
        }
    }
    
    // TODO: Delete this function?
    internal func setEnd(_ value: CGFloat, _ context: Context) {
        if isLTR() {
            setRight(value, context)
        } else {
            setLeft(value, context)
        }
    }
    
    internal func setBottom(_ value: CGFloat, _ context: Context) {
        if let _top = _top, let height = height {
            warnConflict(context, ["top": _top, "height": height])
        } else if let _vCenter = _vCenter {
            warnConflict(context, ["Vertical Center": _vCenter])
        } else if let _bottom = _bottom, _bottom != value {
            warnPropertyAlreadySet("bottom", propertyValue: _bottom, context)
        } else {
            _bottom = value
        }
    }
    
    internal func setHorizontalCenter(_ value: CGFloat, _ context: Context) {
        if let _left = _left {
            warnConflict(context, ["left": _left])
        } else if let _right = _right {
            warnConflict(context, ["right": _right])
        } else if let _hCenter = _hCenter, _hCenter != value {
            warnPropertyAlreadySet("Horizontal Center", propertyValue: _hCenter, context)
        } else {
            _hCenter = value
        }
    }
    
    internal func setVerticalCenter(_ value: CGFloat, _ context: Context) {
        if let _top = _top {
            warnConflict(context, ["top": _top])
        } else if let _bottom = _bottom {
            warnConflict(context, ["bottom": _bottom])
        } else if let _vCenter = _vCenter, _vCenter != value {
            warnPropertyAlreadySet("Vertical Center", propertyValue: _vCenter, context)
        } else {
            _vCenter = value
        }
    }
    
    @discardableResult
    internal func setTopLeft(_ point: CGPoint, _ context: Context) -> PinLayout {
        setTop(point.y, context)
        setLeft(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setTopCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setTop(point.y, context)
        setHorizontalCenter(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setTopRight(_ point: CGPoint, _ context: Context) -> PinLayout {
        setTop(point.y, context)
        setRight(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setCenterLeft(_ point: CGPoint, _ context: Context) -> PinLayout {
        setVerticalCenter(point.y, context)
        setLeft(point.x, context)
        return self
    }

    @discardableResult
    internal func setCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setVerticalCenter(point.y, context)
        setHorizontalCenter(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setCenterRight(_ point: CGPoint, _ context: Context) -> PinLayout {
        setVerticalCenter(point.y, context)
        setRight(point.x, context)
        return self
    }

    @discardableResult
    internal func setBottomLeft(_ point: CGPoint, _ context: Context) -> PinLayout {
        setBottom(point.y, context)
        setLeft(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setBottomCenter(_ point: CGPoint, _ context: Context) -> PinLayout {
        setBottom(point.y, context)
        setHorizontalCenter(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setBottomRight(_ point: CGPoint, _ context: Context) -> PinLayout {
        setBottom(point.y, context)
        setRight(point.x, context)
        return self
    }
    
    @discardableResult
    internal func setWidth(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateWidth(value, context: context) else { return self }
        
        if let width = width, width != value {
            warnPropertyAlreadySet("width", propertyValue: width, context)
        } else {
            width = value
        }
        return self
    }
    
    @discardableResult
    internal func setMinWidth(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateWidth(value, context: context) else { return self }
        
        if let minWidth = minWidth, minWidth != value {
            warnConflict(context, ["minWidth": minWidth])
        } else {
            minWidth = value
        }
        return self
    }
    
    @discardableResult
    internal func setMaxWidth(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateWidth(value, context: context) else { return self }
        
        if let maxWidth = maxWidth, maxWidth != value {
            warnConflict(context, ["maxWidth": maxWidth])
        } else {
            maxWidth = value
        }
        return self
    }
    
    @discardableResult
    internal func setHeight(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateHeight(value, context: context) else { return self }
        
        if let height = height, height != value {
            warnPropertyAlreadySet("height", propertyValue: height, context)
        } else {
            height = value
        }
        return self
    }
    
    @discardableResult
    internal func setMinHeight(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateHeight(value, context: context) else { return self }
        
        if let minHeight = minHeight, minWidth != value {
            warnConflict(context, ["minHeight": minHeight])
        } else {
            minHeight = value
        }
        return self
    }
    
    @discardableResult
    internal func setMaxHeight(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard validateHeight(value, context: context) else { return self }
        
        if let maxHeight = maxHeight, maxHeight != value {
            warnConflict(context, ["maxHeight": maxHeight])
        } else {
            maxHeight = value
        }
        return self
    }
    
    internal func validateWidth(_ width: CGFloat, context: Context) -> Bool {
        if width < 0 {
            warnWontBeApplied("the width (\(width)) must be greater than or equal to zero.", context);
            return false
        } else {
            return true
        }
    }
    
    internal func validateComputedWidth(_ width: CGFloat?) -> Bool {
        if let width = width, width < 0 {
            warn("The computed width (\(width)) must be greater than or equal to zero. The view will keep its current width.")
            return false
        } else {
            return true
        }
    }
    
    internal func validateHeight(_ height: CGFloat, context: Context) -> Bool {
        if height < 0 {
            warnWontBeApplied("the height (\(height)) must be greater than or equal to zero.", context);
            return false
        } else {
            return true
        }
    }
    
    internal func validateComputedHeight(_ height: CGFloat?) -> Bool {
        if let height = height, height < 0 {
            warn("The computed height (\(height)) must be greater than or equal to zero. The view will keep its current height.")
            return false
        } else {
            return true
        }
    }
    
    internal func setSize(_ size: CGSize, _ context: Context) -> PinLayout {
        setWidth(size.width, { return "\(context())'s width" })
        setHeight(size.height, { return "\(context())'s height" })
        return self
    }
    
    fileprivate func computeCoordinates(_ point: CGPoint, _ layoutSuperview: UIView, _ referenceView: UIView, _ referenceSuperview: UIView) -> CGPoint {
        if layoutSuperview == referenceSuperview {
            return point   // same superview => no coordinates conversion required.
        } else {
            return referenceSuperview.convert(point, to: layoutSuperview)
        }
    }
    
    internal  func computeCoordinates(forAnchors anchors: [Anchor], _ context: Context) -> [CGPoint]? {
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        var results: [CGPoint] = []
        anchors.forEach({ (anchor) in
            let anchor = anchor as! AnchorImpl
            if let referenceSuperview = referenceSuperview(anchor.view, context) {
                results.append(computeCoordinates(anchor.point, layoutSuperview, anchor.view, referenceSuperview))
            }
        })
        
        guard results.count > 0 else {
            warnWontBeApplied("no valid references", context)
            return nil
        }
        
        return results
    }
    
    internal func computeCoordinate(forEdge edge: HorizontalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! HorizontalEdgeImpl
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }
        
        return computeCoordinates(CGPoint(x: edge.x, y: 0), layoutSuperview, edge.view, referenceSuperview).x
    }
    
    internal func computeCoordinate(forEdge edge: VerticalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! VerticalEdgeImpl
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }
        
        return computeCoordinates(CGPoint(x: 0, y: edge.y), layoutSuperview, edge.view, referenceSuperview).y
    }
}

#endif
