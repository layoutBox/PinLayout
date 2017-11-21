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

@objc public class PinLayoutObjCImpl: NSObject, PinLayoutObjC {
    fileprivate var impl: PinLayoutImpl?
    
    init(view: UIView) {
        impl = PinLayoutImpl(view: view)
    }
    
    deinit {
        if impl != nil {
            impl?.warn("With the Objective-C interface, you must call the \"layout\" method to ensure the view is layouted correctly (ex: [[[textLabel.pin_objc top] left] layout];")
        }
    }
    
    public func layout() {
        // With objective-c PinLayoutObjCImpl instance are sometimes deallocated only after the context has been quit. For this reason
        // developpers must call the layout: method implicetely.
        impl?.layout()
        impl = nil
    }
    
    public func top() -> PinLayoutObjC {
        impl?.top()
        return self
    }
    
    public func top(_ value: CGFloat) -> PinLayoutObjC {
        impl?.top(value)
        return self
    }
    
    public func top(percent: CGFloat) -> PinLayoutObjC {
        impl?.top(percent%)
        return self
    }
    
    public func left() -> PinLayoutObjC {
        impl?.left()
        return self
    }
    
    public func left(_ value: CGFloat) -> PinLayoutObjC {
        impl?.left(value)
        return self
    }
    
    public func left(percent: CGFloat) -> PinLayoutObjC {
        impl?.left(percent%)
        return self
    }
    
    public func bottom() -> PinLayoutObjC {
        impl?.bottom()
        return self
    }
    
    public func bottom(_ value: CGFloat) -> PinLayoutObjC {
        impl?.bottom(value)
        return self
    }
    
    public func bottom(percent: CGFloat) -> PinLayoutObjC {
        impl?.bottom(percent%)
        return self
    }
    
    public func right() -> PinLayoutObjC {
        impl?.right()
        return self
    }
    
    public func right(_ value: CGFloat) -> PinLayoutObjC {
        impl?.right(value)
        return self
    }
    
    public func right(percent: CGFloat) -> PinLayoutObjC {
        impl?.right(percent%)
        return self
    }
    
    public func hCenter() -> PinLayoutObjC {
        impl?.hCenter()
        return self
    }
    
    public func hCenter(_ value: CGFloat) -> PinLayoutObjC {
        impl?.hCenter(value)
        return self
    }
    
    public func hCenter(percent: CGFloat) -> PinLayoutObjC {
        impl?.hCenter(percent%)
        return self
    }
    
    public func vCenter() -> PinLayoutObjC {
        impl?.vCenter()
        return self
    }
    
    public func vCenter(_ value: CGFloat) -> PinLayoutObjC {
        impl?.vCenter(value)
        return self
    }
    
    public func vCenter(percent: CGFloat) -> PinLayoutObjC {
        impl?.vCenter(percent%)
        return self
    }
    
    public func start() -> PinLayoutObjC {
        impl?.start()
        return self
    }
    
    public func start(_ value: CGFloat) -> PinLayoutObjC {
        impl?.start(value)
        return self
    }
    
    public func start(percent: CGFloat) -> PinLayoutObjC {
        impl?.start(percent%)
        return self
    }
    
    public func end() -> PinLayoutObjC {
        impl?.end()
        return self
    }
    
    public func end(_ value: CGFloat) -> PinLayoutObjC {
        impl?.end(value)
        return self
    }
    
    public func end(percent: CGFloat) -> PinLayoutObjC {
        impl?.end(percent%)
        return self
    }
    
    public func top(to edge: VerticalEdge) -> PinLayoutObjC {
        impl?.top(to: edge)
        return self
    }
    
    public func vCenter(to edge: VerticalEdge) -> PinLayoutObjC {
        impl?.vCenter(to: edge)
        return self
    }
    
    public func bottom(to edge: VerticalEdge) -> PinLayoutObjC {
        impl?.bottom(to: edge)
        return self
    }
    
    public func left(to edge: HorizontalEdge) -> PinLayoutObjC {
        impl?.left(to: edge)
        return self
    }
    
