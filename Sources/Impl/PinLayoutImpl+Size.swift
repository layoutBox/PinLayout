//
//  PinLayoutImpl+Size.swift
//  PinLayout-iOS
//
//  Created by Luc Dion on 2018-06-06.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

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

extension PinLayoutImpl {
    func size(_ size: CGSize) -> PinLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }

    func size(_ sideLength: CGFloat) -> PinLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }

    func size(_ percent: Percent) -> PinLayout {
        func context() -> String { return "size(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperviewRect.width), height: percent.of(layoutSuperviewRect.height))
        return setSize(size, context)
    }

    func size(of view: PView) -> PinLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.bounds.size, context)
    }

    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> PinLayout {
        return setAdjustSizeType(.aspectRatio(ratio), { "aspectRatio(\(ratio))" })
    }

    func aspectRatio(of view: PView) -> PinLayout {
        return setAdjustSizeType(.aspectRatio(view.bounds.width / view.bounds.height), { "aspectRatio(of: \(viewDescription(view)))" })
    }

    #if os(iOS) || os(tvOS)
    func aspectRatio() -> PinLayout {
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

    func sizeToFit(_ fitType: FitType) -> PinLayout {
        return setAdjustSizeType(fitType.toAdjustSizeType(), { return "sizeToFit(\(fitType.description))" })
    }

    #if os(iOS) || os(tvOS)
    func fitSize() -> PinLayout {
        return setAdjustSizeType(.fitSizeLegacy, { return "fitSize()" })
    }
    #endif
}

//
// MARK: Private methods
extension PinLayoutImpl {
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
