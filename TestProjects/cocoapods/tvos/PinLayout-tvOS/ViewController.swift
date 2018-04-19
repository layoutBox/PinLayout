//
//  ViewController.swift
//  PinLayoutTvOsExample
//
//  Created by DION, Luc (MTL) on 2017-06-16.
//  Copyright © 2017 Mirego. All rights reserved.
//

import UIKit
import PinLayout

class ViewController: UIViewController {
    let temp = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        temp.backgroundColor = .red
        view.addSubview(temp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        temp.pin.top().hCenter().size(50%)
    }
}

