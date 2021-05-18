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

#if os(iOS) || os(tvOS)
@objc extension UIView {
    public var anchor: AnchorList {
        return AnchorListImpl(view: self)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self)
    }
}
#else
@objc extension NSView {
    public var anchor: AnchorList {
        return AnchorListImpl(view: self)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self)
    }
}
#endif

@objc class PinLayoutObjCImpl: NSObject, PinLayoutObjC {
    #if os(iOS) || os(tvOS)
    typealias PView = UIView
    #else
    typealias PView = NSView
    #endif

    private var impl: PinLayout<PView>?

    #if os(iOS) || os(tvOS)
    var safeArea: PEdgeInsets {
        return impl?.safeArea ?? .zero
    }
    #endif

    init(view: PView, keepTransform: Bool) {
        impl = PinLayout<PView>(view: view, keepTransform: keepTransform)
    }
    
    deinit {
        if impl != nil {
            impl?.warn("With the Objective-C interface, you must call the \"layout\" method to ensure the view is layouted correctly (ex: [[[textLabel.pin_objc top] left] layout];")
        }
    }

    var layout: POVoid {
        return { [weak self] in
            _ = self?.impl?.layout()
            self?.impl = nil
            return self
        }
    }
    
    var top: POVoid {
        return { [weak self] in
            _ = self?.impl?.top()
            return self
        }
    }
    
