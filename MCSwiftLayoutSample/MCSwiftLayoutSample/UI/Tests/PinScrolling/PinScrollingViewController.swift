//
//  PinScrollingViewController.swift
//  MCSwiftLayoutSample
//
//  Created by Luc Dion on 2017-03-23.
//  Copyright (c) 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import UIKit

class PinScrollingViewController: UIViewController {
    fileprivate var mainView: PinScrollingView {
        return self.view as! PinScrollingView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = PinScrollingView()
    }
}
