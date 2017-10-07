//
//  UIEdgeInsets+PinLayout.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-10-06.
//  Copyright © 2017 Mirego. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
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
    
    fileprivate func minValue(_ value: CGFloat, minValue: CGFloat) -> CGFloat {
        return value >= minValue ? value : minValue
    }
}
