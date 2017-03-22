//
//  ValidateConflictsViewController.swift
//  MCLayoutExample
//
//  Created by DION, Luc (MTL) on 2017-02-23.
//  Copyright (c) 2017 Mirego. All rights reserved.
//
import UIKit

class ValidateConflictsViewController: UIViewController {
    fileprivate var mainView: ValidateConflictsView {
        return self.view as! ValidateConflictsView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ValidateConflictsView()
    }
}
