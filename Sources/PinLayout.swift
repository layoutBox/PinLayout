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
    public typealias PEdgeInsets = UIEdgeInsets
#else
    import AppKit
    public typealias PEdgeInsets = NSEdgeInsets
#endif

public class PinLayout<View: Layoutable> {
    internal let view: View
    internal let keepTransform: Bool

    internal var _top: CGFloat?       // offset from superview's top edge
    internal var _left: CGFloat?      // offset from superview's left edge
    internal var _bottom: CGFloat?    // offset from superview's top edge
    internal var _right: CGFloat?     // offset from superview's left edge
    
    internal var _hCenter: CGFloat?
    internal var _vCenter: CGFloat?
    
    internal var width: CGFloat?
    internal var minWidth: CGFloat?
    internal var maxWidth: CGFloat?
    internal var height: CGFloat?
    internal var minHeight: CGFloat?
    internal var maxHeight: CGFloat?

    internal var adjustSizeType: AdjustSizeType?

    internal var shouldKeepViewDimension: Bool {
        return adjustSizeType == nil
    }
    
    internal var marginTop: CGFloat?
    internal var marginLeft: CGFloat?
    internal var marginBottom: CGFloat?
    internal var marginRight: CGFloat?
    internal var shouldPinEdges = false
    
    internal var justify: HorizontalAlign?
    internal var align: VerticalAlign?
    
    internal var _marginTop: CGFloat { return marginTop ?? 0 }
    internal var _marginLeft: CGFloat { return marginLeft ?? 0 }
    internal var _marginBottom: CGFloat { return marginBottom ?? 0 }
    internal var _marginRight: CGFloat { return marginRight ?? 0 }
    
    internal var isLayouted = false

    init(view: View, keepTransform: Bool) {
        self.view = view
        self.keepTransform = keepTransform

        #if os(iOS) || os(tvOS)
        Pin.initPinLayout()
        #endif
    }
    
    deinit {
        if !isLayouted && Pin.logMissingLayoutCalls {
            warn("PinLayout commands have been issued without calling the 'layout()' method to complete the layout. (These warnings can be disabled by setting Pin.logMissingLayoutCalls to false)")
        }
        apply()
    }

