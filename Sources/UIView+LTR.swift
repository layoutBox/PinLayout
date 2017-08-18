//
//  UIView+LTR.swift
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-08-04.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
    
extension UIView {
    func isLTR() -> Bool {
        switch Pin.layoutDirection {
        case .auto:
            if #available(iOS 9.0, *) {
                return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight
            } else {
                return UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
            }
        case .ltr:
            return true
        case .rtl:
            return false
        }
    }
}
    
#endif
