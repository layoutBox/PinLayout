//
//  PinLayout+Filters.swift
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-06-18.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
#if os(iOS) || os(tvOS)
import UIKit

// Filter out all hidden views (isHidden is true or alpha is 0)
public func visible(_ views: [UIView]) -> [UIView] {
    return views.filter({ !$0.isHidden && $0.alpha > 0 })
}

#endif
