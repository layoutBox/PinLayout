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

enum AdjustSizeType {
    case fitTypeWidth
    case fitTypeHeight
    case fitTypeWidthFlexible
    case fitTypeHeightFlexible
    case fitTypeContent

    case aspectRatio(CGFloat)

    var isFlexible: Bool {
        if case .fitTypeWidthFlexible = self {
            return true
        } else if case .fitTypeHeightFlexible = self {
            return true
        } else {
            return false
        }
    }

    internal var requiresSizeCalculable: Bool {
        switch self {
        case .fitTypeWidth, .fitTypeHeight,
             .fitTypeWidthFlexible, .fitTypeHeightFlexible,
             .fitTypeContent:
            return true
        case .aspectRatio(_):
            return false
        }
    }

    func toFitType() -> FitType? {
        switch self {
        case .fitTypeWidth: return .width
        case .fitTypeHeight: return .height
        case .fitTypeWidthFlexible: return .widthFlexible
        case .fitTypeHeightFlexible: return .heightFlexible
        default: return nil
        }
    }
}

extension FitType {
    func toAdjustSizeType() -> AdjustSizeType {
        switch self {
        case .width: return .fitTypeWidth
        case .height: return .fitTypeHeight
        case .widthFlexible: return .fitTypeWidthFlexible
        case .heightFlexible: return .fitTypeHeightFlexible
        case .content: return .fitTypeContent
        }
    }
}

extension PinLayout {
    @discardableResult
    public func size(_ size: CGSize) -> PinLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }

    @discardableResult
    public func size(_ sideLength: CGFloat) -> PinLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }

    @discardableResult
    public func size(_ percent: Percent) -> PinLayout {
        func context() -> String { return "size(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperviewRect.width), height: percent.of(layoutSuperviewRect.height))
        return setSize(size, context)
    }

    @discardableResult
    public func size(of view: View) -> PinLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.getRect(keepTransform: keepTransform).size, context)
    }

    /**
     Set the view aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * An aspect ratio of 2 means the width is twice the size of the height.
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    @discardableResult
    public func aspectRatio(_ ratio: CGFloat) -> PinLayout {
        return setAdjustSizeType(.aspectRatio(ratio), { "aspectRatio(\(ratio))" })
    }

    /**
     Set the view aspect ratio using another UIView's aspect ratio.

     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    @discardableResult
    public func aspectRatio(of view: View) -> PinLayout {
        let rect = view.getRect(keepTransform: keepTransform)
        return setAdjustSizeType(.aspectRatio(rect.width / rect.height), { "aspectRatio(of: \(viewDescription(view)))" })
    }

    /**
     If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.

     For other types of views, this method as no impact.
     */
    #if os(iOS) || os(tvOS)
    @discardableResult
    public func aspectRatio() -> PinLayout {
        func context() -> String { return "aspectRatio()" }
        guard let imageView = view as? UIImageView else {
            warnWontBeApplied("the layouted view must be an UIImageView() to use the aspectRatio() method without parameter.", context)
            return self
        }

        guard let imageSize = imageView.image?.size else {
            guard Pin.logWarnings && Pin.activeWarnings.aspectRatioImageNotSet else { return self }
            warnWontBeApplied("the layouted UIImageView's image hasn't been set (aspectRatioImageNotSet)", context)
            return self
        }

        return setAdjustSizeType(.aspectRatio(imageSize.width / imageSize.height), context)
    }
    #endif

    /**
     The method adjust the view's size based on the view's `sizeThatFits()` method result.
     PinLayout will adjust either the view's width or height based on the `fitType` parameter value.

     Notes:
     * If margin rules apply, margins will be applied when determining the reference dimension (width/height).
     * The resulting size will always respect `minWidth` / `maxWidth` / `minHeight` / `maxHeight`.

     - Parameter fitType: Identify the reference dimension (width / height) that will be used
     to adjust the view's size:

     .width: The method adjust the view's size based on the **reference width**.
     * If properties related to the width have been pinned (e.g: width, left & right, margins, ...),
     the **reference width will be determined by these properties**, if not the **current view's width**
     will be used.
     * The resulting width will always **match the reference width**.

     .height: The method adjust the view's size based on the **reference height**.
     * If properties related to the height have been pinned (e.g: height, top & bottom, margins, ...),
     the **reference height will be determined by these properties**, if not the **current view's height**
     will be used.
     * The resulting height will always **match the reference height**.

     .widthFlexible: Similar to `.width`, except that PinLayout won't constrain the resulting width to
     match the reference width. The resulting width may be smaller or bigger depending on the view's
     sizeThatFits(..) method result. For example a single line UILabel may returns a smaller width if its
     string is smaller than the reference width.

     .heightFlexible: Similar to `.height`, except that PinLayout won't constrain the resulting height to
     match the reference height. The resulting height may be smaller or bigger depending on the view's
     sizeThatFits(..) method result.

     Examples:

     ```
     // Adjust the view's size based on a width of 100 pixels.
     // The resulting width will always match the pinned property `width(100)`.
     view.pin.width(100).sizeToFit(.width)

     // Adjust the view's size based on view's current width.
     // The resulting width will always match the view's original width.
     // The resulting height will never be bigger than the specified `maxHeight`.
     view.pin.sizeToFit(.width).maxHeight(100)

     // Adjust the view's size based on 100% of the superview's height.
     // The resulting height will always match the pinned property `height(100%)`.
     view.pin.height(100%).sizeToFit(.height)

     // Adjust the view's size based on view's current height.
     // The resulting width will always match the view's original height.
     view.pin.sizeToFit(.height)

     // Since `.widthFlexible` has been specified, its possible that the resulting
     // width will be smaller or bigger than 100 pixels, based of the label's sizeThatFits()
     // method result.
     label.pin.width(100).sizeToFit(.widthFlexible)
     ```
     */
    @discardableResult
    public func sizeToFit(_ fitType: FitType = .content) -> PinLayout {
        return setAdjustSizeType(fitType.toAdjustSizeType(), { return "sizeToFit(\(fitType.description))" })
    }}

//
// MARK: Private methods
extension PinLayout {
    internal func setSize(_ size: CGSize, _ context: Context) -> PinLayout {
        setWidth(size.width, { return "\(context())'s width" })
        setHeight(size.height, { return "\(context())'s height" })
        return self
    }

    internal func setAdjustSizeType(_ type: AdjustSizeType?, _ context: Context) -> PinLayout {
        guard adjustSizeType == nil else {
            warnAdjustSizeConflict(context: context)
            return self
        }

        if let type = type {
            if case let AdjustSizeType.aspectRatio(ratio) = type, ratio <= 0 {
                warnWontBeApplied("the aspectRatio (\(ratio)) must be greater than zero.", context)
                return self
            } else if type.requiresSizeCalculable, !(view is SizeCalculable) {
                warnWontBeApplied("PinLayout cannot comptute this view's size. This type of views doesn't conform to the protocol SizeCalculable.", context)
                return self
            }
        }

        adjustSizeType = type

        return self
    }

    private func warnAdjustSizeConflict(context: Context) {
        guard let adjustSizeType = adjustSizeType else { return }
        let conflict: String
        switch adjustSizeType {
        case .fitTypeWidth, .fitTypeHeight, .fitTypeWidthFlexible, .fitTypeHeightFlexible, .fitTypeContent:
            conflict = "sizeToFit(\(adjustSizeType.toFitType()!.description))."
        case .aspectRatio(let ratio):
            conflict = "aspectRatio(\(ratio))"
        }

        warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with \(conflict).")
    }
}
