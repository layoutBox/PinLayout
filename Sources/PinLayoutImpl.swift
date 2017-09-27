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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
    
class PinLayoutImpl: PinLayout {
    internal let view: UIView

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

    internal var shouldSizeToFit = false
    internal var _aspectRatio: CGFloat?

    internal var shouldKeepViewDimension: Bool {
        return !shouldSizeToFit && _aspectRatio == nil
    }
    
    internal var marginTop: CGFloat?
    internal var marginLeft: CGFloat?
    internal var marginBottom: CGFloat?
    internal var marginRight: CGFloat?
    internal var shouldPinEdges = false
    
    internal var justify: HorizontalAlign?
    internal var align: VerticalAlign?
    
    internal var _marginTop: CGFloat { return marginTop ?? 0  }
    internal var _marginLeft: CGFloat { return marginLeft ?? 0 }
    internal var _marginBottom: CGFloat { return marginBottom ?? 0 }
    internal var _marginRight: CGFloat { return marginRight ?? 0 }
    
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
    
    @discardableResult
    func top(_ percent: Percent) -> PinLayout {
        func context() -> String { return "top(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setTop(percent.of(layoutSuperview.frame.height), context)
        return self
    }
    
    @discardableResult
    func left() -> PinLayout {
        return left({ return "left()" })
    }

    @discardableResult
    func left(_ value: CGFloat) -> PinLayout {
        return left(value, { return "left(\(value))" })
    }
    
    @discardableResult
    func left(_ percent: Percent) -> PinLayout {
        return left(percent, { return "left(\(percent))" })
    }
    
    @discardableResult
    func start() -> PinLayout {
        func context() -> String { return "start()" }
        return isLTR() ? left(context) : right(context)
    }
    
    @discardableResult
    func start(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "start(\(value))" }
        return isLTR() ? left(value, context) : right(value, context)
    }
    
