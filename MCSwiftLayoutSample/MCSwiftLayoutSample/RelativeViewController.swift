//
//  RelativeViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-22.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class RelativeViewController: UIViewController {
    fileprivate var mainView: RelativeView {
        return self.view as! RelativeView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = RelativeView()
    }
}
