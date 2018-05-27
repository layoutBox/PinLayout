//  Copyright (c) 2018 Luc Dion
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

extension PinLayoutImpl {
    func wrapContent() -> PinLayout {
        return wrapContent(.all, padding: .zero, { return "wrapContent()" })
    }

    func wrapContent(_ type: WrapType) -> PinLayout {
        return wrapContent(type, padding: .zero, { return "wrapContent(\(type.description)" })
    }

    @discardableResult
    private func wrapContent(_ type: WrapType, padding: PPadding, _ context: Context) -> PinLayout {
        let subviews = view.subviews
        guard !subviews.isEmpty else { return self }
        let firstViewFrame = subviews[0].frame
        var minX = firstViewFrame.minX
        var maxX = firstViewFrame.maxX
        var minY = firstViewFrame.minY
        var maxY = firstViewFrame.maxY

        for var i in 1..<subviews.count {
            let frame = subviews[i].frame
            if frame.minX < minX {
                minX = frame.minX
            }
            if frame.maxX > maxX {
                maxX = frame.maxX
            }
            if frame.minY < minY {
                minY = frame.minY
            }
            if frame.maxY > maxY {
                maxY = frame.maxY
            }
        }

        var offsetDx: CGFloat = 0
        var offsetDy: CGFloat = 0

        if type == .all || type == .width {
            let contentWidth = maxX - minX
            if contentWidth >= 0 {
                setWidth(contentWidth, context)
            }

            offsetDx = -minX
//            let contentWidth = view.subviews.max(by: { subview1, subview2 in
//                subview1.frame.maxX < subview2.frame.maxX
//            })?.frame.maxX ?? 0
        }

        if type == .all || type == .height {
            let contentHeight = maxY - minY
            if contentHeight >= 0 {
                setHeight(contentHeight, context)
            }

            offsetDy = -minY
//            let contentHeight = view.subviews.max(by: { subview1, subview2 in
//                subview1.frame.maxY < subview2.frame.maxY
//            })?.frame.maxY ?? 0
        }

        if offsetDx != 0 || offsetDy != 0 {
            subviews.forEach { (view) in
                let viewRect = Coordinates.getViewRect(view, keepTransform: keepTransform)
                let newRect = viewRect.offsetBy(dx: offsetDx, dy: offsetDy)
                Coordinates.setViewRect(view, toRect: newRect, keepTransform: keepTransform)
            }
        }

        return self
    }
}