    public func hCenter(to edge: HorizontalEdge) -> PinLayoutObjC {
        impl?.hCenter(to: edge)
        return self
    }
    
    public func right(to edge: HorizontalEdge) -> PinLayoutObjC {
        impl?.right(to: edge)
        return self
    }
    
    public func start(to edge: HorizontalEdge) -> PinLayoutObjC {
        impl?.start(to: edge)
        return self
    }
    
    public func end(to edge: HorizontalEdge) -> PinLayoutObjC {
        impl?.end(to: edge)
        return self
    }
    
    public func all() -> PinLayoutObjC {
        impl?.all()
        return self
    }
    
    public func horizontally() -> PinLayoutObjC {
        impl?.horizontally()
        return self
    }
    
    public func vertically() -> PinLayoutObjC {
        impl?.vertically()
        return self
    }
    
    public func topLeft(to anchor: Anchor) -> PinLayoutObjC {
        impl?.topLeft(to: anchor)
        return self
    }
    
    public func topLeft() -> PinLayoutObjC {
        impl?.topLeft()
        return self
    }
    
    public func topStart(to anchor: Anchor) -> PinLayoutObjC {
        impl?.topStart(to: anchor)
        return self
    }
    
    public func topStart() -> PinLayoutObjC {
        impl?.topStart()
        return self
    }
    
    public func topCenter(to anchor: Anchor) -> PinLayoutObjC {
        impl?.topCenter(to: anchor)
        return self
    }
    
    public func topCenter() -> PinLayoutObjC {
        impl?.topCenter()
        return self
    }
    
    public func topRight(to anchor: Anchor) -> PinLayoutObjC {
        impl?.topRight(to: anchor)
        return self
    }
    
    public func topRight() -> PinLayoutObjC {
        impl?.topRight()
        return self
    }
    
    public func topEnd(to anchor: Anchor) -> PinLayoutObjC {
        impl?.topEnd(to: anchor)
        return self
    }
    
    public func topEnd() -> PinLayoutObjC {
        impl?.topEnd()
        return self
    }
    
    public func centerLeft(to anchor: Anchor) -> PinLayoutObjC {
        impl?.centerLeft(to: anchor)
        return self
    }
    
    public func centerLeft() -> PinLayoutObjC {
        impl?.centerLeft()
        return self
    }
    
    public func centerStart(to anchor: Anchor) -> PinLayoutObjC {
        impl?.centerStart(to: anchor)
        return self
    }
    
    public func centerStart() -> PinLayoutObjC {
        impl?.centerStart()
        return self
    }
    
    public func center(to anchor: Anchor) -> PinLayoutObjC {
        impl?.center(to: anchor)
        return self
    }
    
    public func center() -> PinLayoutObjC {
        impl?.center()
        return self
    }
    
    public func centerRight(to anchor: Anchor) -> PinLayoutObjC {
        impl?.centerRight(to: anchor)
        return self
    }
    
    public func centerRight() -> PinLayoutObjC {
        impl?.centerRight()
        return self
    }
    
    public func centerEnd(to anchor: Anchor) -> PinLayoutObjC {
        impl?.centerEnd(to: anchor)
        return self
    }
    
    public func centerEnd() -> PinLayoutObjC {
        impl?.centerEnd()
        return self
    }
    
    public func bottomLeft(to anchor: Anchor) -> PinLayoutObjC {
        impl?.bottomLeft(to: anchor)
        return self
    }
    
    public func bottomLeft() -> PinLayoutObjC {
        impl?.bottomLeft()
        return self
    }
    
    public func bottomStart(to anchor: Anchor) -> PinLayoutObjC {
        impl?.bottomStart(to: anchor)
        return self
    }
    
    public func bottomStart() -> PinLayoutObjC {
        impl?.bottomStart()
        return self
    }
    
    public func bottomCenter(to anchor: Anchor) -> PinLayoutObjC {
        impl?.bottomCenter(to: anchor)
        return self
    }
    
    public func bottomCenter() -> PinLayoutObjC {
        impl?.bottomCenter()
        return self
    }
    
