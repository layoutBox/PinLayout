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

// MARK - UIView's frame computation methods
extension PinLayoutImpl {
    public func layout() {
        apply()
    }

    func apply() {
        guard !isLayouted else { return }
        apply(onView: view)
        isLayouted = true
    }
    
    private func apply(onView view: UIView) {
        displayLayoutWarnings()
        
        var newRect = view.frame
        
        handlePinEdges()
        
        let newSize = computeSize()
        
        // Compute horizontal position
        if let left = _left, let right = _right {
            // left & right is set
            if let width = newSize.width {
                newRect.size.width = width
                newRect = applyJustify(rect: newRect, betweenLeft: left, andRight: right)
            } else {
                newRect.origin.x = left + _marginLeft
                newRect.size.width = right - _marginRight - newRect.origin.x
            }
        } else if let left = _left, let width = newSize.width {
            // left & width is set
            newRect.origin.x = left + _marginLeft
            newRect.size.width = width
        } else if let right = _right, let width = newSize.width {
            // right & width is set
            newRect.size.width = width
            newRect.origin.x = right - _marginRight - width
        } else if let _hCenter = _hCenter, let width = newSize.width {
            // hCenter & width is set
            newRect.size.width = width
            newRect.origin.x = (_hCenter - (width / 2)) + _marginLeft - _marginRight
        } else if let left = _left {
            // Only left is set
            newRect.origin.x = left + _marginLeft
        } else if let right = _right {
            // Only right is set
            newRect.origin.x = right - view.frame.width - _marginRight
        } else if let _hCenter = _hCenter {
            // Only hCenter is set
            newRect.origin.x = (_hCenter - (view.frame.width / 2)) + _marginLeft - _marginRight
        } else if let width = newSize.width {
            // Only width is set
            newRect.size.width = width
        }
        
        // Compute vertical position
        if let top = _top, let bottom = _bottom {
            // top & bottom is set
            if let height = newSize.height {
                newRect.size.height = height
                newRect = applyAlign(rect: newRect, betweenTop: top, andBottom: bottom)
            } else {
                newRect.origin.y = top + _marginTop
                newRect.size.height = bottom - _marginBottom - newRect.origin.y
            }
        } else if let top = _top, let height = newSize.height {
            // top & height is set
            newRect.origin.y = top + _marginTop
            newRect.size.height = height
        } else if let bottom = _bottom, let height = newSize.height {
            // bottom & height is set
            newRect.size.height = height
            newRect.origin.y = bottom - _marginBottom - height
        } else if let _vCenter = _vCenter, let height = newSize.height {
            // vCenter & height is set
            newRect.size.height = height
            newRect.origin.y = (_vCenter - (height / 2)) + _marginTop - _marginBottom
        } else if let top = _top {
            // Only top is set
            newRect.origin.y = top + _marginTop
        } else if let bottom = _bottom {
            // Only bottom is set
            newRect.origin.y = bottom - view.frame.height - _marginBottom
        } else if let _vCenter = _vCenter {
            // Only vCenter is set
            newRect.origin.y = (_vCenter - (view.frame.height / 2)) + _marginTop - _marginBottom
        } else if let height = newSize.height {
            // Only height is set
            newRect.size.height = height
        }
        
        if !validateComputedWidth(newRect.size.width) {
            newRect.size.width = view.frame.width
        }
        
        if !validateComputedHeight(newRect.size.height) {
            newRect.size.height = view.frame.height
        }
        
        view.frame = Coordinates.adjustRectToDisplayScale(newRect)
    }
    
    private func handlePinEdges() {
        guard shouldPinEdges else { return }
        guard _top == nil || _bottom == nil || _left == nil || _right == nil else {
            return warn("pinEdges() won't be applied, top, left, bottom and right coordinates are already set.")
        }
        
        if let width = applyMinMax(toWidth: width), _left == nil || _right == nil {
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
            } else if let _hCenter = _hCenter {
                // convert the width & hCenter into a left & right
                assert(self._left == nil && self._right == nil)
                let halfWidth = width / 2
                self._left = _hCenter - halfWidth
                self._right = _hCenter + halfWidth
                self._hCenter = nil
                self.width = nil
            }
        }
        
