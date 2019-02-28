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

    /**
     With the Objective-C interface, you must call the \"layout\" method to ensure the view is layouted correctly.
     Ex:
         [[[textLabel.pin_objc top] left] layout];"
         [[[textLabel.pin_objc top] left] layout];"
     */
    func layout()

    @discardableResult func top() -> PinLayoutObjC
    @discardableResult func top(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func top(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func top(insets: PEdgeInsets) -> PinLayoutObjC
    
    @discardableResult func left() -> PinLayoutObjC
    @discardableResult func left(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func left(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func left(insets: PEdgeInsets) -> PinLayoutObjC

    @discardableResult func bottom() -> PinLayoutObjC
    @discardableResult func bottom(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func bottom(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func bottom(insets: PEdgeInsets) -> PinLayoutObjC

    @discardableResult func right() -> PinLayoutObjC
    @discardableResult func right(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func right(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func right(insets: PEdgeInsets) -> PinLayoutObjC

    @discardableResult func hCenter() -> PinLayoutObjC
    @discardableResult func hCenter(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func hCenter(percent: CGFloat) -> PinLayoutObjC
    
    @discardableResult func vCenter() -> PinLayoutObjC
    @discardableResult func vCenter(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func vCenter(percent: CGFloat) -> PinLayoutObjC
    
    // RTL support
    @discardableResult func start() -> PinLayoutObjC
    @discardableResult func start(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func start(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func start(insets: PEdgeInsets) -> PinLayoutObjC

    @discardableResult func end() -> PinLayoutObjC
    @discardableResult func end(_ value: CGFloat) -> PinLayoutObjC
    @discardableResult func end(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func end(insets: PEdgeInsets) -> PinLayoutObjC
    
    // Pin multiple edges at once.
    @discardableResult func all() -> PinLayoutObjC
    @discardableResult func horizontally() -> PinLayoutObjC
    @discardableResult func vertically() -> PinLayoutObjC
    
    //
    // MARK: Layout using edges
    //
    @discardableResult func top(to edge: VerticalEdge) -> PinLayoutObjC
    @discardableResult func vCenter(to edge: VerticalEdge) -> PinLayoutObjC
    @discardableResult func bottom(to edge: VerticalEdge) -> PinLayoutObjC
    @discardableResult func left(to edge: HorizontalEdge) -> PinLayoutObjC
    @discardableResult func hCenter(to edge: HorizontalEdge) -> PinLayoutObjC
    @discardableResult func right(to edge: HorizontalEdge) -> PinLayoutObjC
    // RTL support
    @discardableResult func start(to edge: HorizontalEdge) -> PinLayoutObjC
    @discardableResult func end(to edge: HorizontalEdge) -> PinLayoutObjC
    
    //
    // MARK: Layout using anchors
    //
    @discardableResult func topLeft(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func topLeft() -> PinLayoutObjC
    @discardableResult func topStart(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func topStart() -> PinLayoutObjC
    
    @discardableResult func topCenter(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func topCenter() -> PinLayoutObjC
    
    @discardableResult func topRight(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func topRight() -> PinLayoutObjC
    @discardableResult func topEnd(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func topEnd() -> PinLayoutObjC
    
    @discardableResult func centerLeft(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func centerLeft() -> PinLayoutObjC
    @discardableResult func centerStart(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func centerStart() -> PinLayoutObjC
    
    @discardableResult func center(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func center() -> PinLayoutObjC
    
    @discardableResult func centerRight(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func centerRight() -> PinLayoutObjC
    @discardableResult func centerEnd(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func centerEnd() -> PinLayoutObjC
    
    @discardableResult func bottomLeft(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func bottomLeft() -> PinLayoutObjC
    @discardableResult func bottomStart(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func bottomStart() -> PinLayoutObjC
    
    @discardableResult func bottomCenter(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func bottomCenter() -> PinLayoutObjC
    
    @discardableResult func bottomRight(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func bottomRight() -> PinLayoutObjC
    @discardableResult func bottomEnd(to anchor: Anchor) -> PinLayoutObjC
    @discardableResult func bottomEnd() -> PinLayoutObjC
    
    //
    // MARK: Layout using relative positioning
    //
    #if os(iOS) || os(tvOS)
        @discardableResult func above(of: UIView) -> PinLayoutObjC
        @discardableResult func above(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func above(of: UIView, aligned: HorizontalAlign) -> PinLayoutObjC
        @discardableResult func above(ofViews: [UIView], aligned: HorizontalAlign) -> PinLayoutObjC

        @discardableResult func below(of: UIView) -> PinLayoutObjC
        @discardableResult func below(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func below(of: UIView, aligned: HorizontalAlign) -> PinLayoutObjC
        @discardableResult func below(ofViews: [UIView], aligned: HorizontalAlign) -> PinLayoutObjC

        @discardableResult func left(of: UIView) -> PinLayoutObjC
        @discardableResult func left(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func left(of: UIView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func left(ofViews: [UIView], aligned: VerticalAlign) -> PinLayoutObjC

        @discardableResult func right(of: UIView) -> PinLayoutObjC
        @discardableResult func right(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func right(of: UIView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func right(ofViews: [UIView], aligned: VerticalAlign) -> PinLayoutObjC

        // RTL support
        @discardableResult func before(of: UIView) -> PinLayoutObjC
        @discardableResult func before(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func before(of: UIView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func before(ofViews: [UIView], aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func after(of: UIView) -> PinLayoutObjC
        @discardableResult func after(ofViews: [UIView]) -> PinLayoutObjC
        @discardableResult func after(of: UIView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func after(ofViews: [UIView], aligned: VerticalAlign) -> PinLayoutObjC
    #elseif os(macOS)
        @discardableResult func above(of: NSView) -> PinLayoutObjC
        @discardableResult func above(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func above(of: NSView, aligned: HorizontalAlign) -> PinLayoutObjC
        @discardableResult func above(ofViews: [NSView], aligned: HorizontalAlign) -> PinLayoutObjC

        @discardableResult func below(of: NSView) -> PinLayoutObjC
        @discardableResult func below(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func below(of: NSView, aligned: HorizontalAlign) -> PinLayoutObjC
        @discardableResult func below(ofViews: [NSView], aligned: HorizontalAlign) -> PinLayoutObjC

        @discardableResult func left(of: NSView) -> PinLayoutObjC
        @discardableResult func left(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func left(of: NSView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func left(ofViews: [NSView], aligned: VerticalAlign) -> PinLayoutObjC

        @discardableResult func right(of: NSView) -> PinLayoutObjC
        @discardableResult func right(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func right(of: NSView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func right(ofViews: [NSView], aligned: VerticalAlign) -> PinLayoutObjC

        // RTL support
        @discardableResult func before(of: NSView) -> PinLayoutObjC
        @discardableResult func before(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func before(of: NSView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func before(ofViews: [NSView], aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func after(of: NSView) -> PinLayoutObjC
        @discardableResult func after(ofViews: [NSView]) -> PinLayoutObjC
        @discardableResult func after(of: NSView, aligned: VerticalAlign) -> PinLayoutObjC
        @discardableResult func after(ofViews: [NSView], aligned: VerticalAlign) -> PinLayoutObjC
    #endif

    //
    // MARK: justify / align
    //
    @discardableResult func justify(_: HorizontalAlign) -> PinLayoutObjC
    @discardableResult func align(_: VerticalAlign) -> PinLayoutObjC

    //
    // MARK: Width, height and size
    //
    @discardableResult func width(_ width: CGFloat) -> PinLayoutObjC
    @discardableResult func width(percent: CGFloat) -> PinLayoutObjC
    #if os(iOS) || os(tvOS)
    @discardableResult func width(of view: UIView) -> PinLayoutObjC
    #elseif os(macOS)
    @discardableResult func width(of view: NSView) -> PinLayoutObjC
    #endif

    @discardableResult func minWidth(_ width: CGFloat) -> PinLayoutObjC
    @discardableResult func minWidth(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func maxWidth(_ width: CGFloat) -> PinLayoutObjC
    @discardableResult func maxWidth(percent: CGFloat) -> PinLayoutObjC

    @discardableResult func height(_ height: CGFloat) -> PinLayoutObjC
    @discardableResult func height(percent: CGFloat) -> PinLayoutObjC
    #if os(iOS) || os(tvOS)
    @discardableResult func height(of view: UIView) -> PinLayoutObjC
    #elseif os(macOS)
    @discardableResult func height(of view: NSView) -> PinLayoutObjC
    #endif

    @discardableResult func minHeight(_ height: CGFloat) -> PinLayoutObjC
    @discardableResult func minHeight(percent: CGFloat) -> PinLayoutObjC
    @discardableResult func maxHeight(_ height: CGFloat) -> PinLayoutObjC
    @discardableResult func maxHeight(percent: CGFloat) -> PinLayoutObjC

    @discardableResult func size(_ size: CGSize) -> PinLayoutObjC
    @discardableResult func size(length: CGFloat) -> PinLayoutObjC
    @discardableResult func size(percent: CGFloat) -> PinLayoutObjC
    #if os(iOS) || os(tvOS)
    @discardableResult func size(of view: UIView) -> PinLayoutObjC
    #elseif os(macOS)
    @discardableResult func size(of view: NSView) -> PinLayoutObjC
    #endif
    
    
    //
    // MARK: wrapContent
    @discardableResult func wrapContent() -> PinLayoutObjC;
    @discardableResult func wrapContent(padding: CGFloat) -> PinLayoutObjC;
    @discardableResult func wrapContent(insets: PEdgeInsets) -> PinLayoutObjC;
    @discardableResult func wrapContent(type: WrapType) -> PinLayoutObjC;
    @discardableResult func wrapContent(type: WrapType, padding: CGFloat) -> PinLayoutObjC;
    @discardableResult func wrapContent(type: WrapType, insets: PEdgeInsets) -> PinLayoutObjC;


    /**
     Set the view aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * An aspect ratio of 2 means the width is twice the size of the height.
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    @discardableResult func aspectRatio(_ ratio: CGFloat) -> PinLayoutObjC
    /**
     Set the view aspect ratio using another UIView's aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    #if os(iOS) || os(tvOS)
    @discardableResult func aspectRatio(of view: UIView) -> PinLayoutObjC
    #elseif os(macOS)
    @discardableResult func aspectRatio(of view: NSView) -> PinLayoutObjC
    #endif

    /**
     If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.

     For other types of views, this method as no impact.
     */
    #if os(iOS) || os(tvOS)
    @discardableResult func aspectRatio() -> PinLayoutObjC
    #endif

    @discardableResult func sizeToFit() -> PinLayoutObjC

    @discardableResult func sizeToFit(_ fitType: Fit) -> PinLayoutObjC

    //
    // MARK: Margins
    //

    /**
     Set the top margin.
     */
    @discardableResult func marginTop(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the left margin.
     */
    @discardableResult func marginLeft(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the bottom margin.
     */
    @discardableResult func marginBottom(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the right margin.
     */
    @discardableResult func marginRight(_ value: CGFloat) -> PinLayoutObjC

    // RTL support
    /**
     Set the start margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, start margin specify the **left** margin.
     * In RTL direction, start margin specify the **right** margin.
     */
    @discardableResult func marginStart(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the end margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, end margin specify the **right** margin.
     * In RTL direction, end margin specify the **left** margin.
     */
    @discardableResult func marginEnd(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult func marginHorizontal(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult func marginVertical(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    #if os(iOS) || os(tvOS)
    @discardableResult func margin(insets: UIEdgeInsets) -> PinLayoutObjC
    #elseif os(macOS)
    @discardableResult func margin(insets: NSEdgeInsets) -> PinLayoutObjC
    #endif

    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.

     Available only on iOS 11 and higher.
     */
    //@available(iOS 11.0, *)
    //@discardableResult func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayoutObjC

    /**
     Set all margins to the specified value.
     */
    @discardableResult func margin(_ value: CGFloat) -> PinLayoutObjC

    /**
     Set individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult func margin(vertical: CGFloat, horizontal: CGFloat) -> PinLayoutObjC

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult func margin(top: CGFloat, horizontal: CGFloat, bottom: CGFloat) -> PinLayoutObjC

    /**
     Set individually top, left, bottom and right margins.
     */
    @discardableResult func margin(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> PinLayoutObjC

    /// Normally if only either left or right has been specified, PinLayout will MOVE the view to apply left or right margins.
    /// This is also true even if the width has been set.
    /// Calling pinEdges() will force PinLayout to pin the four edges and then apply left and/or right margins, and this without
    /// moving the view.
    ///
    /// - Returns: PinLayout
    @discardableResult func pinEdges() -> PinLayoutObjC
}
    
@objc public enum Fit: Int {
    case width
    case height
    case widthFlexible
    case heightFlexible
    case content
}