    @discardableResult
    func start(_ percent: Percent) -> PinLayout {
        func context() -> String { return "start(\(percent))" }
        return isLTR() ? left(percent, context) : right(percent, context)
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
    
    @discardableResult
    func bottom(_ percent: Percent) -> PinLayout {
        func context() -> String { return "bottom(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottom(layoutSuperview.frame.height - percent.of(layoutSuperview.frame.height), context)
        return self
    }

    @discardableResult func right() -> PinLayout {
        return right({ return "right()" })
    }

    @discardableResult
    func right(_ value: CGFloat) -> PinLayout {
        return right(value, { return "right(\(value))" })
    }
    
    @discardableResult
    func right(_ percent: Percent) -> PinLayout {
        return right(percent, { return "right(\(percent))" })
    }
    
    @discardableResult func end() -> PinLayout {
        func context() -> String { return "end()" }
        return isLTR() ? right(context) : left(context)
    }
    
    @discardableResult
    func end(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "end(\(value))" }
        return isLTR() ? right(value, context) : left(value, context)
    }
    
    @discardableResult
    func end(_ percent: Percent) -> PinLayout {
        func context() -> String { return "end(\(percent))" }
        return isLTR() ? right(percent, context) : left(percent, context)
    }

    @discardableResult
    func hCenter() -> PinLayout {
        func context() -> String { return "hCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setHorizontalCenter(layoutSuperview.frame.width / 2, context)
        return self
    }
    
    @discardableResult
    func hCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "hCenter(\(value))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setHorizontalCenter((layoutSuperview.frame.width / 2) + value, context)
        return self
    }
    
    @discardableResult
    func hCenter(_ percent: Percent) -> PinLayout {
        func context() -> String { return "hCenter(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setHorizontalCenter((layoutSuperview.frame.width / 2) + percent.of(layoutSuperview.frame.width), context)
        return self
    }

    @discardableResult
    func vCenter() -> PinLayout {
        func context() -> String { return "vCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setVerticalCenter(layoutSuperview.frame.height / 2, context)
        return self
    }
    
    @discardableResult
    func vCenter(_ value: CGFloat) -> PinLayout {
        func context() -> String { return "vCenter(\(value))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setVerticalCenter((layoutSuperview.frame.height / 2) + value, context)
        return self
    }
    
    @discardableResult
    func vCenter(_ percent: Percent) -> PinLayout {
        func context() -> String { return "vCenter(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setVerticalCenter((layoutSuperview.frame.height / 2) + percent.of(layoutSuperview.frame.height), context)
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
    func vCenter(to edge: VerticalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "vCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setVerticalCenter(coordinate, context)
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
    func left(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "left", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setLeft(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func hCenter(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "hCenter", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setHorizontalCenter(coordinate, context)
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
    
    @discardableResult
    func start(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "start", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setStart(coordinate, context)
        }
        return self
    }
    
    @discardableResult
    func end(to edge: HorizontalEdge) -> PinLayout {
        func context() -> String { return relativeEdgeContext(method: "end", edge: edge) }
        if let coordinate = computeCoordinate(forEdge: edge, context) {
            setEnd(coordinate, context)
        }
        return self
    }

    
    //
    // topLeft, topCenter, topRight,
    // centerLeft, center, centerRight,
    // bottomLeft, bottomCenter, bottomRight,
    //
    @discardableResult
    func topLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopLeft(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topLeft() -> PinLayout {
        return topLeft({ return "topLeft()" })
    }
    
    fileprivate func topLeft(_ context: Context) -> PinLayout {
        setTopLeft(CGPoint(x: 0, y: 0), { return "topLeft()" })
        return self
    }
    
    @discardableResult
    func topStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }

    @discardableResult
    func topStart() -> PinLayout {
        func context() -> String { return "topStart()" }
        return isLTR() ? topLeft(context) : topRight(context)
    }
  
    @discardableResult
    func topCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topCenter", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopCenter(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topCenter() -> PinLayout {
        func context() -> String { return "topCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setTopCenter(CGPoint(x: layoutSuperview.frame.width / 2, y: 0), context)
        return self
    }

    @discardableResult
    func topRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTopRight(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func topRight() -> PinLayout {
        return topRight({ return "topRight()" })
    }
    
    fileprivate func topRight(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setTopRight(CGPoint(x: layoutSuperview.frame.width, y: 0), context)
        return self
    }
    
    @discardableResult
    func topEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "topEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setTop(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func topEnd() -> PinLayout {
        func context() -> String { return "topEnd()" }
        return isLTR() ? topRight(context) : topLeft(context)
    }
    
    @discardableResult
    func centerLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenterLeft(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func centerLeft() -> PinLayout {
        return centerLeft({ return "centerLeft()" })
    }
    
    fileprivate func centerLeft(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setCenterLeft(CGPoint(x: 0, y: layoutSuperview.frame.height / 2), context)
        return self
    }

    @discardableResult
    func centerStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult 
    func centerStart() -> PinLayout {
        func context() -> String { return "centerStart()" }
        return isLTR() ? centerLeft(context) : centerRight(context)
    }
    
    @discardableResult
    func center(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "center", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenter(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func center() -> PinLayout {
        func context() -> String { return "center()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setCenter(CGPoint(x: layoutSuperview.frame.width / 2, y: layoutSuperview.frame.height / 2), context)
        return self
    }
    
    @discardableResult
    func centerRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setCenterRight(coordinatesList[0], context)
        }
        return self
    }
    
    @discardableResult
    func centerRight() -> PinLayout {
        return centerRight({ return "centerRight()" })
    }
    
    @discardableResult
    fileprivate func centerRight(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setCenterRight(CGPoint(x: layoutSuperview.frame.width, y: layoutSuperview.frame.height / 2), context)
        return self
    }
    
    @discardableResult
    func centerEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "centerEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setVerticalCenter(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func centerEnd() -> PinLayout {
        func context() -> String { return "centerEnd()" }
        return isLTR() ? centerRight(context) : centerLeft(context)
    }
    
    @discardableResult
    func bottomLeft(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomLeft", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomLeft(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomLeft() -> PinLayout {
        return bottomLeft({ return "bottomLeft()" })
    }
    
    @discardableResult
    fileprivate func bottomLeft(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottomLeft(CGPoint(x: 0, y: layoutSuperview.frame.height), context)
        return self
    }
    
    @discardableResult
    func bottomStart(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomStart", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinatesList[0].y, context)
            setStart(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func bottomStart() -> PinLayout {
        func context() -> String { return "bottomStart()" }
        return isLTR() ? bottomLeft(context) : bottomRight(context)
    }

    @discardableResult
    func bottomCenter(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomCenter", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomCenter(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomCenter() -> PinLayout {
        func context() -> String { return "bottomCenter()" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottomCenter(CGPoint(x: layoutSuperview.frame.width / 2, y: layoutSuperview.frame.height), context)
        return self
    }

    @discardableResult
    func bottomRight(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomRight", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottomRight(coordinatesList[0], context)
        }
        return self
    }

    @discardableResult
    func bottomRight() -> PinLayout {
        return bottomRight({ return "bottomRight()" })
    }
    
    @discardableResult
    fileprivate func bottomRight(_ context: Context) -> PinLayout {
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        setBottomRight(CGPoint(x: layoutSuperview.frame.width, y: layoutSuperview.frame.height), context)
        return self
    }

    @discardableResult
    func bottomEnd(to anchor: Anchor) -> PinLayout {
        func context() -> String { return relativeAnchorContext(method: "bottomEnd", anchor: anchor) }
        if let coordinatesList = computeCoordinates(forAnchors: [anchor], context) {
            setBottom(coordinatesList[0].y, context)
            setEnd(coordinatesList[0].x, context)
        }
        return self
    }
    
    @discardableResult
    func bottomEnd() -> PinLayout {
        func context() -> String { return "bottomEnd()" }
        return isLTR() ? bottomRight(context) : bottomLeft(context)
    }

    //
    // width, height
    //
    @discardableResult
    func width(_ width: CGFloat) -> PinLayout {
        return setWidth(width, { return "width(\(width))" })
    }
    
    @discardableResult
    func width(_ percent: Percent) -> PinLayout {
        func context() -> String { return "width(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setWidth(percent.of(layoutSuperview.frame.width), context)
    }

    @discardableResult
    func width(of view: UIView) -> PinLayout {
        return setWidth(view.frame.width, { return "width(of: \(viewDescription(view)))" })
    }
    
    @discardableResult
    func minWidth(_ width: CGFloat) -> PinLayout {
        setMinWidth(width, { return "minWidth(\(width))" })
        return self
    }
    
    @discardableResult
    func minWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minWidth(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setMinWidth(percent.of(layoutSuperview.frame.width), context)
    }
    
    @discardableResult
    func maxWidth(_ width: CGFloat) -> PinLayout {
        setMaxWidth(width, { return "maxWidth(\(width))" })
        return self
    }
    
    @discardableResult
    func maxWidth(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxWidth(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setMaxWidth(percent.of(layoutSuperview.frame.width), context)
    }

    @discardableResult
    func height(_ height: CGFloat) -> PinLayout {
        return setHeight(height, { return "height(\(height))" })
    }
    
    @discardableResult
    func height(_ percent: Percent) -> PinLayout {
        func context() -> String { return "height(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setHeight(percent.of(layoutSuperview.frame.height), context)
    }

    @discardableResult
    func height(of view: UIView) -> PinLayout {
        return setHeight(view.frame.height, { return "height(of: \(viewDescription(view)))" })
    }
    
    @discardableResult
    func minHeight(_ height: CGFloat) -> PinLayout {
        setMinHeight(height, { return "minHeight(\(height))" })
        return self
    }
    
    @discardableResult
    func minHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "minHeight(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setMinHeight(percent.of(layoutSuperview.frame.height), context)
    }
    
    @discardableResult
    func maxHeight(_ height: CGFloat) -> PinLayout {
        setMaxHeight(height, { return "maxHeight(\(height))" })
        return self
    }
    
    @discardableResult
    func maxHeight(_ percent: Percent) -> PinLayout {
        func context() -> String { return "maxHeight(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        return setMaxHeight(percent.of(layoutSuperview.frame.height), context)
    }
    
    //
    // size, sizeToFit
    //
    @discardableResult
    func size(_ size: CGSize) -> PinLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }
    
    @discardableResult
    func size(_ sideLength: CGFloat) -> PinLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }
    
    @discardableResult
    func size(_ percent: Percent) -> PinLayout {
        func context() -> String { return "size(\(percent))" }
        guard let layoutSuperview = layoutSuperview(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperview.frame.width), height: percent.of(layoutSuperview.frame.height))
        return setSize(size, context)
    }
    
    @discardableResult
    func size(of view: UIView) -> PinLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.frame.size, context)
    }
    
    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> PinLayout {
        return setAspectRatio(ratio, context: { "aspectRatio(\(ratio))"})
    }
    
    @discardableResult
    func aspectRatio(of view: UIView) -> PinLayout {
        return setAspectRatio(view.frame.width / view.frame.height, context: { "aspectRatio(of: \(viewDescription(view)))"})
    }
    
    @discardableResult
    func aspectRatio() -> PinLayout {
        func context() -> String { return "aspectRatio()" }
        if let imageView = view as? UIImageView {
            if let imageSize = imageView.image?.size {
                setAspectRatio(imageSize.width / imageSize.height, context: context)
            } else {
                warnWontBeApplied("the layouted UIImageView's image hasn't been set", context)
            }
        } else {
            warnWontBeApplied("the layouted must be an UIImageView() to use the aspectRatio() method without parameter.", context)
        }
        return self
    }
    
    @discardableResult
    func sizeToFit() -> PinLayout {
        return setFitSize({ return "sizeToFit()" })
    }

    @discardableResult
    func fitSize() -> PinLayout {
        return setFitSize({ return "fitSize()" })
    }

    @discardableResult
    func justify(_ value: HorizontalAlign) -> PinLayout {
        justify = value
        return self
    }
    
    @discardableResult
    func align(_ value: VerticalAlign) -> PinLayout {
        align = value
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
    
    @discardableResult
    func marginStart(_ value: CGFloat) -> PinLayout {
        return isLTR() ? marginLeft(value) : marginRight(value)
    }
    
    @discardableResult
    func marginEnd(_ value: CGFloat) -> PinLayout {
        return isLTR() ? marginRight(value) : marginLeft(value)
    }

    @discardableResult
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
    func margin(_ insets: UIEdgeInsets) -> PinLayout {
        marginTop = insets.top
        marginBottom = insets.bottom
        marginLeft = insets.left
        marginRight = insets.right
        return self
    }
    
    /*@available(iOS 11.0, *)
    @discardableResult
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayout {
        marginTop = directionalInsets.top
        marginBottom = directionalInsets.bottom
        marginStart(directionalInsets.leading)
        marginEnd(directionalInsets.trailing)
        return self
    }*/

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
        marginTop = vertical
        marginLeft = horizontal
        marginBottom = vertical
        marginRight = horizontal
        return self
    }

    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayout {
        marginTop = top
        marginLeft = horizontal
        marginBottom = bottom
        marginRight = horizontal
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
    internal func setFitSize(_ context: Context) -> PinLayout {
        if let aspectRatio = _aspectRatio {
            warnConflict(context, ["aspectRatio": aspectRatio])
        } else {
            shouldSizeToFit = true
        }
        return self
    }
    
    @discardableResult
    internal func setAspectRatio(_ ratio: CGFloat, context: Context) -> PinLayout {
        if shouldSizeToFit {
            warnConflict(context, ["fitSize": shouldSizeToFit])
        } else if ratio <= 0 {
            warnWontBeApplied("the aspectRatio (\(ratio)) must be greater than zero.", context);
        } else {
            _aspectRatio = ratio
        }
        return self
    }
    
    internal func layoutSuperview(_ context: Context) -> UIView? {
        if let superview = view.superview {
            return superview
        } else {
            warnWontBeApplied("the view must be added as a sub-view before being layouted using this method.", context)
            return nil
        }
    }

    internal func referenceSuperview(_ referenceView: UIView, _ context: Context) -> UIView? {
        if let superview = referenceView.superview {
            return superview
        } else {
            warnWontBeApplied("the reference view \(viewDescription(referenceView)) must be added as a sub-view before being used as a reference.", context)
            return nil
        }
    }
}

// MARK - UIView's frame computation methods
extension PinLayoutImpl {
    fileprivate func apply() {
        apply(onView: view)
    }
    
    fileprivate func apply(onView view: UIView) {
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
            newRect.origin.x = _hCenter - (width / 2)
        } else if let left = _left {
            // Only left is set
            newRect.origin.x = left + _marginLeft
        } else if let right = _right {
            // Only right is set
            newRect.origin.x = right - view.frame.width - _marginRight
        } else if let _hCenter = _hCenter {
            // Only hCenter is set
            newRect.origin.x = _hCenter - (view.frame.width / 2)
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
            newRect.origin.y = _vCenter - (height / 2)
        } else if let top = _top {
            // Only top is set
            newRect.origin.y = top + _marginTop
        } else if let bottom = _bottom {
            // Only bottom is set
            newRect.origin.y = bottom - view.frame.height - _marginBottom
        } else if let _vCenter = _vCenter {
            // Only vCenter is set
            newRect.origin.y = _vCenter - (view.frame.height / 2)
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

    fileprivate func handlePinEdges() {
        guard shouldPinEdges else { return }
        guard _top == nil || _bottom == nil || _left == nil || _right == nil else {
            return warn("pinEdges() won't be applied, top, left, bottom and right coordinates are already set.")
        }
        
        if let width = applyMinMax(toWidth: width), _left == nil || _right == nil  {
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

    fileprivate func computeSize() -> Size {
        var width = computeWidth()
        var height = computeHeight()
        
        if (width != nil || height != nil) {
            if shouldSizeToFit {
                // Apply min/max width/height before calling sizeThatFits() ... and reapply them after.
                width = applyMinMax(toWidth: width)
                height = applyMinMax(toHeight: height)
                
                let fitSize = CGSize(width: width ?? .greatestFiniteMagnitude,
                                     height: height ?? .greatestFiniteMagnitude)

                let sizeThatFits = view.sizeThatFits(fitSize)
                
                if fitSize.width != .greatestFiniteMagnitude && sizeThatFits.width > fitSize.width {
                    width = fitSize.width
                } else {
                    width = sizeThatFits.width
                }

                if fitSize.height != .greatestFiniteMagnitude && sizeThatFits.height > fitSize.height {
                    height = fitSize.height
                } else {
                    height = sizeThatFits.height
                }
            } else if let aspectRatio = _aspectRatio {
                if width != nil && height != nil {
                    // warn, both are specified
                    warn("aspectRatio won't be applied, the width and the height are already defined by other PinLayout's properties.")
                } else if let width = width, let adjWidth = applyMinMax(toWidth: width) {
                    height = adjWidth / aspectRatio
                } else if let height = height, let adjHeight = applyMinMax(toHeight: height) {
                    width = adjHeight * aspectRatio
                }
            }
        } else {
            // newWidth and newHeight are nil
            if shouldSizeToFit {
                warn("fitSize() won't be applied, neither the width nor the height can be determined.")
            } else if _aspectRatio != nil {
                warn("aspectRatio won't be applied, neither the width nor the height can be determined.")
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
    
    fileprivate func computeWidth() -> CGFloat? {
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
    
    fileprivate func applyMinMax(toWidth width: CGFloat?) -> CGFloat? {
        var result = width
        
        // Handle minWidth
        if let minWidth = minWidth, minWidth > (result ?? 0) {
            result = minWidth
        }
        
        // Handle maxWidth
        if let maxWidth = maxWidth, maxWidth < (result ?? CGFloat.greatestFiniteMagnitude)  {
            result = maxWidth
        }
        
        return result
    }
    
    fileprivate func applyJustify(rect: CGRect, betweenLeft left: CGFloat, andRight right: CGFloat) -> CGRect {
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
    
    fileprivate func computeHeight() -> CGFloat? {
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
    
    fileprivate func applyMinMax(toHeight height: CGFloat?) -> CGFloat? {
        var result = height
        
        // Handle minHeight
        if let minHeight = minHeight, minHeight > (result ?? 0) {
            result = minHeight
        }
        
        // Handle maxHeight
        if let maxHeight = maxHeight, maxHeight < (result ?? CGFloat.greatestFiniteMagnitude)  {
            result = maxHeight
        }
        
        return result
    }
    
    fileprivate func applyAlign(rect: CGRect, betweenTop top: CGFloat, andBottom bottom: CGFloat) -> CGRect {
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
