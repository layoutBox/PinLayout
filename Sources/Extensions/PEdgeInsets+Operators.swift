
public extension PEdgeInsets {
    public func inset(_ value: CGFloat) -> PEdgeInsets {
        return UIEdgeInsets(top: self.top + value,
                            left: self.left + value,
                            bottom: self.bottom + value,
                            right: self.right + value)
    }

    func insetBy(dx: CGFloat, dy: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.top + dy, left: self.left + dx, bottom: self.bottom + dy, right: self.right + dx)
    }


    func minInsets(_ insets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: minValue(self.top, minValue: insets.top),
                            left: minValue(self.left, minValue: insets.left),
                            bottom: minValue(self.bottom, minValue: insets.bottom),
                            right: minValue(self.right, minValue: insets.right))
    }

    func minInsets(dx: CGFloat, dy: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: minValue(self.top, minValue: dy),
                            left: minValue(self.left, minValue: dx),
                            bottom: minValue(self.bottom, minValue: dy),
                            right: minValue(self.right, minValue: dx))
    }

    private func minValue(_ value: CGFloat, minValue: CGFloat) -> CGFloat {
        return value >= minValue ? value : minValue
    }
}
//public func +(lhs: PEdgeInsets, rhs: Int) -> PEdgeInsets {
//    return lhs
//}
//
public func +(lhs: PEdgeInsets, rhs: CGFloat) -> PEdgeInsets {
    return PEdgeInsets(top: lhs.top + rhs,
                       left: lhs.left + rhs,
                       bottom: lhs.bottom + rhs,
                       right: lhs.right + rhs)
}