    public func bottomRight(to anchor: Anchor) -> PinLayoutObjC {
        impl?.bottomRight(to: anchor)
        return self
    }
    
    public func bottomRight() -> PinLayoutObjC {
        impl?.bottomRight()
        return self
    }
    
    public func bottomEnd(to anchor: Anchor) -> PinLayoutObjC {
        impl?.bottomEnd(to: anchor)
        return self
    }
    
    public func bottomEnd() -> PinLayoutObjC {
        impl?.bottomEnd()
        return self
    }
    
    public func above(of view: UIView) -> PinLayoutObjC {
        impl?.above(of: view)
        return self
    }
    
    public func above(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.above(of: views)
        return self
    }
    
    public func above(of view: UIView, aligned: HorizontalAlign) -> PinLayoutObjC {
        impl?.above(of: view, aligned: aligned)
        return self
    }
    
    public func above(ofViews views: [UIView], aligned: HorizontalAlign) -> PinLayoutObjC {
        impl?.above(of: views, aligned: aligned)
        return self
    }
    
    public func below(of view: UIView) -> PinLayoutObjC {
        impl?.below(of: view)
        return self
    }
    
    public func below(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.below(of: views)
        return self
    }
    
    public func below(of view: UIView, aligned: HorizontalAlign) -> PinLayoutObjC {
        impl?.below(of: view, aligned: aligned)
        return self
    }
    
    public func below(ofViews views: [UIView], aligned: HorizontalAlign) -> PinLayoutObjC {
        impl?.below(of: views, aligned: aligned)
        return self
    }
    
    public func left(of view: UIView) -> PinLayoutObjC {
        impl?.left(of: view)
        return self
    }
    
    public func left(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.left(of: views)
        return self
    }
    
    public func left(of view: UIView, aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.left(of: view, aligned: aligned)
        return self
    }
    
    public func left(ofViews views: [UIView], aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.left(of: views, aligned: aligned)
        return self
    }
    
    public func right(of view: UIView) -> PinLayoutObjC {
        impl?.right(of: view)
        return self
    }
    
    public func right(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.right(of: views)
        return self
    }
    
    public func right(of view: UIView, aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.right(of: view, aligned: aligned)
        return self
    }
    
    public func right(ofViews views: [UIView], aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.right(of: views, aligned: aligned)
        return self
    }
    
    public func before(of view: UIView) -> PinLayoutObjC {
        impl?.before(of: view)
        return self
    }
    
    public func before(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.before(of: views)
        return self
    }
    
    public func before(of view: UIView, aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.before(of: view, aligned: aligned)
        return self
    }
    
    public func before(ofViews views: [UIView], aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.before(of: views, aligned: aligned)
        return self
    }
    
    public func after(of view: UIView) -> PinLayoutObjC {
        impl?.after(of: view)
        return self
    }
    
    public func after(ofViews views: [UIView]) -> PinLayoutObjC {
        impl?.after(of: views)
        return self
    }
    
    public func after(of view: UIView, aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.after(of: view, aligned: aligned)
        return self
    }
    
    public func after(ofViews views: [UIView], aligned: VerticalAlign) -> PinLayoutObjC {
        impl?.after(of: views, aligned: aligned)
        return self
    }
    
    public func justify(_ align: HorizontalAlign) -> PinLayoutObjC {
        impl?.justify(align)
        return self
    }
    
    public func align(_ align: VerticalAlign) -> PinLayoutObjC {
        impl?.align(align)
        return self
    }
    
    public func width(_ width: CGFloat) -> PinLayoutObjC {
        impl?.width(width)
        return self
    }
    
    public func width(percent: CGFloat) -> PinLayoutObjC {
        impl?.width(percent%)
        return self
    }
    
    public func width(of view: UIView) -> PinLayoutObjC {
        impl?.width(of: view)
        return self
    }
    
    public func minWidth(_ width: CGFloat) -> PinLayoutObjC {
        impl?.minWidth(width)
        return self
    }
    
    public func minWidth(percent: CGFloat) -> PinLayoutObjC {
        impl?.minWidth(percent%)
        return self
    }
    
