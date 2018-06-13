//
//  Sizable.swift
//  PinLayout-iOS
//
//  Created by Antoine Lamy on 2018-06-12.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

public protocol SizeCalculable {
    func sizeThatFits(_ size: CGSize) -> CGSize
    func sizeToFit()
}
