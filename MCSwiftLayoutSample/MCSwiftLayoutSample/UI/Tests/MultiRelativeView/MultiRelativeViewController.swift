//
//  MultiRelativeViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-25.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MultiRelativeViewController: UIViewController {
    fileprivate var mainView: MultiRelativeView {
        return self.view as! MultiRelativeView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MultiRelativeView()
    }
}
