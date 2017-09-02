//
//  TableViewExampleViewController.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-13.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

struct PinLayoutMethod {
    let name: String
    let description: String
}

class TableViewExampleViewController: BaseViewController {
    fileprivate var mainView: TableViewExampleView {
        return self.view as! TableViewExampleView
    }

    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        
        title = pageType.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = TableViewExampleView()
        mainView.configure(methods: [
            PinLayoutMethod(name: "top(_ value: CGFloat)", description: "The value specifies the top edge distance from the superview's top edge in pixels."),
            PinLayoutMethod(name: "top(_ percent: Percent)", description: "The value specifies the top edge distance from the superview's top edge in percentage of its superview's height."),
            PinLayoutMethod(name: "left(_ value: CGFloat)", description: "The value specifies the left edge distance from the superview's left edge in pixels."),
            PinLayoutMethod(name: "left(_ percent: Percent)", description: "The value specifies the left edge distance from the superview's left edge in percentage of its superview's width."),
            PinLayoutMethod(name: "bottom(_ value: CGFloat)", description: "The value specifies the bottom edge distance from the superview's bottom edge in pixels."),
            PinLayoutMethod(name: "bottom(_ percent: Percent)", description: "The value specifies the bottom edge distance from the superview's bottom edge in percentage of its superview's height."),
            PinLayoutMethod(name: "right(_ value: CGFloat)", description: "The value specifies the right edge distance from the superview's right edge in pixels."),
            PinLayoutMethod(name: "right(_ percent: Percent)", description: "The value specifies the right edge distance from the superview's right edge in percentage of its superview's width."),
            PinLayoutMethod(name: "hCenter(_ value: CGFloat)", description: "The value specifies the horizontal center distance from the superview's left edge in pixels."),
            PinLayoutMethod(name: "hCenter(_ percent: Percent)", description: "The value specifies the horizontal center distance from the superview's left edge in percentage of its superview's width."),
            PinLayoutMethod(name: "vCenter(_ value: CGFloat)", description: "The value specifies the vertical center distance from the superview's top edge in pixels."),
            PinLayoutMethod(name: "vCenter(_ percent: Percent)", description: "The value specifies the vertical center distance from the superview's top edge in percentage of its superview's height.")
        ])
    }
}