    var topValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.top(value)
            return self
        }
    }
    
    var topPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.top(percent%)
            return self
        }
    }
    
    var topInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.top(insets)
            return self
        }
    }
    
    var left: POVoid {
        return { [weak self] in
            _ = self?.impl?.left()
            return self
        }
    }
    
    var leftValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.left(value)
            return self
        }
    }
    
    var leftPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.left(percent%)
            return self
        }
    }
    
    var leftInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.left(insets)
            return self
        }
    }
    
    var bottom: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottom()
            return self
        }
    }
    
    var bottomValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.bottom(value)
            return self
        }
    }
    
    var bottomPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.bottom(percent%)
            return self
        }
    }
    
    var bottomInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.bottom(insets)
            return self
        }
    }
    
    var right: POVoid {
        return { [weak self] in
            _ = self?.impl?.right()
            return self
        }
    }
    
    var rightValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.right(value)
            return self
        }
    }
    
    var rightPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.right(percent%)
            return self
        }
    }
    
    var rightInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.right(insets)
            return self
        }
    }
    
    var hCenter: POVoid {
        return { [weak self] in
            _ = self?.impl?.hCenter()
            return self
        }
    }
    
    var hCenterValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.hCenter(value)
            return self
        }
    }
    
    var hCenterPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.hCenter(percent%)
            return self
        }
    }
    
    var vCenter: POVoid {
        return { [weak self] in
            _ = self?.impl?.vCenter()
            return self
        }
    }
    
    var vCenterValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.vCenter(value)
            return self
        }
    }
    
    var vCenterPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.vCenter(percent%)
            return self
        }
    }
    
    var start: POVoid {
        return { [weak self] in
            _ = self?.impl?.start()
            return self
        }
    }
    
    var startValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.start(value)
            return self
        }
    }
    
    var startPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.start(percent%)
            return self
        }
    }
    
    var startInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.start(insets)
            return self
        }
    }
    
    var end: POVoid {
        return { [weak self] in
            _ = self?.impl?.end()
            return self
        }
    }
    
    var endValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.end(value)
            return self
        }
    }
    
    var endPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.end(percent%)
            return self
        }
    }
    
    var endInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.end(insets)
            return self
        }
    }
    
    var all: POVoid {
        return { [weak self] in
            _ = self?.impl?.all()
            return self
        }
    }
    
    var horizontally: POVoid {
        return { [weak self] in
            _ = self?.impl?.horizontally()
            return self
        }
    }
    
    var vertically: POVoid {
        return { [weak self] in
            _ = self?.impl?.vertically()
            return self
        }
    }
    
    var topToEdge: POVEdge {
        return { [weak self] edge in
            _ = self?.impl?.top(to: edge)
            return self
        }
    }
    
    var vCenterToEdge: POVEdge {
        return { [weak self] edge in
            _ = self?.impl?.vCenter(to: edge)
            return self
        }
    }
    
    var bottomToEdge: POVEdge {
        return { [weak self] edge in
            _ = self?.impl?.bottom(to: edge)
            return self
        }
    }
    
    var leftToEdge: POHEdge {
        return { [weak self] edge in
            _ = self?.impl?.left(to: edge)
            return self
        }
    }
    
    var hCenterToEdge: POHEdge {
        return { [weak self] edge in
            _ = self?.impl?.hCenter(to: edge)
            return self
        }
    }
    
    var rightToEdge: POHEdge {
        return { [weak self] edge in
            _ = self?.impl?.right(to: edge)
            return self
        }
    }
    
    var startToEdge: POHEdge {
        return { [weak self] edge in
            _ = self?.impl?.start(to: edge)
            return self
        }
    }
    
    var endToEdge: POHEdge {
        return { [weak self] edge in
            _ = self?.impl?.end(to: edge)
            return self
        }
    }
    
    var topLeftToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.topLeft(to: anchor)
            return self
        }
    }
    
    var topLeft: POVoid {
        return { [weak self] in
            _ = self?.impl?.topLeft()
            return self
        }
    }
    
    var topStartToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.topStart(to: anchor)
            return self
        }
    }
    
    var topStart: POVoid {
        return { [weak self] in
            _ = self?.impl?.topStart()
            return self
        }
    }
    
    var topCenterToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.topCenter(to: anchor)
            return self
        }
    }
    
    var topCenter: POVoid {
        return { [weak self] in
            _ = self?.impl?.topCenter()
            return self
        }
    }
    
    var topRightToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.topRight(to: anchor)
            return self
        }
    }
    
    var topRight: POVoid {
        return { [weak self] in
            _ = self?.impl?.topRight()
            return self
        }
    }
    
    var topEndToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.topEnd(to: anchor)
            return self
        }
    }
    
    var topEnd: POVoid {
        return { [weak self] in
            _ = self?.impl?.topEnd()
            return self
        }
    }
    
    var centerLeftToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.centerLeft(to: anchor)
            return self
        }
    }
    
    var centerLeft: POVoid {
        return { [weak self] in
            _ = self?.impl?.centerLeft()
            return self
        }
    }
    
    var centerStartToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.centerStart(to: anchor)
            return self
        }
    }
    
    var centerStart: POVoid {
        return { [weak self] in
            _ = self?.impl?.centerStart()
            return self
        }
    }
    
    var centerToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.center(to: anchor)
            return self
        }
    }
    
    var center: POVoid {
        return { [weak self] in
            _ = self?.impl?.center()
            return self
        }
    }
    
    var centerRightToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.centerRight(to: anchor)
            return self
        }
    }
    
    var centerRight: POVoid {
        return { [weak self] in
            _ = self?.impl?.centerRight()
            return self
        }
    }
    
    var centerEndToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.centerEnd(to: anchor)
            return self
        }
    }
    
    var centerEnd: POVoid {
        return { [weak self] in
            _ = self?.impl?.centerEnd()
            return self
        }
    }
    
    var bottomLeftToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.bottomLeft(to: anchor)
            return self
        }
    }
    
    var bottomLeft: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottomLeft()
            return self
        }
    }
    
    var bottomStartToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.bottomStart(to: anchor)
            return self
        }
    }
    
    var bottomStart: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottomStart()
            return self
        }
    }
    
    var bottomCenterToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.bottomCenter(to: anchor)
            return self
        }
    }
    
    var bottomCenter: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottomCenter()
            return self
        }
    }
    
    var bottomRightToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.bottomRight(to: anchor)
            return self
        }
    }
    
    var bottomRight: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottomRight()
            return self
        }
    }
    
    var bottomEndToAnchor: POAnchor {
        return { [weak self] anchor in
            _ = self?.impl?.bottomEnd(to: anchor)
            return self
        }
    }
    
    var bottomEnd: POVoid {
        return { [weak self] in
            _ = self?.impl?.bottomEnd()
            return self
        }
    }
    
    var aboveOf: POView {
        return { [weak self] view in
            _ = self?.impl?.above(of: view)
            return self
        }
    }
    
    var aboveOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.above(of: views)
            return self
        }
    }
    
    var aboveOfAligned: POViewHAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.above(of: view, aligned: aligned)
            return self
        }
    }
    
    var aboveOfViewsAligned: POViewsHAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.above(of: views, aligned: aligned)
            return self
        }
    }
    
    var belowOf: POView {
        return { [weak self] view in
            _ = self?.impl?.below(of: view)
            return self
        }
    }
    
    var belowOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.below(of: views)
            return self
        }
    }
    
    var belowOfAligned: POViewHAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.below(of: view, aligned: aligned)
            return self
        }
    }
    
    var belowOfViewsAligned: POViewsHAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.below(of: views, aligned: aligned)
            return self
        }
    }
    
    var leftOf: POView {
        return { [weak self] view in
            _ = self?.impl?.left(of: view)
            return self
        }
    }
    
    var leftOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.left(of: views)
            return self
        }
    }
    
    var leftOfAligned: POViewVAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.left(of: view, aligned: aligned)
            return self
        }
    }
    
    var leftOfViewsAligned: POViewsVAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.left(of: views, aligned: aligned)
            return self
        }
    }
    
    var rightOf: POView {
        return { [weak self] view in
            _ = self?.impl?.right(of: view)
            return self
        }
    }
    
    var rightOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.right(of: views)
            return self
        }
    }
    
    var rightOfAligned: POViewVAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.right(of: view, aligned: aligned)
            return self
        }
    }
    
    var rightOfViewsAligned: POViewsVAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.right(of: views, aligned: aligned)
            return self
        }
    }
    
    var beforeOf: POView {
        return { [weak self] view in
            _ = self?.impl?.before(of: view)
            return self
        }
    }
    
    var beforeOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.before(of: views)
            return self
        }
    }
    
    var beforeOfAligned: POViewVAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.before(of: view, aligned: aligned)
            return self
        }
    }
    
    var beforeOfViewsAligned: POViewsVAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.before(of: views, aligned: aligned)
            return self
        }
    }
    
    var afterOf: POView {
        return { [weak self] view in
            _ = self?.impl?.after(of: view)
            return self
        }
    }
    
    var afterOfViews: POViews {
        return { [weak self] views in
            _ = self?.impl?.after(of: views)
            return self
        }
    }
    
    var afterOfAligned: POViewVAligned {
        return { [weak self] view, aligned in
            _ = self?.impl?.after(of: view, aligned: aligned)
            return self
        }
    }
    
    var afterOfViewsAligned: POViewsVAligned {
        return { [weak self] views, aligned in
            _ = self?.impl?.after(of: views, aligned: aligned)
            return self
        }
    }
    
    var justify: POHAlign {
        return { [weak self] align in
            _ = self?.impl?.justify(align)
            return self
        }
    }
    
    var align: POVAlign {
        return { [weak self] align in
            _ = self?.impl?.align(align)
            return self
        }
    }
    
    var width: POValue {
        return { [weak self] value in
            _ = self?.impl?.width(value)
            return self
        }
    }
    
    var widthPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.width(percent%)
            return self
        }
    }
    
    var widthOf: POView {
        return { [weak self] view in
            _ = self?.impl?.width(of: view)
            return self
        }
    }
    
    var minWidth: POValue {
        return { [weak self] value in
            _ = self?.impl?.minWidth(value)
            return self
        }
    }
    
    var minWidthPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.minWidth(percent%)
            return self
        }
    }
    
    var maxWidth: POValue {
        return { [weak self] value in
            _ = self?.impl?.maxWidth(value)
            return self
        }
    }
    
    var maxWidthPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.maxWidth(percent%)
            return self
        }
    }
    
    var height: POValue {
        return { [weak self] value in
            _ = self?.impl?.height(value)
            return self
        }
    }
    
    var heightPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.height(percent%)
            return self
        }
    }
    
    var heightOf: POView {
        return { [weak self] view in
            _ = self?.impl?.height(of: view)
            return self
        }
    }
    
    var minHeight: POValue {
        return { [weak self] value in
            _ = self?.impl?.minHeight(value)
            return self
        }
    }
    
    var minHeightPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.minHeight(percent%)
            return self
        }
    }
    
    var maxHeight: POValue {
        return { [weak self] value in
            _ = self?.impl?.maxHeight(value)
            return self
        }
    }
    
    var maxHeightPercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.maxHeight(percent%)
            return self
        }
    }
    
    var size: POSize {
        return { [weak self] size in
            _ = self?.impl?.size(size)
            return self
        }
    }
    
    var sizeLength: POValue {
        return { [weak self] value in
            _ = self?.impl?.size(value)
            return self
        }
    }
    
    var sizePercent: POValue {
        return { [weak self] percent in
            _ = self?.impl?.size(percent%)
            return self
        }
    }
    
    var sizeOf: POView {
        return { [weak self] view in
            _ = self?.impl?.size(of: view)
            return self
        }
    }
    
    var wrapContent: POVoid {
        return { [weak self] in
            _ = self?.impl?.wrapContent()
            return self
        }
    }
    
    var wrapContentPadding: POValue {
        return { [weak self] value in
            _ = self?.impl?.wrapContent(padding: value)
            return self
        }
    }
    
    var wrapContentInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.wrapContent(padding: insets)
            return self
        }
    }
    
    var wrapContentType: POWrapType {
        return { [weak self] type in
            _ = self?.impl?.wrapContent(type)
            return self
        }
    }
    
    var wrapContentTypePadding: POWrapTypePadding {
        return { [weak self] type, value in
            _ = self?.impl?.wrapContent(type, padding: value)
            return self
        }
    }
    
    var wrapContentTypeInsets: POWrapTypeInsets {
        return { [weak self] type, insets in
            _ = self?.impl?.wrapContent(type, padding: insets)
            return self
        }
    }
    
    var aspectRatioValue: POValue {
        return { [weak self] value in
            _ = self?.impl?.aspectRatio(value)
            return self
        }
    }
    
    var aspectRatioOf: POView {
        return { [weak self] view in
            _ = self?.impl?.aspectRatio(of: view)
            return self
        }
    }
    
    #if os(iOS) || os(tvOS)
    var aspectRatio: POVoid {
        return { [weak self] in
            _ = self?.impl?.aspectRatio()
            return self
        }
    }
    #endif
    
    var sizeToFit: POVoid {
        return { [weak self] in
            _ = self?.impl?.sizeToFit()
            return self
        }
    }
    
    var sizeToFitType: POFitType {
        return { [weak self] fitType in
            let type: FitType
            switch fitType {
            case .width: type = .width
            case .height: type = .height
            case .widthFlexible: type = .widthFlexible
            case .heightFlexible: type = .heightFlexible
            case .content: type = .content
            }
            _ = self?.impl?.sizeToFit(type)
            return self
        }
    }
    
    var marginTop: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginTop(value)
            return self
        }
    }
    
    var marginLeft: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginLeft(value)
            return self
        }
    }
    
    var marginBottom: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginBottom(value)
            return self
        }
    }
    
    var marginRight: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginRight(value)
            return self
        }
    }
    
    var marginStart: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginStart(value)
            return self
        }
    }
    
    var marginEnd: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginEnd(value)
            return self
        }
    }
    
    var marginHorizontal: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginHorizontal(value)
            return self
        }
    }
    
    var marginVertical: POValue {
        return { [weak self] value in
            _ = self?.impl?.marginVertical(value)
            return self
        }
    }
    
    var marginInsets: POEdgeInsets {
        return { [weak self] insets in
            _ = self?.impl?.margin(insets)
            return self
        }
    }
    
    var margin: POValue {
        return { [weak self] value in
            _ = self?.impl?.margin(value)
            return self
        }
    }
    
    var marginVH: (CGFloat, CGFloat) -> PinLayoutObjC? {
        return { [weak self] vertical, horizontal in
            _ = self?.impl?.margin(vertical, horizontal)
            return self
        }
    }
    
    var marginTHB: (CGFloat, CGFloat, CGFloat) -> PinLayoutObjC? {
        return { [weak self] top, horizontal, bottom in
            _ = self?.impl?.margin(top, horizontal, bottom)
            return self
        }
    }
    
    var marginTLBR: (CGFloat, CGFloat, CGFloat, CGFloat) -> PinLayoutObjC? {
        return { [weak self] top, left, bottom, right in
            _ = self?.impl?.margin(top, left, bottom, right)
            return self
        }
    }
    
    var pinEdges: POVoid {
        return { [weak self] in
            _ = self?.impl?.pinEdges()
            return self
        }
    }
}
