//
//  TableViewExampleViewController.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-13.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

struct Method {
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
            Method(name: "top(_ value: CGFloat)", description: "The value specifies the top edge distance from the superview's top edge in pixels."),
            Method(name: "top(_ percent: Percent)", description: "The value specifies the top edge distance from the superview's top edge in percentage of its superview's height."),
            Method(name: "left(_ value: CGFloat)", description: "The value specifies the left edge distance from the superview's left edge in pixels."),
            Method(name: "left(_ percent: Percent)", description: "The value specifies the left edge distance from the superview's left edge in percentage of its superview's width."),
            Method(name: "bottom(_ value: CGFloat)", description: "The value specifies the bottom edge distance from the superview's bottom edge in pixels."),
            Method(name: "bottom(_ percent: Percent)", description: "The value specifies the bottom edge distance from the superview's bottom edge in percentage of its superview's height."),
            Method(name: "right(_ value: CGFloat)", description: "The value specifies the right edge distance from the superview's right edge in pixels."),
            Method(name: "right(_ percent: Percent)", description: "The value specifies the right edge distance from the superview's right edge in percentage of its superview's width."),
            Method(name: "hCenter(_ value: CGFloat)", description: "The value specifies the horizontal center distance from the superview's left edge in pixels."),
            Method(name: "hCenter(_ percent: Percent)", description: "The value specifies the horizontal center distance from the superview's left edge in percentage of its superview's width."),
            Method(name: "vCenter(_ value: CGFloat)", description: "The value specifies the vertical center distance from the superview's top edge in pixels."),
            Method(name: "vCenter(_ percent: Percent)", description: "The value specifies the vertical center distance from the superview's top edge in percentage of its superview's height.")
        ])
    }
}
