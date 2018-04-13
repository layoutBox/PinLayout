//
//  ViewController.swift
//  PinLayoutMacOsSample
//
//  Created by Luc Dion on 2018-04-06.
//  Copyright © 2018 LayoutBox. All rights reserved.
//

import Cocoa
import PinLayout

class MyView: NSView {
    override var isFlipped: Bool {
        return true
    }
}

class NSViewFlipped: NSView {
    override var isFlipped: Bool {
        return false
    }
}

class ViewController: NSViewController {

    let subview = NSView()
    let subview2 = NSView()
    let subview3 = NSView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.translatesAutoresizingMaskIntoConstraints = false

        subview.wantsLayer = true
        subview.layer?.backgroundColor = NSColor.red.cgColor
        view.addSubview(subview)

        subview2.wantsLayer = true
        subview2.layer?.backgroundColor = NSColor.blue.cgColor
        view.addSubview(subview2)

        subview3.wantsLayer = true
        subview3.layer?.backgroundColor = NSColor.green.cgColor
        view.addSubview(subview3)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidLayout() {
        super.viewDidLayout()

        subview.pin.top().left(20).size(200)
        subview2.pin.below(of: subview).size(100).left(40).marginTop(50)
        subview3.pin.below(of: subview, aligned: .left).above(of: subview2).width(80)
    }
}
