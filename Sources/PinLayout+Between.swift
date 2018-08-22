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
    
extension PinLayout {

    //
    // betweenH(of ...)
    //
    @discardableResult
    public func betweenH(_ view1: View, and view2: View, aligned: VerticalAlign = .none) -> PinLayout {
        func context() -> String { return betweenContext("betweenH", view1, view2, aligned) }
        guard self.view != view1 && self.view != view2 else {
            warnWontBeApplied("the view being layouted cannot be used as one of the references.", context)
            return self
        }

        guard view1 != view2 else {
            warnWontBeApplied("reference views must be different.", context)
            return self
        }

        /// TODO!
//        let view1Rect = view1.getRect(keepTransform: keepTransform)
//        let view2Rect = view2.getRect(keepTransform: keepTransform)
        let anchors = [view1.anchor.topLeft, view1.anchor.topRight, view2.anchor.topLeft, view2.anchor.topRight]

        if let coordinates = computeCoordinates(forAnchors: anchors, context) {
            //coordinates.count == anchors.count {
            let view1MinX = coordinates[0].x
            let view1MaxX = coordinates[1].x
            let view2MinX = coordinates[2].x
            let view2MaxX = coordinates[3].x
            //setLeft(getRightMostCoordinate(list: coordinates), context)
            //applyVerticalAlignment(aligned, coordinates: coordinates, context: context)

            if view1MaxX <= view2MinX {
                setLeft(view1MaxX, context)
                setRight(view2MinX, context)
//                right(of: [view1], aligned: aligned, context: context)
//                left(of: [view2], aligned: .none, context: context)
            } else if view2MaxX <= view1MinX {
                setLeft(view2MaxX, context)
                setRight(view1MinX, context)
//                right(of: [view2], aligned: .none, context: context)
//                left(of: [view1], aligned: aligned, context: context)
            } /*else if view1 == (view.superview as? View) {
                setLeft(view1MinX, context)
                setRight(view2MinX, context)
            } else if view2 == (view.superview as? View) {
                setLeft(view1MaxX, context)
                setRight(view2MaxX, context)
            }*/ else {
//                setLeft(view1MaxX, context)
//                setRight(view1MaxX, context)
                warnWontBeApplied("there is no horizontal space between these views.", context)
                // warning, not valid, would produce a view with a size smaller than 0.
            }
        } else {
            // TODO
            warnWontBeApplied("TODO.", context)
            return self
        }


//        if view1Rect.maxX <= view2Rect.minX {
//            right(of: [view1], aligned: aligned, context: context)
//            left(of: [view2], aligned: .none, context: context)
//        } else if view2Rect.maxX <= view1Rect.minX {
//            right(of: [view2], aligned: .none, context: context)
//            left(of: [view1], aligned: aligned, context: context)
//        } else if view1 == (view.superview as? View) {
//
//        } else if view2 == (view.superview as? View) {
//
//        } else {
//            warnWontBeApplied("there is no horizontal space between these views.", context)
//            // warning, not valid, would produce a view with a size smaller than 0.
//        }

        return self
    }
}

// MARK: private
extension PinLayout {
    private func betweenContext(_ type: String, _ view1: View, _ view2: View, _ aligned: HorizontalAlign) -> String {
        return betweenContext(type, view1, view2, aligned: aligned == HorizontalAlign.none ? nil : aligned.description)
    }

    private func betweenContext(_ type: String, _ view1: View, _ view2: View, _ aligned: VerticalAlign) -> String {
        return betweenContext(type, view1, view2, aligned: aligned == VerticalAlign.none ? nil : aligned.description)
    }

    private func betweenContext(_ type: String, _ view1: View, _ view2: View, aligned: String?) -> String {
        if let aligned = aligned {
            return "\(type)(\(viewDescription(view1)), \(viewDescription(view1)), aligned: .\(aligned))"
        } else {
            return "\(type)(\(viewDescription(view1)), \(viewDescription(view1)))"
        }
    }
}
