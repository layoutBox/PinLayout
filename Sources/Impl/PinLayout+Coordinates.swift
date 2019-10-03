//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

extension PinLayout {
    internal func top(_ context: Context) {
        setTop(0, context)
    }

    @discardableResult
    internal func top(_ value: CGFloat, _ context: Context) -> PinLayout {
        setTop(value, context)
        return self
    }

    @discardableResult
    internal func top(_ percent: Percent, _ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTop(percent.of(layoutSuperviewRect.height), context)
        return self
    }
    
    internal func setTop(_ value: CGFloat, _ context: Context) {
        if let _vCenter = _vCenter {
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
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setLeft(percent.of(layoutSuperviewRect.width), context)
        return self
    }
    
    internal func setLeft(_ value: CGFloat, _ context: Context) {
        if let _hCenter = _hCenter {
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
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setRight(layoutSuperviewRect.width, context)
        return self
    }
    
    @discardableResult
    internal func right(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setRight(layoutSuperviewRect.width - value, context)
        return self
    }
    
    @discardableResult
    internal func right(_ percent: Percent, _ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setRight(layoutSuperviewRect.width - percent.of(layoutSuperviewRect.width), context)
        return self
    }
    
    internal func setRight(_ value: CGFloat, _ context: Context) {
        if let _hCenter = _hCenter {
            warnConflict(context, ["Horizontal Center": _hCenter])
        } else if let _right = _right, _right != value {
            if let superview = view.superview {
                let rect = superview.getRect(keepTransform: keepTransform)
                warnPropertyAlreadySet("right", propertyValue: rect.width - _right, context)
            } else {
                warnPropertyAlreadySet("right", propertyValue: _right, context)
            }
        } else {
            _right = value
        }
    }
    
    internal func setEnd(_ value: CGFloat, _ context: Context) {
        if isLTR() {
            setRight(value, context)
        } else {
            setLeft(value, context)
        }
    }
    
    @discardableResult
    internal func bottom(_ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottom(layoutSuperviewRect.height, context)
        return self
    }
    
    @discardableResult
    internal func bottom(_ value: CGFloat, _ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottom(layoutSuperviewRect.height - value, context)
        return self
    }

    @discardableResult
    internal func bottom(_ percent: Percent, _ context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottom(layoutSuperviewRect.height - percent.of(layoutSuperviewRect.height), context)
        return self
    }
    
    internal func setBottom(_ value: CGFloat, _ context: Context) {
        if let _vCenter = _vCenter {
            warnConflict(context, ["Vertical Center": _vCenter])
        } else if let _bottom = _bottom, _bottom != value {
            if let superview = view.superview {
                let rect = superview.getRect(keepTransform: keepTransform)
                warnPropertyAlreadySet("bottom", propertyValue: rect.height - _bottom, context)
            } else {
                warnPropertyAlreadySet("bottom", propertyValue: _bottom, context)
            }
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
        guard width >= 0, width.isFinite else {
            warnWontBeApplied("the width (\(width)) must be greater than or equal to zero.", context)
            return false
        }
        
        return true
    }
    
    internal func validateComputedWidth(_ width: CGFloat?) -> Bool {
        if let width = width, !width.isFinite || width < 0 {
            return false
        } else {
            return true
        }
    }
    
    internal func validateHeight(_ height: CGFloat, context: Context) -> Bool {
        guard height >= 0, height.isFinite else {
            warnWontBeApplied("the height (\(height)) must be greater than or equal to zero.", context)
            return false
        }
        
        return true
    }
    
    internal func validateComputedHeight(_ height: CGFloat?) -> Bool {
        if let height = height, !height.isFinite || height < 0 {
            return false
        } else {
            return true
        }
    }
    
    private func computeCoordinates(_ point: CGPoint, _ layoutSuperview: View, _ referenceSuperview: View) -> CGPoint {
        if layoutSuperview == referenceSuperview {
            return point   // same superview => no coordinates conversion required.
        } else if referenceSuperview == layoutSuperview.superview as? View {
            let layoutSuperviewRect = layoutSuperview.getRect(keepTransform: keepTransform)
            return CGPoint(x: point.x - layoutSuperviewRect.origin.x,
                           y: point.y - layoutSuperviewRect.origin.y)
        // TOOD: Handle all cases. computeCoordinates should compute coordinates using only untransformed
        //       coordinates, but UIView.convert(...) below use transformed coordinates!
        //       Currently we only support 1 and 2 levels.
        } else {
            return referenceSuperview.convert(point, to: layoutSuperview as? View.View)
        }
    }
    
    internal  func computeCoordinates(forAnchors anchors: [Anchor], _ context: Context) -> [CGPoint]? {
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        var results: [CGPoint] = []
        anchors.forEach({ (anchor) in
            let anchor = anchor as! AnchorImpl<View>
            if let referenceSuperview = referenceSuperview(anchor.view, context) {
                results.append(computeCoordinates(anchor.point(keepTransform: keepTransform),
                                                  layoutSuperview, referenceSuperview))
            }
        })
        
        guard results.count > 0 else { return nil }
        return results
    }
    
    internal func computeCoordinate(forEdge edge: HorizontalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! HorizontalEdgeImpl<View>
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }
        
        return computeCoordinates(CGPoint(x: edge.x(keepTransform: keepTransform), y: 0),
                                  layoutSuperview, referenceSuperview).x
    }
    
    internal func computeCoordinate(forEdge edge: VerticalEdge, _ context: Context) -> CGFloat? {
        let edge = edge as! VerticalEdgeImpl<View>
        guard let layoutSuperview = layoutSuperview(context) else { return nil }
        guard let referenceSuperview = referenceSuperview(edge.view, context) else { return nil }
        
        return computeCoordinates(CGPoint(x: 0, y: edge.y(keepTransform: keepTransform)),
                                  layoutSuperview, referenceSuperview).y
    }
}
