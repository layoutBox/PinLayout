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

    case fitSizeLegacy
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
        }
    }
}

extension PinLayout {
    public func size(_ size: CGSize) -> PinLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }

    public func size(_ sideLength: CGFloat) -> PinLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }

    public func size(_ percent: Percent) -> PinLayout {
        func context() -> String { return "size(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperviewRect.width), height: percent.of(layoutSuperviewRect.height))
        return setSize(size, context)
    }

    public func size(of view: PView) -> PinLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.getRect(keepTransform: keepTransform).size, context)
    }

    @discardableResult
    public func aspectRatio(_ ratio: CGFloat) -> PinLayout {
        return setAdjustSizeType(.aspectRatio(ratio), { "aspectRatio(\(ratio))" })
    }

    public func aspectRatio(of view: PView) -> PinLayout {
        let rect = view.getRect(keepTransform: keepTransform)
        return setAdjustSizeType(.aspectRatio(rect.width / rect.height), { "aspectRatio(of: \(viewDescription(view)))" })
    }

    #if os(iOS) || os(tvOS)
    public func aspectRatio() -> PinLayout {
        func context() -> String { return "aspectRatio()" }
        guard let imageView = view as? UIImageView else {
            warnWontBeApplied("the layouted must be an UIImageView() to use the aspectRatio() method without parameter.", context)
            return self
        }

        guard let imageSize = imageView.image?.size else {
            warnWontBeApplied("the layouted UIImageView's image hasn't been set", context)
            return self
        }

        return setAdjustSizeType(.aspectRatio(imageSize.width / imageSize.height), context)
    }
    #endif

    public func sizeToFit(_ fitType: FitType) -> PinLayout {
        return setAdjustSizeType(fitType.toAdjustSizeType(), { return "sizeToFit(\(fitType.description))" })
    }

    #if os(iOS) || os(tvOS)
    public func fitSize() -> PinLayout {
        return setAdjustSizeType(.fitSizeLegacy, { return "fitSize()" })
    }
    #endif
}

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

        if let type = type, case let AdjustSizeType.aspectRatio(ratio) = type, ratio <= 0 {
            warnWontBeApplied("the aspectRatio (\(ratio)) must be greater than zero.", context)
            return self
        }

        adjustSizeType = type

        return self
    }

    fileprivate func warnAdjustSizeConflict(context: Context) {
        guard let adjustSizeType = adjustSizeType else { return }
        let conflict: String
        switch adjustSizeType {
        case .fitTypeWidth, .fitTypeHeight, .fitTypeWidthFlexible, .fitTypeHeightFlexible:
            conflict = "sizeToFit(\(adjustSizeType.toFitType()!.description))."
        case .fitSizeLegacy:
            conflict = "fitSize()"
        case .aspectRatio(let ratio):
            conflict = "aspectRatio(\(ratio))"
        }

        warn("PinLayout Conflict: \(context()) won't be applied since it conflicts with \(conflict).")
    }
}