        if let height = applyMinMax(toHeight: height), _top == nil || _bottom == nil {
            if let top = _top {
                // convert the height into a bottom
                assert(self._bottom == nil)
                self._bottom = top + height
                self.height = nil
            } else if let bottom = _bottom {
                // convert the height into a top
                assert(self._top == nil)
                self._top = bottom - height
                self.height = nil
            } else if let _vCenter = _vCenter {
                // convert the height & vCenter into a top & bottom
                assert(self._top == nil && self._bottom == nil)
                let halfHeight = height / 2
                self._top = _vCenter - halfHeight
                self._bottom = _vCenter + halfHeight
                self._vCenter = nil
                self.height = nil
            }
        }
    }
    
    private func computeSize() -> Size {
        var width = computeWidth()
        var height = computeHeight()
        
        if legacyFitSize {
            if width == nil && height == nil {
                warn("fitSize() won't be applied, neither the width nor the height can be determined.")
            } else {
                var fitWidth = CGFloat.greatestFiniteMagnitude
                var fitHeight = CGFloat.greatestFiniteMagnitude
                
                if let width = applyMinMax(toWidth: width) {
                    fitWidth = width
                }
                if let height = applyMinMax(toHeight: height) {
                    fitHeight = height
                }
                
                let sizeThatFits = view.sizeThatFits(CGSize(width: fitWidth, height: fitHeight))
                
                if fitWidth != .greatestFiniteMagnitude && (sizeThatFits.width > fitWidth) {
                    width = fitWidth
                } else {
                    width = sizeThatFits.width
                }
                
                if fitHeight != .greatestFiniteMagnitude && (sizeThatFits.height > fitHeight) {
                    height = fitHeight
                } else {
                    height = sizeThatFits.height
                }
            }
        } else if let fitType = fitType {
            var fitWidth = CGFloat.greatestFiniteMagnitude
            var fitHeight = CGFloat.greatestFiniteMagnitude
            
            // Apply min/max width/height before calling sizeThatFits() ... and reapply them after.
            switch fitType {
            case .width, .widthFlexible:
                if let width = applyMinMax(toWidth: width) {
                    fitWidth = width
                } else {
                    fitWidth = view.frame.width
                }
            case .height, .heightFlexible:
                if let height = applyMinMax(toHeight: height) {
                    fitHeight = height
                } else {
                    fitHeight = view.frame.height
                }
            }
            
            let sizeThatFits = view.sizeThatFits(CGSize(width: fitWidth, height: fitHeight))
            
            if fitWidth != .greatestFiniteMagnitude {
                width = fitType.isFlexible ? sizeThatFits.width : fitWidth
            } else {
                width = sizeThatFits.width
            }
            
            if fitHeight != .greatestFiniteMagnitude {
                height = fitType.isFlexible ? sizeThatFits.height : fitHeight
            } else {
                height = sizeThatFits.height
            }
        } else if let aspectRatio = _aspectRatio {
            if width == nil && height == nil {
                warn("aspectRatio won't be applied, neither the width nor the height can be determined.")
            } else {
                if width != nil && height != nil {
                    // warn, both are specified
                    warn("aspectRatio won't be applied, the width and the height are already defined by other PinLayout's properties.")
                } else if let width = width, let adjWidth = applyMinMax(toWidth: width) {
                    height = adjWidth / aspectRatio
                } else if let height = height, let adjHeight = applyMinMax(toHeight: height) {
                    width = adjHeight * aspectRatio
                }
            }
        }
        
        width = applyMinMax(toWidth: width)
        height = applyMinMax(toHeight: height)
        
        if !validateComputedWidth(width) {
            width = nil
        }
        
        if !validateComputedHeight(height) {
            height = nil
        }
        
        return (width, height)
    }
    
    private func computeWidth() -> CGFloat? {
        var newWidth: CGFloat?
        
        if let width = width {
            newWidth = width
        } else if let left = _left, let right = _right {
            newWidth = right - left - _marginLeft - _marginRight
        } else if shouldKeepViewDimension {
            // No width has been specified (and won't be computed by a sizeToFit) => use the current view's width
            newWidth = view.frame.width
        }
        
        return newWidth
    }
    
    private func applyMinMax(toWidth width: CGFloat?) -> CGFloat? {
        var result = width
        
        // Handle minWidth
        if let minWidth = minWidth, minWidth > (result ?? 0) {
            result = minWidth
        }
        
        // Handle maxWidth
        if let maxWidth = maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude) {
            result = maxWidth
        }
        
        return result
    }
    
    private func applyJustify(rect: CGRect, betweenLeft left: CGFloat, andRight right: CGFloat) -> CGRect {
        let containerWidth = right - left - _marginLeft - _marginRight
        let remainingWidth = containerWidth - rect.width
        var justifyType = HorizontalAlign.left
        
        if let justify = justify {
            justifyType = justify
        }
        
        var rect = rect
        
        switch justifyType {
        case .left:
            rect.origin.x = left + _marginLeft
        case .center:
            rect.origin.x = left + _marginLeft + remainingWidth / 2
        case .right:
            rect.origin.x = right - _marginRight - rect.width
            
        case .start:
            if isLTR() {
                rect.origin.x = left + _marginLeft
            } else {
                rect.origin.x = right - _marginRight - rect.width
            }
        case .end:
            if isLTR() {
                rect.origin.x = right - _marginRight - rect.width
            } else {
                rect.origin.x = left + _marginLeft
            }
        }
        
        return rect
    }
    
    private func computeHeight() -> CGFloat? {
        var newHeight: CGFloat?
        
        if let height = height {
            newHeight = height
        } else if let top = _top, let bottom = _bottom {
            newHeight = bottom - top - _marginTop - _marginBottom
        } else if shouldKeepViewDimension {
            newHeight = view.frame.height
        }
        
        return newHeight
    }
    
    private func applyMinMax(toHeight height: CGFloat?) -> CGFloat? {
        var result = height
        
        // Handle minHeight
        if let minHeight = minHeight, minHeight > (result ?? 0) {
            result = minHeight
        }
        
        // Handle maxHeight
        if let maxHeight = maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude) {
            result = maxHeight
        }
        
        return result
    }
    
    private func applyAlign(rect: CGRect, betweenTop top: CGFloat, andBottom bottom: CGFloat) -> CGRect {
        let containerHeight = bottom - top - _marginTop - _marginBottom
        let remainingHeight = containerHeight - rect.height
        var alignType = VerticalAlign.top
        
        if let align = align {
            alignType = align
        }
        
        var rect = rect
        
        switch alignType {
        case .top:
            rect.origin.y = top + _marginTop
        case .center:
            rect.origin.y = top + _marginTop + remainingHeight / 2
        case .bottom:
            rect.origin.y = bottom - _marginBottom - rect.height
        }
        
        return rect
    }
    
    internal func isLTR() -> Bool {
        return view.isLTR()
    }
}
    
#endif
