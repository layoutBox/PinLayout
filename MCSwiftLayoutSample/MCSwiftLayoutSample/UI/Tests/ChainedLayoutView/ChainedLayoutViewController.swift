//
//  ChainedLayoutViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-20.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class ChainedLayoutViewController: UIViewController {
    fileprivate var mainView: ChainedLayoutView? {
        return self.view as? ChainedLayoutView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ChainedLayoutView()
    }
}
