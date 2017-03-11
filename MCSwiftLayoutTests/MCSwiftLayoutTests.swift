//
//  MCSwiftLayoutTests.swift
//  MCSwiftLayoutTests
//
//  Created by DION, Luc (MTL) on 2017-02-27.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import XCTest
@testable import MCSwiftLayout

class MCSwiftLayoutTests: XCTestCase {
    var viewController: UIViewController!
    var rootView: UIView!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIViewController()
        
        rootView = UIView()
        rootView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        viewController.view.addSubview(rootView)
    }
    
    func testExample() {
        let child1 = UIView()
        rootView.addSubview(child1)
        
        child1.layout.center(of: rootView)
        print("child1.frame: \(child1.frame)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
