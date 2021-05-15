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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

/**
 We must have a different interface for objective-c. The PinLayout's Swift interface use some
 feature not available to objective-c, including overloading.
 */
@objc public protocol PinLayoutObjC {
    #if os(iOS) || os(tvOS)
    var safeArea: PEdgeInsets { get }
    #endif
    
    typealias POVoid = () -> PinLayoutObjC?
    typealias POValue = (_ value: CGFloat) -> PinLayoutObjC?
    typealias POEdgeInsets = (_ insets: PEdgeInsets) -> PinLayoutObjC?
    typealias POVEdge = (_ edge: VerticalEdge) -> PinLayoutObjC?
    typealias POHEdge = (_ edge: HorizontalEdge) -> PinLayoutObjC?
    typealias POAnchor = (_ anchor: Anchor) -> PinLayoutObjC?
    typealias POSize = (_ size: CGSize) -> PinLayoutObjC?
    typealias POHAlign = (_ hAlign: HorizontalAlign) -> PinLayoutObjC?
    typealias POVAlign = (_ hAlign: VerticalAlign) -> PinLayoutObjC?
    typealias POWrapType = (_ type: WrapType) -> PinLayoutObjC?
    typealias POWrapTypePadding = (_ type: WrapType, _ padding: CGFloat) -> PinLayoutObjC?
    typealias POWrapTypeInsets = (_ type: WrapType, _ insets: PEdgeInsets) -> PinLayoutObjC?
    typealias POFitType = (_ type: Fit) -> PinLayoutObjC?

    /**
     With the Objective-C interface, you must call the \"layout\" method to ensure the view is layouted correctly.
     Ex:
         textLabel.pinObjc.top().left().layout()
     */
    var layout: POVoid { get }

    var top: POVoid { get }
    var topValue: POValue { get }
    var topPercent: POValue { get }
    var topInsets: POEdgeInsets { get }

    var left: POVoid { get }
    var leftValue: POValue { get }
    var leftPercent: POValue { get }
    var leftInsets: POEdgeInsets { get }

    var bottom: POVoid { get }
    var bottomValue: POValue { get }
    var bottomPercent: POValue { get }
    var bottomInsets: POEdgeInsets { get }

    var right: POVoid { get }
    var rightValue: POValue { get }
    var rightPercent: POValue { get }
    var rightInsets: POEdgeInsets { get }

    var hCenter: POVoid { get }
    var hCenterValue: POValue { get }
    var hCenterPercent: POValue { get }

    var vCenter: POVoid { get }
    var vCenterValue: POValue { get }
    var vCenterPercent: POValue { get }

    // RTL support
    var start: POVoid { get }
    var startValue: POValue { get }
    var startPercent: POValue { get }
    var startInsets: POEdgeInsets { get }

    var end: POVoid { get }
    var endValue: POValue { get }
    var endPercent: POValue { get }
    var endInsets: POEdgeInsets { get }

    // Pin multiple edges at once.
    var all: POVoid { get }
    var horizontally: POVoid { get }
    var vertically: POVoid { get }

    //
    // MARK: Layout using edges
    //
    var topToEdge: POVEdge { get }
    var vCenterToEdge: POVEdge { get }
    var bottomToEdge: POVEdge { get }
    var leftToEdge: POHEdge { get }
    var hCenterToEdge: POHEdge { get }
    var rightToEdge: POHEdge { get }

    // RTL support
    var startToEdge: POHEdge { get }
    var endToEdge: POHEdge { get }

    //
    // MARK: Layout using anchors
    //
    var topLeftToAnchor: POAnchor { get }
    var topLeft: POVoid { get }
    var topStartToAnchor: POAnchor { get }
    var topStart: POVoid { get }

    var topCenterToAnchor: POAnchor { get }
    var topCenter: POVoid { get }

    var topRightToAnchor: POAnchor { get }
    var topRight: POVoid { get }
    var topEndToAnchor: POAnchor { get }
    var topEnd: POVoid { get }

    var centerLeftToAnchor: POAnchor { get }
    var centerLeft: POVoid { get }
    var centerStartToAnchor: POAnchor { get }
    var centerStart: POVoid { get }

    var centerToAnchor: POAnchor { get }
    var center: POVoid { get }

    var centerRightToAnchor: POAnchor { get }
    var centerRight: POVoid { get }
    var centerEndToAnchor: POAnchor { get }
    var centerEnd: POVoid { get }

    var bottomLeftToAnchor: POAnchor { get }
    var bottomLeft: POVoid { get }
    var bottomStartToAnchor: POAnchor { get }
    var bottomStart: POVoid { get }

    var bottomCenterToAnchor: POAnchor { get }
    var bottomCenter: POVoid { get }

    var bottomRightToAnchor: POAnchor { get }
    var bottomRight: POVoid { get }
    var bottomEndToAnchor: POAnchor { get }
    var bottomEnd: POVoid { get }

