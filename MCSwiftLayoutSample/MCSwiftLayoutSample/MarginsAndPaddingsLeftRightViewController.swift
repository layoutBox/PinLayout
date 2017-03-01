//
//  MarginsAndPaddingsLeftRightViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MarginsAndPaddingsLeftRightViewController: UIViewController {    
    fileprivate var mainView: MarginsAndPaddingsLeftRightView {
        return self.view as! MarginsAndPaddingsLeftRightView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MarginsAndPaddingsLeftRightView()
    }
}
