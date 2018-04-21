//
//  ViewController.swift
//  PinLayoutCarthageTest
//
//  Created by DION, Luc (MTL) on 2017-06-03.
//  Copyright © 2017 Mirego. All rights reserved.
//

import UIKit
import PinLayout

class ViewController: UIViewController {
    fileprivate let subview = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        subview.backgroundColor = .red
        view.addSubview(subview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        subview.pin.horizontally(20%).vertically(30%)
    }
}

