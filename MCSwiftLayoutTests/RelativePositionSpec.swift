//
//  RelativePositionSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

class RelativePositionSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var rootView: UIView!
        
        var aView: UIView!
        var aViewChild: UIView!
        
        var bView: UIView!
        
        /*
          root
           |
            - aView
           |    |
           |     - aViewChild
           |
            - bView
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = UIView()
            aView.frame = CGRect(x: 100, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = UIView()
            aViewChild.frame = CGRect(x: 40, y: 40, width: 40, height: 20)
            aView.addSubview(aViewChild)
            
            bView = UIView()
            bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)
            rootView.addSubview(bView)
        }
        
        //
        // above(of:aligned:)
        //
        describe("the result of above(of:aligned:)") {
            it("should adjust the aView position") {
                bView.layout.above(of: aView, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the aView position") {
                bView.layout.above(of: aViewChild, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
            }
        }
        
        
//        bView.layout.above(of: aView, aligned: .center)
//        bView.layout.above(of: aView, aligned: .right)
//        
//        bView.layout.left(of: aView, aligned: .top)
//        bView.layout.left(of: aView, aligned: .center)
//        bView.layout.left(of: aView, aligned: .bottom)
//        
//        bView.layout.below(of: aView, aligned: .left)
//        bView.layout.below(of: aView, aligned: .center)
//        bView.layout.below(of: aView, aligned: .right)
//        
//        bView.layout.right(of: aView, aligned: .top)
//        bView.layout.right(of: aView, aligned: .center)
//        bView.layout.right(of: aView, aligned: .bottom)
    
        
        //
        // right(of:aligned:)
        //
        describe("the result of right(of:aligned:)") {
            
        }
        
        //
        // below(of:aligned:)
        //
        describe("the result of below(of:aligned:)") {
            
        }
        
        //
        // left(of:aligned:)
        //
        describe("the result of left(of:aligned:)") {
            
        }
        
        //
        // top(of:)
        //
        describe("the result of top(of:)") {
            
        }
        
        //
        // left(of:)
        //
        describe("the result of left(of:)") {
            
        }
        
        //
        // bottom(of:)
        //
        describe("the result of bottom(of:)") {
            
        }
        
        //
        // right(of:)
        //
        describe("the result of right(of:)") {
            
        }
    }
}