    //
    // MARK: Layout using relative positioning
    //
    #if os(iOS) || os(tvOS)
        typealias POView = (_ view: UIView) -> PinLayoutObjC?
        typealias POViews = (_ views: [UIView]) -> PinLayoutObjC?
        typealias POViewHAligned = (_ view: UIView, _ aligned: HorizontalAlign) -> PinLayoutObjC?
        typealias POViewsHAligned = (_ views: [UIView], _ aligned: HorizontalAlign) -> PinLayoutObjC?
        typealias POViewVAligned = (_ view: UIView, _ aligned: VerticalAlign) -> PinLayoutObjC?
        typealias POViewsVAligned = (_ views: [UIView], _ aligned: VerticalAlign) -> PinLayoutObjC?
    #elseif os(macOS)
        typealias POView = (_ view: NSView) -> PinLayoutObjC?
        typealias POViews = (_ views: [NSView]) -> PinLayoutObjC?
        typealias POViewHAligned = (_ view: NSView, _ aligned: HorizontalAlign) -> PinLayoutObjC?
        typealias POViewsHAligned = (_ views: [NSView], _ aligned: HorizontalAlign) -> PinLayoutObjC?
        typealias POViewVAligned = (_ view: NSView, _ aligned: VerticalAlign) -> PinLayoutObjC?
        typealias POViewsVAligned = (_ views: [NSView], _ aligned: VerticalAlign) -> PinLayoutObjC?
    #endif
    
    var aboveOf: POView { get }
    var aboveOfViews: POViews { get }
    var aboveOfAligned: POViewHAligned { get }
    var aboveOfViewsAligned: POViewsHAligned { get }

    var belowOf: POView { get }
    var belowOfViews: POViews { get }
    var belowOfAligned: POViewHAligned { get }
    var belowOfViewsAligned: POViewsHAligned { get }
    var leftOf: POView { get }
    var leftOfViews: POViews { get }
    var leftOfAligned: POViewVAligned { get }
    var leftOfViewsAligned: POViewsVAligned { get }

    var rightOf: POView { get }
    var rightOfViews: POViews { get }
    var rightOfAligned: POViewVAligned { get }
    var rightOfViewsAligned: POViewsVAligned { get }

    // RTL support
    var beforeOf: POView { get }
    var beforeOfViews: POViews { get }
    var beforeOfAligned: POViewVAligned { get }
    var beforeOfViewsAligned: POViewsVAligned { get }
    var afterOf: POView { get }
    var afterOfViews: POViews { get }
    var afterOfAligned: POViewVAligned { get }
    var afterOfViewsAligned: POViewsVAligned { get }

    //
    // MARK: justify / align
    //
    var justify: POHAlign { get }
    var align: POVAlign { get }

    //
    // MARK: Width, height and size
    //
    var width: POValue { get }
    var widthPercent: POValue { get }
    var widthOf: POView { get }

    var minWidth: POValue { get }
    var minWidthPercent: POValue { get }
    var maxWidth: POValue { get }
    var maxWidthPercent: POValue { get }

    var height: POValue { get }
    var heightPercent: POValue { get }
    var heightOf: POView { get }

    var minHeight: POValue { get }
    var minHeightPercent: POValue { get }
    var maxHeight: POValue { get }
    var maxHeightPercent: POValue { get }

    var size: POSize { get }
    var sizeLength: POValue { get }
    var sizePercent: POValue { get }
    var sizeOf: POView{ get }

    //
    // MARK: wrapContent
    var wrapContent: POVoid { get }
    var wrapContentPadding: POValue { get }
    var wrapContentInsets: POEdgeInsets { get }
    var wrapContentType: POWrapType { get }
    var wrapContentTypePadding: POWrapTypePadding { get }
    var wrapContentTypeInsets: POWrapTypeInsets { get }

    /**
     Set the view aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * An aspect ratio of 2 means the width is twice the size of the height.
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    var aspectRatioValue: POValue { get }
    /**
     Set the view aspect ratio using another UIView's aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    var aspectRatioOf: POView { get }

    /**
     If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.

     For other types of views, this method as no impact.
     */
    #if os(iOS) || os(tvOS)
        var aspectRatio: POVoid { get }
    #endif

    var sizeToFit: POVoid { get }
    
    var sizeToFitType: POFitType { get }

    //
    // MARK: Margins
    //

    /**
     Set the top margin.
     */
    var marginTop: POValue { get }

    /**
     Set the left margin.
     */
    var marginLeft: POValue { get }

    /**
     Set the bottom margin.
     */
    var marginBottom: POValue { get }

    /**
     Set the right margin.
     */
    var marginRight: POValue { get }

    // RTL support
    /**
     Set the start margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, start margin specify the **left** margin.
     * In RTL direction, start margin specify the **right** margin.
     */
    var marginStart: POValue { get }

    /**
     Set the end margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, end margin specify the **right** margin.
     * In RTL direction, end margin specify the **left** margin.
     */
    var marginEnd: POValue { get }

    /**
     Set the left, right, start and end margins to the specified value.
     */
    var marginHorizontal: POValue { get }

    /**
     Set the top and bottom margins to the specified value.
     */
    var marginVertical: POValue { get }

    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    var marginInsets: POEdgeInsets { get }

    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.

     Available only on iOS 11 and higher.
     */
    // @available(iOS 11.0, *)
    // @discardableResult func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayoutObjC

    /**
     Set all margins to the specified value.
     */
    var margin: POValue { get }

    /**
     Set individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    var marginVH: (_ vertical: CGFloat, _ horizontal: CGFloat) -> PinLayoutObjC? { get }

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    var marginTHB: (_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayoutObjC? { get }

    /**
     Set individually top, left, bottom and right margins.
     */
    var marginTLBR: (_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> PinLayoutObjC? { get }

    /// Normally if only either left or right has been specified, PinLayout will MOVE the view to apply left or right margins.
    /// This is also true even if the width has been set.
    /// Calling pinEdges() will force PinLayout to pin the four edges and then apply left and/or right margins, and this without
    /// moving the view.
    ///
    /// - Returns: PinLayout
    var pinEdges: POVoid { get }
}

@objc public enum Fit: Int {
    case width
    case height
    case widthFlexible
    case heightFlexible
    case content
}
