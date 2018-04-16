//
//  Types.swift
//  PinLayout
//
//  Created by Luc Dion on 2018-04-16.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
typealias PView = UIView
typealias PScrollView = UIScrollView
typealias PEdgeInsets = UIEdgeInsets
typealias PViewController = UIViewController
typealias PColor = UIColor
#else
import AppKit
typealias PView = NSView
typealias PScrollView = NSScrollView
typealias PEdgeInsets = NSEdgeInsets
typealias PViewController = NSViewController
typealias PColor = NSColor
#endif