    #if os(iOS) || os(tvOS)
    public var safeArea: PEdgeInsets {
        if let view = view as? UIView {
            if #available(iOS 11.0, tvOS 11.0, *) {
                return view.safeAreaInsets
            } else {
                return view.pinlayoutComputeSafeAreaInsets()
            }
        } else {
            return .zero
        }
    }

    public var readableMargins: PEdgeInsets {
        guard #available(iOS 9.0, *) else { return .zero }
        guard let view = view as? UIView else { return .zero }

        let layoutFrame = view.readableContentGuide.layoutFrame
        guard !layoutFrame.isEmpty else { return .zero }
        
        return UIEdgeInsets(top: layoutFrame.origin.y, left: layoutFrame.origin.x,
                            bottom: view.frame.height - layoutFrame.origin.y - layoutFrame.height,
                            right: view.frame.width - layoutFrame.origin.x - layoutFrame.width)
    }

    public var layoutMargins: PEdgeInsets {
        guard let view = view as? UIView else { return .zero }
        return view.layoutMargins
    }
    #endif

    //
    // MARK: Layout using distances from superview’s edges
    //
    // top, left, bottom, right
    //

    /// Position the view's top edge.
    ///
    /// - Parameter offset: (Optional, default value is 0). Specifies a distance from the superview's
    ///                     top edge in pixels.
    @discardableResult
    public func top(_ offset: CGFloat = 0) -> PinLayout {
        return top(offset, { return "top(\(offset.optionnalDescription))" })
    }

    /// Position the top edge.
    ///
    /// - Parameter percent: Specifies the top edge distance from the superview's top edge in
    ///                      percentage of its superview's height.
    @discardableResult
    public func top(_ percent: Percent) -> PinLayout {
        func context() -> String { return "top(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTop(percent.of(layoutSuperviewRect.height), context)
        return self
    }

    /// Position the top edge.
    /// The value
    ///
    /// - Parameter insets: specifies the top edge distance from the superview's top edge in pixels using
    ///                     the `UIEdgeInsets.top` property. It is particularly useful with `UIView.pin.safeArea` or
    ///                     `UIView.safeAreaInsets`.
    @discardableResult
    public func top(_ insets: PEdgeInsets) -> PinLayout {
        return top(insets.top, { return "top(\(insetsDescription(insets))" })
    }

    /// Position the left edge.
    ///
    /// - Parameter offset: (Optional, default value is 0). Specifies a distance from the superview's
    ///                     left edge in pixels
    @discardableResult
    public func left(_ offset: CGFloat = 0) -> PinLayout {
        return left(offset, { return "left(\(offset.optionnalDescription))" })
    }

    /// Position the left edge.
    ///
    /// - Parameter offset: specifies the left edge distance from the superview's left edge in
    ///                     percentage of its superview's width.
    @discardableResult
    public func left(_ offset: Percent) -> PinLayout {
        return left(offset, { return "left(\(offset.description))" })
    }

    /// Position the left edge.
    ///
    /// - Parameter insets: specifies the left edge distance from the superview's left edge in pixels using
    ///                     the `UIEdgeInsets.left` property. It is particularly useful with `UIView.pin.safeArea` or
    ///                     `UIView.safeAreaInsets`.
    @discardableResult
    public func left(_ insets: PEdgeInsets) -> PinLayout {
        return left(insets.left, { return "left(\(insetsDescription(insets))" })
    }

    /// Position the left edge In LTR direction.
    /// Position the right edge In RTL direction.
    ///
    /// - Parameter offset: (Optional, default value is 0) In LTR direction the value specifies the left
    ///                     edge distance from the superview's left edge in pixels. In RTL direction the
    ///                     value specifies the right edge distance from the superview's right edge in pixels.
    @discardableResult
    public func start(_ offset: CGFloat = 0) -> PinLayout {
        func context() -> String { return "start(\(offset.optionnalDescription))" }
        return isLTR() ? left(offset, context) : right(offset, context)
    }

    /// In LTR direction, position the left edge.
    /// In RTL direction, position the right edge.
    ///
    /// - Parameter offset: (Optional, default value is 0) Specifies a distance from the superview's
    ///                     corresponding edge in percentage of its superview's width.
    @discardableResult
    public func start(_ offset: Percent) -> PinLayout {
        func context() -> String { return "start(\(offset.description))" }
        return isLTR() ? left(offset, context) : right(offset, context)
    }

    @discardableResult
    public func start(_ insets: PEdgeInsets) -> PinLayout {
        func context() -> String { return "start(\(insetsDescription(insets))" }
        return isLTR() ? left(insets.left, context) : right(insets.right, context)
    }
    
    @discardableResult
    public func bottom(_ offset: CGFloat = 0) -> PinLayout {
        return bottom(offset, { return "bottom(\(offset.optionnalDescription))" })
    }

    @discardableResult
    public func bottom(_ offset: Percent) -> PinLayout {
        return bottom(offset, { return "bottom(\(offset.description))" })
    }

    @discardableResult
    public func bottom(_ insets: PEdgeInsets) -> PinLayout {
        return bottom(insets.bottom, { return "bottom(\(insetsDescription(insets))" })
    }

    @discardableResult
    public func right(_ offset: CGFloat = 0) -> PinLayout {
        return right(offset, { return "right(\(offset.optionnalDescription))" })
    }

    @discardableResult
    public func right(_ offset: Percent) -> PinLayout {
        return right(offset, { return "right(\(offset.description))" })
    }

    @discardableResult
    public func right(_ insets: PEdgeInsets) -> PinLayout {
        return right(insets.right, { return "right(\(insetsDescription(insets))" })
    }
    
    @discardableResult
    public func end(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "end(\(margin.optionnalDescription))" }
        return isLTR() ? right(margin, context) : left(margin, context)
    }

    @discardableResult
    public func end(_ offset: Percent) -> PinLayout {
        func context() -> String { return "end(\(offset.description))" }
        return isLTR() ? right(offset, context) : left(offset, context)
    }

    @discardableResult
    public func end(_ insets: PEdgeInsets) -> PinLayout {
        func context() -> String { return "end(\(insetsDescription(insets))" }
        return isLTR() ? right(insets.right, context) : left(insets.left, context)
    }

    @discardableResult
    public func hCenter(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "hCenter(\(margin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + margin, context)
        return self
    }

    @discardableResult
    public func hCenter(_ offset: Percent) -> PinLayout {
        func context() -> String { return "hCenter(\(offset.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + offset.of(layoutSuperviewRect.width), context)
        return self
    }

    @discardableResult
    public func vCenter(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "vCenter(\(margin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + margin, context)
        return self
    }

    @discardableResult
    public func vCenter(_ offset: Percent) -> PinLayout {
        func context() -> String { return "vCenter(\(offset.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + offset.of(layoutSuperviewRect.height), context)
        return self
    }

    // Pin multiple edges at once.

    /**
     Pin all edges on its superview's corresponding edges (top, bottom, left, right).
     The optionnal value specifies edges distance from the superview's corresponding edge in pixels.

     Similar to calling `view.top(margin).bottom(margin).left(margin).right(margin)`
     */
    @discardableResult
    public func all(_ margin: CGFloat = 0) -> PinLayout {
        top(margin, { "all(\(margin.optionnalDescription)) top coordinate" })
        bottom(margin, { "all(\(margin.optionnalDescription)) bottom coordinate" })
        left(margin, { "all(\(margin.optionnalDescription)) left coordinate" })
        right(margin, { "all(\(margin.optionnalDescription)) right coordinate" })
        return self
    }

    /**
     Pin all edges on its superview's corresponding edges (top, bottom, left, right).

     Similar to calling `view.top(insets).bottom(insets).left(insets).right(insets)`
     */
    @discardableResult
    public func all(_ insets: PEdgeInsets) -> PinLayout {
        top(insets.top, { "all(\(insets)) top coordinate" })
        bottom(insets.bottom, { "all(\(insets)) bottom coordinate" })
        left(insets.left, { "all(\(insets)) left coordinate" })
        right(insets.right, { "all(\(insets)) right coordinate" })
        return self
    }

    /**
     Pin the left and right edges on its superview's corresponding edges.

     Similar to calling `view.left().right()`.
     */
    @discardableResult
    public func horizontally(_ margin: CGFloat = 0) -> PinLayout {
        left(margin, { return "horizontally(\(margin.optionnalDescription)) left coordinate" })
        right(margin, { return "horizontally(\(margin.optionnalDescription)) right coordinate" })
        return self
    }

    /**
     Pin the left and right edges on its superview's corresponding edges.

     Similar to calling `view.left().right()`.
     */
    @discardableResult
    public func horizontally(_ percent: Percent) -> PinLayout {
        left(percent, { return "horizontally(\(percent.description)) left coordinate" })
        right(percent, { return "horizontally(\(percent.description)) right coordinate" })
        return self
    }

    /**
     Pin the left and right edges on its superview's corresponding edges.

     Similar to calling `view.left().right()`.
     */
    @discardableResult
    public func horizontally(_ insets: PEdgeInsets) -> PinLayout {
        left(insets.left, { return "horizontally(\(insets)) left coordinate" })
        right(insets.right, { return "horizontally(\(insets)) right coordinate" })
        return self
    }

    /**
     Pin the **top and bottom edges** on its superview's corresponding edges.

     Similar to calling `view.top(margin).bottom(margin)`.
     */
    @discardableResult
    public func vertically(_ margin: CGFloat = 0) -> PinLayout {
        top(margin, { return "vertically(\(margin.optionnalDescription)) top coordinate" })
        bottom(margin, { return "vertically(\(margin.optionnalDescription)) bottom coordinate" })
        return self
    }

    /**
     Pin the **top and bottom edges** on its superview's corresponding edges.

     Similar to calling `view.top(percent).bottom(percent)`.
     */
    @discardableResult
    public func vertically(_ percent: Percent) -> PinLayout {
        top(percent, { return "vertically(\(percent.description)) top coordinate" })
        bottom(percent, { return "vertically(\(percent.description)) bottom coordinate" })
        return self
    }

    /**
     Pin the **top and bottom edges** on its superview's corresponding edges.
     The UIEdgeInsets.top is used to pin the top edge and the UIEdgeInsets.bottom
     for the bottom edge.
     */
    @discardableResult
    public func vertically(_ insets: PEdgeInsets) -> PinLayout {
        top(insets.top, { return "vertically(\(insets)) top coordinate" })
        bottom(insets.bottom, { return "vertically(\(insets)) bottom coordinate" })
        return self
    }

    //
    // MARK: Layout using edges
    //
    // top, left, bottom, right
    //

    @discardableResult
    public func top(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "top", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setTop(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func vCenter(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "vCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setVerticalCenter(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func bottom(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "bottom", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setBottom(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func left(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "left", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setLeft(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func hCenter(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "hCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setHorizontalCenter(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func right(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "right", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setRight(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func start(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "start", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setStart(coordinate, context)
        }
        return self
    }

    @discardableResult
    public func end(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "end", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setEnd(coordinate, context)
        }
        return self
    }

    //
    // MARK: Layout using anchors
    //
    // topLeft, topCenter, topRight,
    // centerLeft, center, centerRight,
    // bottomLeft, bottomCenter, bottomRight,
    //

    @discardableResult
    public func topLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topLeft", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setTopLeft(coordinates[0], context)
        }
        return self
    }

    /// Position the top and left edges.
    ///
    /// - Parameter margin: (Optional, default value is 0). Specifies a distance from their superview's
    //                      corresponding edges in pixels
    @discardableResult
    public func topLeft(_ margin: CGFloat = 0) -> PinLayout {
        return topLeft(margin, context: { return "topLeft(\(margin.optionnalDescription)" })
    }

    @discardableResult
    public func topStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topStart", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinates[0].y, context)
            setStart(coordinates[0].x, context)
        }
        return self
    }

    /// In LTR direction position the top and left edges.
    /// In RTL direction position the top and right edges.
    ///
    /// - Parameter margin: specifies the distance from their superview's
    ///                     corresponding edges in pixels.
    @discardableResult
    public func topStart(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "topStart(\(margin.optionnalDescription))" }
        return isLTR() ? topLeft(margin, context: context) : topRight(margin, context: context)
    }

    private func topLeft(_ margin: CGFloat, context: Context) -> PinLayout {
        setTopLeft(CGPoint(x: margin, y: margin), context)
        return self
    }

    @discardableResult
    public func topCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setTopCenter(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func topCenter(_ topMargin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "topCenter(\(topMargin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTopCenter(CGPoint(x: layoutSuperviewRect.width / 2, y: topMargin), context)
        return self
    }

    @discardableResult
    public func topRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topRight", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setTopRight(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func topRight(_ margin: CGFloat = 0) -> PinLayout {
        return topRight(margin, context: { return "topRight(\(margin.optionnalDescription))" })
    }
    
    @discardableResult
    public func topEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topEnd", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinates[0].y, context)
            setEnd(coordinates[0].x, context)
        }
        return self
    }

    @discardableResult
    public func topEnd(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "topEnd(\(margin.optionnalDescription))" }
        return isLTR() ? topRight(margin, context: context) : topLeft(margin, context: context)
    }

    private func topRight(_ margin: CGFloat, context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTopRight(CGPoint(x: layoutSuperviewRect.width - margin, y: margin), context)
        return self
    }

    @discardableResult
    public func centerLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerLeft", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setCenterLeft(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func centerLeft(_ leftMargin: CGFloat = 0) -> PinLayout {
        return centerLeft(leftMargin, context: { return "centerLeft(\(leftMargin.optionnalDescription))" })
    }
    
    @discardableResult
    public func centerStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerStart", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinates[0].y, context)
            setStart(coordinates[0].x, context)
        }
        return self
    }

    @discardableResult
    public func centerStart(_ startMargin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "centerStart(\(startMargin.optionnalDescription))" }
        return isLTR() ? centerLeft(startMargin, context: context) : centerRight(startMargin, context: context)
    }

    private func centerLeft(_ leftMargin: CGFloat, context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenterLeft(CGPoint(x: leftMargin, y: layoutSuperviewRect.height / 2), context)
        return self
    }

    @discardableResult
    public func center(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "center", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setCenter(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func center(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "center(\(margin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenter(CGPoint(x: (layoutSuperviewRect.width / 2) + margin, y: (layoutSuperviewRect.height / 2) + margin), context)
        return self
    }

    @discardableResult
    public func centerRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerRight", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setCenterRight(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func centerRight(_ rightMargin: CGFloat = 0) -> PinLayout {
        return centerRight(rightMargin, context: { return "centerRight(\(rightMargin.optionnalDescription))" })
    }

    @discardableResult
    public func centerEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerEnd", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinates[0].y, context)
            setEnd(coordinates[0].x, context)
        }
        return self
    }

    @discardableResult
    public func centerEnd(_ endMargin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "centerEnd(\(endMargin.optionnalDescription))" }
        return isLTR() ? centerRight(endMargin, context: context) : centerLeft(endMargin, context: context)
    }

    private func centerRight(_ rightMargin: CGFloat, context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setCenterRight(CGPoint(x: layoutSuperviewRect.width - rightMargin, y: layoutSuperviewRect.height / 2), context)
        return self
    }

    @discardableResult
    public func bottomLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomLeft", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setBottomLeft(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func bottomLeft(_ margin: CGFloat = 0) -> PinLayout {
        return bottomLeft(margin, context: { return "bottomLeft(\(margin.optionnalDescription))" })
    }

    private func bottomLeft(_ margin: CGFloat, context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomLeft(CGPoint(x: margin, y: layoutSuperviewRect.height - margin), context)
        return self
    }

    @discardableResult
    public func bottomStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomStart", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinates[0].y, context)
            setStart(coordinates[0].x, context)
        }
        return self
    }

    @discardableResult
    public func bottomStart(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "bottomStart(\(margin.optionnalDescription)" }
        return isLTR() ? bottomLeft(margin, context: context) : bottomRight(margin, context: context)
    }

    @discardableResult
    public func bottomCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomCenter", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setBottomCenter(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func bottomCenter(_ bottomMargin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "bottomCenter(\(bottomMargin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomCenter(CGPoint(x: layoutSuperviewRect.width / 2, y: layoutSuperviewRect.height - bottomMargin), context)
        return self
    }

    @discardableResult
    public func bottomRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomRight", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setBottomRight(coordinates[0], context)
        }
        return self
    }

    @discardableResult
    public func bottomRight(_ margin: CGFloat = 0) -> PinLayout {
        return bottomRight(margin, context: { return "bottomRight(\(margin.optionnalDescription))" })
    }

    private func bottomRight(_ margin: CGFloat, context: Context) -> PinLayout {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setBottomRight(CGPoint(x: layoutSuperviewRect.width - margin, y: layoutSuperviewRect.height - margin), context)
        return self
    }

    @discardableResult
    public func bottomEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomEnd", anchor: anchor) }
        if let coordinates = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinates[0].y, context)
            setEnd(coordinates[0].x, context)
        }
        return self
    }

    @discardableResult
    public func bottomEnd(_ margin: CGFloat = 0) -> PinLayout {
        func context() -> String { return "bottomEnd(\(margin.optionnalDescription))" }
        return isLTR() ? bottomRight(margin, context: context) : bottomLeft(margin, context: context)
    }

    //
    // MARK: Width, height
    //

    @discardableResult
    public func width(_ width: CGFloat) -> PinLayout {
        return setWidth(width, { return "width(\(width))" })
    }

    @discardableResult
    public func width(_ percent: Percent) -> PinLayout {
        func context() -> String { return "width(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setWidth(percent.of(layoutSuperviewRect.width), context)
    }

    @discardableResult
    public func width(of view: View) -> PinLayout {
        let rect = view.getRect(keepTransform: keepTransform)
        return setWidth(rect.width, { return "width(of: \(viewDescription(view)))" })
    }

    @discardableResult
    public func minWidth(_ width: CGFloat) -> PinLayout {
        setMinWidth(width, { return "minWidth(\(width))" })
        return self
    }

    @discardableResult
    public func minWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minWidth(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMinWidth(percent.of(layoutSuperviewRect.width), context)
    }

    @discardableResult
    public func maxWidth(_ width: CGFloat) -> PinLayout {
        setMaxWidth(width, { return "maxWidth(\(width))" })
        return self
    }

    @discardableResult
    public func maxWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxWidth(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMaxWidth(percent.of(layoutSuperviewRect.width), context)
    }

    @discardableResult
    public func height(_ height: CGFloat) -> PinLayout {
        return setHeight(height, { return "height(\(height))" })
    }

    @discardableResult
    public func height(_ percent: Percent) -> PinLayout {
        func context() -> String { return "height(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setHeight(percent.of(layoutSuperviewRect.height), context)
    }

    @discardableResult
    public func height(of view: View) -> PinLayout {
        let rect = view.getRect(keepTransform: keepTransform)
        return setHeight(rect.height, { return "height(of: \(viewDescription(view)))" })
    }

    @discardableResult
    public func minHeight(_ height: CGFloat) -> PinLayout {
        setMinHeight(height, { return "minHeight(\(height))" })
        return self
    }

    @discardableResult
    public func minHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minHeight(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMinHeight(percent.of(layoutSuperviewRect.height), context)
    }

    @discardableResult
    public func maxHeight(_ height: CGFloat) -> PinLayout {
        setMaxHeight(height, { return "maxHeight(\(height))" })
        return self
    }

    @discardableResult
    public func maxHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxHeight(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        return setMaxHeight(percent.of(layoutSuperviewRect.height), context)
    }

    //
    // MARK: justify / align
    //

    @discardableResult
    public func justify(_ value: HorizontalAlign) -> PinLayout {
        justify = value
        return self
    }

    @discardableResult
    public func align(_ value: VerticalAlign) -> PinLayout {
        align = value
        return self
    }
    
    //
    // MARK: Margins
    //

    /**
     Set the top margin.
     */
    @discardableResult
    public func marginTop(_ margin: CGFloat) -> PinLayout {
        marginTop = margin
        return self
    }

    /**
     Set the top margin.
     */
    @discardableResult
    public func marginTop(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginTop(\(percent.description))" }
        return marginTop(percent, context)
    }

    private func marginTop(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginTop = percent.of(layoutSuperviewRect.height)
        return self
    }

    /**
     Set the left margin.
     */
    @discardableResult
    public func marginLeft(_ margin: CGFloat) -> PinLayout {
        marginLeft = margin
        return self
    }

    /**
     Set the left margin.
     */
    @discardableResult
    public func marginLeft(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginLeft(\(percent.description))" }
        return marginLeft(percent, context)
    }

    private func marginLeft(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginLeft = percent.of(layoutSuperviewRect.width)
        return self
    }

    /**
     Set the bottom margin.
     */
    @discardableResult
    public func marginBottom(_ margin: CGFloat) -> PinLayout {
        marginBottom = margin
        return self
    }

    /**
     Set the bottom margin.
     */
    @discardableResult
    public func marginBottom(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginBottom(\(percent.description))" }
        return marginBottom(percent, context)
    }

    private func marginBottom(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginBottom = percent.of(layoutSuperviewRect.height)
        return self
    }

    /**
     Set the right margin.
     */
    @discardableResult
    public func marginRight(_ margin: CGFloat) -> PinLayout {
        marginRight = margin
        return self
    }

    /**
     Set the right margin.
     */
    @discardableResult
    public func marginRight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginRight(\(percent.description))" }
        return marginRight(percent, context)
    }

    private func marginRight(_ percent: Percent, _ context: Context) -> Self {
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        marginRight = percent.of(layoutSuperviewRect.width)
        return self
    }

    // RTL support

    /**
     Set the start margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, start margin specify the **left** margin.
     * In RTL direction, start margin specify the **right** margin.
     */
    @discardableResult
    public func marginStart(_ margin: CGFloat) -> PinLayout {
        return isLTR() ? marginLeft(margin) : marginRight(margin)
    }

    /**
     Set the start margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, start margin specify the **left** margin.
     * In RTL direction, start margin specify the **right** margin.
     */
    @discardableResult
    public func marginStart(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginStart(\(percent.description))" }
        return isLTR() ? marginLeft(percent, context) : marginRight(percent, context)
    }

    /**
     Set the end margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, end margin specify the **right** margin.
     * In RTL direction, end margin specify the **left** margin.
     */
    @discardableResult
    public func marginEnd(_ margin: CGFloat) -> PinLayout {
        return isLTR() ? marginRight(margin) : marginLeft(margin)
    }

    /**
     Set the end margin.

     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, end margin specify the **right** margin.
     * In RTL direction, end margin specify the **left** margin.
     */
    @discardableResult
    public func marginEnd(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginEnd(\(percent.description))" }
        return isLTR() ? marginRight(percent, context) : marginLeft(percent, context)
    }

    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult
    public func marginHorizontal(_ margin: CGFloat) -> PinLayout {
        marginLeft = margin
        marginRight = margin
        return self
    }

    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult
    public func marginHorizontal(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginHorizontal(\(percent.description))" }
        return marginHorizontal(percent, context)
    }

    private func marginHorizontal(_ percent: Percent, _ context: Context) -> Self {
        return marginLeft(percent, context).marginRight(percent, context)
    }

    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult
    public func marginVertical(_ margin: CGFloat) -> PinLayout {
        marginTop = margin
        marginBottom = margin
        return self
    }

    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult
    public func marginVertical(_ percent: Percent) -> PinLayout {
        func context() -> String { return "marginVertical(\(percent.description))" }
        return marginVertical(percent, context)
    }

    private func marginVertical(_ percent: Percent, _ context: Context) -> Self {
        return marginTop(percent, context).marginBottom(percent, context)
    }

    /**
     Set all margins using UIEdgeInsets.
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult
    public func margin(_ insets: PEdgeInsets) -> PinLayout {
        marginTop = insets.top
        marginBottom = insets.bottom
        marginLeft = insets.left
        marginRight = insets.right
        return self
    }

    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.

     Available only on iOS 11 and higher.
     */
    #if os(iOS) || os(tvOS)
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult
    public func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayout {
        marginTop = directionalInsets.top
        marginBottom = directionalInsets.bottom
        marginStart(directionalInsets.leading)
        marginEnd(directionalInsets.trailing)
        return self
    }
    #endif

    /**
     Set all margins to the specified value.
     */
    @discardableResult
    public func margin(_ margin: CGFloat) -> PinLayout {
        marginTop = margin
        marginLeft = margin
        marginBottom = margin
        marginRight = margin
        return self
    }

    /**
     Set all margins to the specified value.
     */
    @discardableResult
    public func margin(_ percent: Percent) -> PinLayout {
        func context() -> String { return "margin(\(percent.description))" }
        return marginTop(percent, context)
            .marginLeft(percent, context)
            .marginBottom(percent, context)
            .marginRight(percent, context)
    }

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult
    public func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = left
        marginBottom = bottom
        marginRight = right
        return self
    }

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult
    public func margin(_ top: Percent, _ left: Percent, _ bottom: Percent, _ right: Percent) -> PinLayout {
        func context() -> String {
            return "margin(top: \(top.description), left: \(left.description), bottom: \(bottom.description), right: \(right.description)"
        }
        return marginTop(top, context)
            .marginLeft(left, context)
            .marginBottom(bottom, context)
            .marginRight(right, context)
    }

    /**
     Set individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult
    public func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> PinLayout {
        marginTop = vertical
        marginLeft = horizontal
        marginBottom = vertical
        marginRight = horizontal
        return self
    }

    /**
     Set individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult
    public func margin(_ vertical: Percent, _ horizontal: Percent) -> PinLayout {
        func context() -> String { return "margin(vertical: \(vertical.description), horizontal: \(horizontal.description)" }
        return marginVertical(vertical, context).marginHorizontal(horizontal, context)
    }

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult
    public func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = horizontal
        marginBottom = bottom
        marginRight = horizontal
        return self
    }

    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult
    public func margin(_ top: Percent, _ horizontal: Percent, _ bottom: Percent) -> PinLayout {
        func context() -> String { return "margin(top: \(top.description), horizontal: \(horizontal.description), bottom: \(bottom.description)" }
        return marginTop(top, context).marginHorizontal(horizontal, context).marginBottom(bottom, context)
    }

    /// Normally if only either left or right has been specified, PinLayout will MOVE the view to apply left or right margins.
    /// This is also true even if the width has been set.
    /// Calling pinEdges() will force PinLayout to pin the four edges and then apply left and/or right margins, and this without
    /// moving the view.
    @discardableResult
    public func pinEdges() -> PinLayout {
        shouldPinEdges = true
        return self
    }
}

//
// MARK: Private methods
//
extension PinLayout {
    internal func layoutSuperviewRect(_ context: Context) -> CGRect? {
        if let superview = view.superview {
            return superview.getRect(keepTransform: keepTransform)
        } else {
            // Disable this warning: Using XIB, layoutSubview() is called even before views have been
            // added, and there is no way to modify that strange behaviour of UIKit.
            //warnWontBeApplied("the view must be added as a sub-view before being layouted using this method.", context)
            return nil
        }
    }
    
    internal func layoutSuperview(_ context: Context) -> View? {
        if let superview = view.superview {
            return superview as? View
        } else {
            // Disable this warning: Using XIB, layoutSubview() is called even before views have been
            // added, and there is no way to modify that strange behaviour of UIKit.
            //warnWontBeApplied("the view must be added as a sub-view before being layouted using this method.", context)
            return nil
        }
    }

    internal func referenceSuperview(_ referenceView: View, _ context: Context) -> View? {
        if let superview = referenceView.superview {
            return superview as? View
        } else {
            warnWontBeApplied("the reference view \(viewDescription(referenceView)) must be added as a sub-view before being used as a reference.", context)
            return nil
        }
    }
}
