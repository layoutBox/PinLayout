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

    func layout() {
        // With objective-c PinLayoutObjCImpl instance are sometimes deallocated only after the context has been quit. For this reason
        // developpers must call the layout: method implicetely.
        impl?.layout()
        impl = nil
    }

    func top() -> PinLayoutObjC {
        _ = impl?.top()
        return self
    }
    
    func top(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.top(value)
        return self
    }
    
    func top(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.top(percent%)
        return self
    }

    func top(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.top(insets)
        return self
    }
    
    func left() -> PinLayoutObjC {
        _ = impl?.left()
        return self
    }
    
    func left(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.left(value)
        return self
    }
    
    func left(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.left(percent%)
        return self
    }

    func left(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.left(insets)
        return self
    }
    
    func bottom() -> PinLayoutObjC {
        _ = impl?.bottom()
        return self
    }
    
    func bottom(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.bottom(value)
        return self
    }
    
    func bottom(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.bottom(percent%)
        return self
    }

    func bottom(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.bottom(insets)
        return self
    }
    
    func right() -> PinLayoutObjC {
        _ = impl?.right()
        return self
    }
    
    func right(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.right(value)
        return self
    }
    
    func right(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.right(percent%)
        return self
    }

    func right(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.right(insets)
        return self
    }
    
    func hCenter() -> PinLayoutObjC {
        _ = impl?.hCenter()
        return self
    }
    
    func hCenter(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.hCenter(value)
        return self
    }
    
    func hCenter(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.hCenter(percent%)
        return self
    }
    
    func vCenter() -> PinLayoutObjC {
        _ = impl?.vCenter()
        return self
    }
    
    func vCenter(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.vCenter(value)
        return self
    }
    
    func vCenter(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.vCenter(percent%)
        return self
    }
    
    func start() -> PinLayoutObjC {
        _ = impl?.start()
        return self
    }
    
    func start(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.start(value)
        return self
    }
    
    func start(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.start(percent%)
        return self
    }

    func start(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.start(insets)
        return self
    }
    
    func end() -> PinLayoutObjC {
        _ = impl?.end()
        return self
    }
    
    func end(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.end(value)
        return self
    }
    
    func end(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.end(percent%)
        return self
    }

    func end(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.end(insets)
        return self
    }
    
    func top(to edge: VerticalEdge) -> PinLayoutObjC {
        _ = impl?.top(to: edge)
        return self
    }
    
    func vCenter(to edge: VerticalEdge) -> PinLayoutObjC {
        _ = impl?.vCenter(to: edge)
        return self
    }
    
    func bottom(to edge: VerticalEdge) -> PinLayoutObjC {
        _ = impl?.bottom(to: edge)
        return self
    }
    
    func left(to edge: HorizontalEdge) -> PinLayoutObjC {
        _ = impl?.left(to: edge)
        return self
    }
    
    func hCenter(to edge: HorizontalEdge) -> PinLayoutObjC {
        _ = impl?.hCenter(to: edge)
        return self
    }
    
    func right(to edge: HorizontalEdge) -> PinLayoutObjC {
        _ = impl?.right(to: edge)
        return self
    }
    
    func start(to edge: HorizontalEdge) -> PinLayoutObjC {
        _ = impl?.start(to: edge)
        return self
    }
    
    func end(to edge: HorizontalEdge) -> PinLayoutObjC {
        _ = impl?.end(to: edge)
        return self
    }
    
    func all() -> PinLayoutObjC {
        _ = impl?.all()
        return self
    }
    
    func horizontally() -> PinLayoutObjC {
        _ = impl?.horizontally()
        return self
    }

    func horizontally(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.horizontally(value)
        return self
    }
    
    func vertically() -> PinLayoutObjC {
        _ = impl?.vertically()
        return self
    }

    func vertically(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.vertically(value)
        return self
    }
    
    func topLeft(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.topLeft(to: anchor)
        return self
    }
    
    func topLeft() -> PinLayoutObjC {
        _ = impl?.topLeft()
        return self
    }
    
    func topStart(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.topStart(to: anchor)
        return self
    }
    
    func topStart() -> PinLayoutObjC {
        _ = impl?.topStart()
        return self
    }
    
    func topCenter(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.topCenter(to: anchor)
        return self
    }
    
    func topCenter() -> PinLayoutObjC {
        _ = impl?.topCenter()
        return self
    }
    
    func topRight(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.topRight(to: anchor)
        return self
    }
    
    func topRight() -> PinLayoutObjC {
        _ = impl?.topRight()
        return self
    }
    
    func topEnd(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.topEnd(to: anchor)
        return self
    }
    
    func topEnd() -> PinLayoutObjC {
        _ = impl?.topEnd()
        return self
    }
    
    func centerLeft(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.centerLeft(to: anchor)
        return self
    }
    
    func centerLeft() -> PinLayoutObjC {
        _ = impl?.centerLeft()
        return self
    }
    
    func centerStart(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.centerStart(to: anchor)
        return self
    }
    
    func centerStart() -> PinLayoutObjC {
        _ = impl?.centerStart()
        return self
    }
    
    func center(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.center(to: anchor)
        return self
    }
    
    func center() -> PinLayoutObjC {
        _ = impl?.center()
        return self
    }
    
    func centerRight(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.centerRight(to: anchor)
        return self
    }
    
    func centerRight() -> PinLayoutObjC {
        _ = impl?.centerRight()
        return self
    }
    
    func centerEnd(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.centerEnd(to: anchor)
        return self
    }
    
    func centerEnd() -> PinLayoutObjC {
        _ = impl?.centerEnd()
        return self
    }
    
    func bottomLeft(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.bottomLeft(to: anchor)
        return self
    }
    
    func bottomLeft() -> PinLayoutObjC {
        _ = impl?.bottomLeft()
        return self
    }
    
    func bottomStart(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.bottomStart(to: anchor)
        return self
    }
    
    func bottomStart() -> PinLayoutObjC {
        _ = impl?.bottomStart()
        return self
    }
    
    func bottomCenter(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.bottomCenter(to: anchor)
        return self
    }
    
    func bottomCenter() -> PinLayoutObjC {
        _ = impl?.bottomCenter()
        return self
    }
    
    func bottomRight(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.bottomRight(to: anchor)
        return self
    }
    
    func bottomRight() -> PinLayoutObjC {
        _ = impl?.bottomRight()
        return self
    }
    
    func bottomEnd(to anchor: Anchor) -> PinLayoutObjC {
        _ = impl?.bottomEnd(to: anchor)
        return self
    }
    
    func bottomEnd() -> PinLayoutObjC {
        _ = impl?.bottomEnd()
        return self
    }
    
    func above(of view: PView) -> PinLayoutObjC {
        _ = impl?.above(of: view)
        return self
    }
    
    func above(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.above(of: views)
        return self
    }
    
    func above(of view: PView, aligned: HorizontalAlign) -> PinLayoutObjC {
        _ = impl?.above(of: view, aligned: aligned)
        return self
    }
    
    func above(ofViews views: [PView], aligned: HorizontalAlign) -> PinLayoutObjC {
        _ = impl?.above(of: views, aligned: aligned)
        return self
    }
    
    func below(of view: PView) -> PinLayoutObjC {
        _ = impl?.below(of: view)
        return self
    }
    
    func below(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.below(of: views)
        return self
    }
    
    func below(of view: PView, aligned: HorizontalAlign) -> PinLayoutObjC {
        _ = impl?.below(of: view, aligned: aligned)
        return self
    }
    
    func below(ofViews views: [PView], aligned: HorizontalAlign) -> PinLayoutObjC {
        _ = impl?.below(of: views, aligned: aligned)
        return self
    }
    
    func left(of view: PView) -> PinLayoutObjC {
        _ = impl?.left(of: view)
        return self
    }
    
    func left(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.left(of: views)
        return self
    }
    
    func left(of view: PView, aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.left(of: view, aligned: aligned)
        return self
    }
    
    func left(ofViews views: [PView], aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.left(of: views, aligned: aligned)
        return self
    }
    
    func right(of view: PView) -> PinLayoutObjC {
        _ = impl?.right(of: view)
        return self
    }
    
    func right(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.right(of: views)
        return self
    }
    
    func right(of view: PView, aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.right(of: view, aligned: aligned)
        return self
    }
    
    func right(ofViews views: [PView], aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.right(of: views, aligned: aligned)
        return self
    }
    
    func before(of view: PView) -> PinLayoutObjC {
        _ = impl?.before(of: view)
        return self
    }
    
    func before(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.before(of: views)
        return self
    }
    
    func before(of view: PView, aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.before(of: view, aligned: aligned)
        return self
    }
    
    func before(ofViews views: [PView], aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.before(of: views, aligned: aligned)
        return self
    }
    
    func after(of view: PView) -> PinLayoutObjC {
        _ = impl?.after(of: view)
        return self
    }
    
    func after(ofViews views: [PView]) -> PinLayoutObjC {
        _ = impl?.after(of: views)
        return self
    }
    
    func after(of view: PView, aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.after(of: view, aligned: aligned)
        return self
    }
    
    func after(ofViews views: [PView], aligned: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.after(of: views, aligned: aligned)
        return self
    }
    
    func justify(_ align: HorizontalAlign) -> PinLayoutObjC {
        _ = impl?.justify(align)
        return self
    }
    
    func align(_ align: VerticalAlign) -> PinLayoutObjC {
        _ = impl?.align(align)
        return self
    }
    
    func width(_ width: CGFloat) -> PinLayoutObjC {
        _ = impl?.width(width)
        return self
    }
    
    func width(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.width(percent%)
        return self
    }
    
    func width(of view: PView) -> PinLayoutObjC {
        _ = impl?.width(of: view)
        return self
    }
    
    func minWidth(_ width: CGFloat) -> PinLayoutObjC {
        _ = impl?.minWidth(width)
        return self
    }
    
    func minWidth(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.minWidth(percent%)
        return self
    }
    
    func maxWidth(_ width: CGFloat) -> PinLayoutObjC {
        _ = impl?.maxWidth(width)
        return self
    }
    
    func maxWidth(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.maxWidth(percent%)
        return self
    }
    
    func height(_ height: CGFloat) -> PinLayoutObjC {
        _ = impl?.height(height)
        return self
    }
    
    func height(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.height(percent%)
        return self
    }
    
    func height(of view: PView) -> PinLayoutObjC {
        _ = impl?.height(of: view)
        return self
    }
    
    func minHeight(_ height: CGFloat) -> PinLayoutObjC {
        _ = impl?.minHeight(height)
        return self
    }
    
    func minHeight(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.minHeight(percent%)
        return self
    }
    
    func maxHeight(_ height: CGFloat) -> PinLayoutObjC {
        _ = impl?.maxHeight(height)
        return self
    }
    
    func maxHeight(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.maxHeight(percent%)
        return self
    }
    
    func size(_ size: CGSize) -> PinLayoutObjC {
        _ = impl?.size(size)
        return self
    }
    
    func size(length: CGFloat) -> PinLayoutObjC {
        _ = impl?.size(length)
        return self
    }
    
    func size(percent: CGFloat) -> PinLayoutObjC {
        _ = impl?.size(percent%)
        return self
    }
    
    func size(of view: PView) -> PinLayoutObjC {
        _ = impl?.size(of: view)
        return self
    }
    
    func wrapContent() -> PinLayoutObjC {
        _ = impl?.wrapContent()
        return self
    }
    
    func wrapContent(padding: CGFloat) -> PinLayoutObjC {
        _ = impl?.wrapContent(padding: padding)
        return self
    }
    
    func wrapContent(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.wrapContent(padding: insets)
        return self
    }
    
    func wrapContent(type: WrapType) -> PinLayoutObjC {
        _ = impl?.wrapContent(type)
        return self
    }
    
    func wrapContent(type: WrapType, padding: CGFloat) -> PinLayoutObjC {
        _ = impl?.wrapContent(type, padding: padding)
        return self
    }
    
    func wrapContent(type: WrapType, insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.wrapContent(type, padding: insets)
        return self
    }
    
    func aspectRatio(_ ratio: CGFloat) -> PinLayoutObjC {
        _ = impl?.aspectRatio(ratio)
        return self
    }
    
    func aspectRatio(of view: PView) -> PinLayoutObjC {
        _ = impl?.aspectRatio(of: view)
        return self
    }

    #if os(iOS) || os(tvOS)
    func aspectRatio() -> PinLayoutObjC {
        _ = impl?.aspectRatio()
        return self
    }
    #endif

    func sizeToFit() -> PinLayoutObjC {
        return sizeToFit(.content)
    }

    func sizeToFit(_ fitType: Fit) -> PinLayoutObjC {
        let type: FitType
        switch fitType {
        case .width: type = .width
        case .height: type = .height
        case .widthFlexible: type = .widthFlexible
        case .heightFlexible: type = .heightFlexible
        case .content: type = .content
        }
        _ = impl?.sizeToFit(type)
        return self
    }
    
    func marginTop(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginTop(value)
        return self
    }
    
    func marginLeft(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginLeft(value)
        return self
    }
    
    func marginBottom(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginBottom(value)
        return self
    }
    
    func marginRight(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginRight(value)
        return self
    }
    
    func marginStart(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginStart(value)
        return self
    }
    
    func marginEnd(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginEnd(value)
        return self
    }
    
    func marginHorizontal(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginHorizontal(value)
        return self
    }
    
    func marginVertical(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.marginVertical(value)
        return self
    }
    
    func margin(insets: PEdgeInsets) -> PinLayoutObjC {
        _ = impl?.margin(insets)
        return self
    }
    
    func margin(_ value: CGFloat) -> PinLayoutObjC {
        _ = impl?.margin(value)
        return self
    }
    
    func margin(vertical: CGFloat, horizontal: CGFloat) -> PinLayoutObjC {
        _ = impl?.margin(vertical, horizontal)
        return self
    }
    
    func margin(top: CGFloat, horizontal: CGFloat, bottom: CGFloat) -> PinLayoutObjC {
        _ = impl?.margin(top, horizontal, bottom)
        return self
    }
    
    func margin(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> PinLayoutObjC {
        _ = impl?.margin(top, left, bottom, right)
        return self
    }
    
    func pinEdges() -> PinLayoutObjC {
        _ = impl?.pinEdges()
        return self
    }
}
