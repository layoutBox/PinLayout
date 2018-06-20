//
//  Layoutable+PinLayout.swift
//  PinLayout-iOS
//
//  Created by Antoine Lamy on 2018-06-12.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

extension Layoutable {
    public var anchor: AnchorList {
        return AnchorListImpl(view: self as! View)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self as! View)
    }
}
