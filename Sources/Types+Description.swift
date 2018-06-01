//
//  Types+Description.swift
//  PinLayout-iOS
//
//  Created by Luc Dion on 2018-05-26.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

extension HorizontalAlign {
    var description: String {
        switch self {
        case .left: return "left"
        case .center: return "center"
        case .right: return "right"
        case .start: return "start"
        case .end: return "end"
        }
    }
}

extension VerticalAlign {
    var description: String {
        switch self {
        case .top: return "top"
        case .center: return "center"
        case .bottom: return "bottom"
        }
    }
}

extension CGFloat {
    public var description: String {
        if self.truncatingRemainder(dividingBy: 1) == 0.0 {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
}

extension FitType {
    var description: String {
        switch self {
        case .width: return ".width"
        case .height: return ".height"
        case .widthFlexible: return ".widthFlexible"
        case .heightFlexible: return ".heightFlexible"
        }
    }
}

extension WrapType {
    var description: String {
        switch self {
        case .all: return ".all"
        case .horizontally: return ".horizontally"
        case .vertically: return ".vertically"
        }
    }
}
