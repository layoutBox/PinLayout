#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public extension PEdgeInsets {
    func minInsets(_ insets: PEdgeInsets) -> PEdgeInsets {
        return PEdgeInsets(top: minValue(self.top, minValue: insets.top),
                           left: minValue(self.left, minValue: insets.left),
                           bottom: minValue(self.bottom, minValue: insets.bottom),
                           right: minValue(self.right, minValue: insets.right))
    }

    func minInsets(dx: CGFloat, dy: CGFloat) -> PEdgeInsets {
        return PEdgeInsets(top: minValue(self.top, minValue: dy),
                           left: minValue(self.left, minValue: dx),
                           bottom: minValue(self.bottom, minValue: dy),
                           right: minValue(self.right, minValue: dx))
    }

    private func minValue(_ value: CGFloat, minValue: CGFloat) -> CGFloat {
        return value >= minValue ? value : minValue
    }
}

public func + (lhs: PEdgeInsets, rhs: Int) -> PEdgeInsets {
    let rhsf = CGFloat(rhs)
    return PEdgeInsets(top: lhs.top + rhsf,
                       left: lhs.left + rhsf,
                       bottom: lhs.bottom + rhsf,
                       right: lhs.right + rhsf)
}

public func + (lhs: PEdgeInsets, rhs: CGFloat) -> PEdgeInsets {
    return PEdgeInsets(top: lhs.top + rhs,
                       left: lhs.left + rhs,
                       bottom: lhs.bottom + rhs,
                       right: lhs.right + rhs)
}
