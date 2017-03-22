//
//  MarginsAndInsetsViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-21.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class MarginsAndInsetsViewController: UIViewController {
    fileprivate var mainView: MarginsAndInsetsView {
        return self.view as! MarginsAndInsetsView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MarginsAndInsetsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = true
    }
}