    public func maxWidth(_ width: CGFloat) -> PinLayoutObjC {
        impl?.maxWidth(width)
        return self
    }
    
    public func maxWidth(percent: CGFloat) -> PinLayoutObjC {
        impl?.maxWidth(percent%)
        return self
    }
    
    public func height(_ height: CGFloat) -> PinLayoutObjC {
        impl?.height(height)
        return self
    }
    
    public func height(percent: CGFloat) -> PinLayoutObjC {
        impl?.height(percent%)
        return self
    }
    
    public func height(of view: UIView) -> PinLayoutObjC {
        impl?.height(of: view)
        return self
    }
    
    public func minHeight(_ height: CGFloat) -> PinLayoutObjC {
        impl?.minHeight(height)
        return self
    }
    
    public func minHeight(percent: CGFloat) -> PinLayoutObjC {
        impl?.minHeight(percent%)
        return self
    }
    
    public func maxHeight(_ height: CGFloat) -> PinLayoutObjC {
        impl?.maxHeight(height)
        return self
    }
    
    public func maxHeight(percent: CGFloat) -> PinLayoutObjC {
        impl?.maxHeight(percent%)
        return self
    }
    
    public func size(_ size: CGSize) -> PinLayoutObjC {
        impl?.size(size)
        return self
    }
    
    public func size(length: CGFloat) -> PinLayoutObjC {
        impl?.size(length)
        return self
    }
    
    public func size(percent: CGFloat) -> PinLayoutObjC {
        impl?.size(percent%)
        return self
    }
    
    public func size(of view: UIView) -> PinLayoutObjC {
        impl?.size(of: view)
        return self
    }
    
    public func aspectRatio(_ ratio: CGFloat) -> PinLayoutObjC {
        impl?.aspectRatio(ratio)
        return self
    }
    
    public func aspectRatio(of view: UIView) -> PinLayoutObjC {
        impl?.aspectRatio(of: view)
        return self
    }
    
    public func aspectRatio() -> PinLayoutObjC {
        impl?.aspectRatio()
        return self
    }
    
    public func fitSize() -> PinLayoutObjC {
        impl?.fitSize()
        return self
    }
    
    public func sizeToFit(_ fitType: Fit) -> PinLayoutObjC {
        let type: FitType
        switch fitType {
        case .width: type = .width
        case .height: type = .height
        case .widthFlexible: type = .widthFlexible
        case .heightFlexible: type = .heightFlexible
        }
        impl?.sizeToFit(type)
        return self
    }
    
    public func marginTop(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginTop(value)
        return self
    }
    
    public func marginLeft(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginLeft(value)
        return self
    }
    
    public func marginBottom(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginBottom(value)
        return self
    }
    
    public func marginRight(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginRight(value)
        return self
    }
    
    public func marginStart(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginStart(value)
        return self
    }
    
    public func marginEnd(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginEnd(value)
        return self
    }
    
    public func marginHorizontal(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginHorizontal(value)
        return self
    }
    
    public func marginVertical(_ value: CGFloat) -> PinLayoutObjC {
        impl?.marginVertical(value)
        return self
    }
    
    public func margin(insets: UIEdgeInsets) -> PinLayoutObjC {
        impl?.margin(insets)
        return self
    }
    
    public func margin(_ value: CGFloat) -> PinLayoutObjC {
        impl?.margin(value)
        return self
    }
    
    public func margin(vertical: CGFloat, horizontal: CGFloat) -> PinLayoutObjC {
        impl?.margin(vertical, horizontal)
        return self
    }
    
    public func margin(top: CGFloat, horizontal: CGFloat, bottom: CGFloat) -> PinLayoutObjC {
        impl?.margin(top, horizontal, bottom)
        return self
    }
    
    public func margin(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> PinLayoutObjC {
        impl?.margin(top, left, bottom, right)
        return self
    }
    
    public func pinEdges() -> PinLayoutObjC {
        impl?.pinEdges()
        return self
    }
}

#endif
