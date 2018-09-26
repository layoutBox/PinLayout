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

// MARK: UIView's frame computation methods
extension PinLayout {
    /**
     The method will execute PinLayout commands immediately. This method is **required only if your
     source codes should also work in Xcode Playgrounds**. Outside of playgrounds, PinLayout executes
     this method implicitly, it is not necessary to call it.

     Examples:
     ```swift
     view.pin.top(20).width(100).layout()
     ```
     */
    public func layout() {
        apply()
    }

    func apply() {
        guard !isLayouted else { return }
        apply(onView: view)
        isLayouted = true
    }
    
    private func apply(onView view: View) {
        displayLayoutWarnings()
        
        var newRect = view.getRect(keepTransform: keepTransform)
        
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
            newRect.origin.x = right - newRect.width - _marginRight
        } else if let _hCenter = _hCenter {
            // Only hCenter is set
            newRect.origin.x = (_hCenter - (newRect.width / 2)) + _marginLeft - _marginRight
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
            newRect.origin.y = bottom - newRect.height - _marginBottom
        } else if let _vCenter = _vCenter {
            // Only vCenter is set
            newRect.origin.y = (_vCenter - (newRect.height / 2)) + _marginTop - _marginBottom
        } else if let height = newSize.height {
            // Only height is set
            newRect.size.height = height
        }
        
        if !validateComputedWidth(newRect.size.width) {
            newRect.size.width = view.getRect(keepTransform: keepTransform).width
        }
        
        if !validateComputedHeight(newRect.size.height) {
            newRect.size.height = view.getRect(keepTransform: keepTransform).height
        }
        
        /*
         To adjust the view's position and size, we don't set the UIView's frame directly, because we want to keep the
         view's transform (UIView.transform).
         By setting the view's center and bounds we really set the frame of the non-transformed view, and this keep
         the view's transform. So view's transforms won't be affected/altered by PinLayout.
        */
        view.setRect(newRect, keepTransform: keepTransform)
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
        var size = resolveSize()

        if let adjustSizeType = adjustSizeType {
            switch adjustSizeType {
            case .fitTypeWidth, .fitTypeHeight, .fitTypeWidthFlexible, .fitTypeHeightFlexible, .fitTypeContent:
                size = computeSizeToFit(adjustSizeType: adjustSizeType, size: size)
            case .aspectRatio(let ratio):
                size = computeAspectRatio(ratio, size: size)
            }
        }

        return validateAndApplyMinMax(toSize: size)
    }

    private func resolveSize() -> Size {
        var size = Size()

        // Width
        if let width = width {
            size.width = width
        } else if let left = _left, let right = _right {
            size.width = right - left - _marginLeft - _marginRight
        } else if shouldKeepViewDimension {
            // No width has been specified (and won't be computed by a sizeToFit) => use the current view's width
            size.width = view.getRect(keepTransform: keepTransform).width
        }

        // Height
        if let height = height {
            size.height = height
        } else if let top = _top, let bottom = _bottom {
            size.height = bottom - top - _marginTop - _marginBottom
        } else if shouldKeepViewDimension {
            size.height = view.getRect(keepTransform: keepTransform).height
        }

        return size
    }

    private func computeSizeToFit(adjustSizeType: AdjustSizeType, size: Size) -> Size {
        guard let sizeCalculableView = view as? SizeCalculable else {
            assertionFailure("Should not occurs, protocol conformance is checked before assigning adjustSizeType")
            return size
        }

        var fitWidth = CGFloat.greatestFiniteMagnitude
        var fitHeight = CGFloat.greatestFiniteMagnitude
        var size = size

        // Apply min/max width/height before calling sizeThatFits() ... and reapply them after.
        switch adjustSizeType {
        case .fitTypeWidth, .fitTypeWidthFlexible:
            if let width = applyMinMax(toWidth: size.width) {
                fitWidth = width
            } else {
                fitWidth = view.getRect(keepTransform: keepTransform).width
            }
        case .fitTypeHeight, .fitTypeHeightFlexible:
            if let height = applyMinMax(toHeight: size.height) {
                fitHeight = height
            } else {
                fitHeight = view.getRect(keepTransform: keepTransform).height
            }
        case .fitTypeContent:
            let fitSize = view.getRect(keepTransform: keepTransform).size
            fitWidth = fitSize.width
            fitHeight = fitSize.height
        default:
            assertionFailure("Should not occured")
        }

        let sizeThatFits = sizeCalculableView.sizeThatFits(CGSize(width: fitWidth, height: fitHeight))

        switch adjustSizeType {
        case .fitTypeWidth, .fitTypeWidthFlexible, .fitTypeHeight, .fitTypeHeightFlexible, .aspectRatio(_):
            if fitWidth != .greatestFiniteMagnitude {
                size.width = adjustSizeType.isFlexible ? sizeThatFits.width : fitWidth
            } else {
                size.width = sizeThatFits.width
            }

            if fitHeight != .greatestFiniteMagnitude {
                size.height = adjustSizeType.isFlexible ? sizeThatFits.height : fitHeight
            } else {
                size.height = sizeThatFits.height
            }
        case .fitTypeContent:
            size = Size(width: sizeThatFits.width, height: sizeThatFits.height)
        }

        return size
    }

    private func computeAspectRatio(_ aspectRatio: CGFloat, size: Size) -> Size {
        guard size.width != nil || size.height != nil else {
            warn("aspectRatio won't be applied, neither the width nor the height can be determined.")
            return size
        }
        guard size.width == nil || size.height == nil else {
            warn("aspectRatio won't be applied, the width and the height are already defined by other PinLayout's properties.")
            return size
        }

        if let width = size.width, let adjustedWidth = applyMinMax(toWidth: width) {
            return Size(width: adjustedWidth, height: adjustedWidth / aspectRatio)
        } else if let height = size.height, let adjustedHeight = applyMinMax(toHeight: height) {
            return Size(width: adjustedHeight * aspectRatio, height: adjustedHeight)
        } else {
            assertionFailure("Should not occurs, all cases should be handled by guards above")
            return size
        }
    }

    private func validateAndApplyMinMax(toSize size: Size) -> Size {
        var size = size
        size.width = applyMinMax(toWidth: size.width)
        size.height = applyMinMax(toHeight: size.height)

        if !validateComputedWidth(size.width) {
            size.width = nil
        }

        if !validateComputedHeight(size.height) {
            size.height = nil
        }

        return size
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
        
        if let justify = justify, justify != .none {
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
        case .none:
            break
        }
        
        return rect
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
        
        if let align = align, align != .none {
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
        case .none:
            break
        }
        
        return rect
    }
    
    internal func isLTR() -> Bool {
        return view.isLTR()
    }
}
