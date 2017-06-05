//
//  IntroViewController.swift
//  PinLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-06-05.
//  Copyright (c) 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import UIKit

class IntroViewController: UIViewController {
    fileprivate var mainView: IntroView {
        return self.view as! IntroView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = IntroView()
    }
}
