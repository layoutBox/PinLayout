//
//  ViewExtensionsPositionningViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-17.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit
import UIKit

class ViewExtensionsPositionningViewController: UIViewController {
    fileprivate var mainView: ViewExtensionsPositionningView {
        return self.view as! ViewExtensionsPositionningView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ViewExtensionsPositionningView()
    }
}
