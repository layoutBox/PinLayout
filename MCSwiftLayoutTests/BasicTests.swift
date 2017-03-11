//
//  BasicTests.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

class BasicTestsSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: UIView!
        
        var aView: UIView!
        var aViewChild: UIView!
        
        var bView: UIView!
        var bViewChild: UIView!
        
        /*
          root
           |
            - childLevel1
           |    |
           |     - aViewChild
           |
            - bView
                |
                 - bViewChild
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = UIView()
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = UIView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)

            bView = UIView()
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = UIView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the centers(of: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.layout.center(of: rootView)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
        }
        
        //
        // topLeft
        //
        describe("the result of the topLeft() and topLeft(of: UIView) methods") {
            
//            TODO: Tester topLeft(CGPoint())!!!
            
            it("should position the aView's topLeft corner on its parent's topLeft corner") {
                aView.layout.topLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topLeft corner on the specified view's topLeft corner") {
//                aViewChild.layout.topLeft(of: aView)
//                aViewChild.layout.topLeft(Snap.topLeft, of: aView)
                aViewChild.layout.topLeft(Pin.topLeft, of: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's topLeft corner on its parent sibling (bView)'s topLeft corner") {
                aViewChild.layout.topLeft(of: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bView's topLeft corner on its sibling's (aView) children (aViewChild)'s topLeft corner") {
                bView.layout.topLeft(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the bViewChild's topLeft corner on its parent sibling's (aView) children (aViewChild)'s topLeft corner") {
                bViewChild.layout.topLeft(of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)))
            }
            
            /*it("should centers the bView in the center of its sibling (aView) sub child (aViewChild)") {
                aView.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                aViewChild.frame = CGRect(x: 10, y: 20, width: 20, height: 40)
                bView.frame = CGRect(x: 10, y: 10, width: 30, height: 50)
                
                bView.layout.centers(of: aViewChild)
                
                expect(bView.frame).to(equal(CGRect(x: 15, y: 35, width: 30, height: 50)))
            }
            
            it("should centers the aViewChild in the center of bView") {
                aView.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                aViewChild.frame = CGRect(x: 10, y: 20, width: 20, height: 40)
                bView.frame = CGRect(x: 10, y: 10, width: 30, height: 50)
                
                aViewChild.layout.centers(of: bView)
                
                expect(aViewChild.frame).to(equal(CGRect(x: 5, y: -5, width: 20, height: 40)))
            }
            
            it("should centers the bViewChild in the center of its parent's sibling (aView) sub child (aViewChild)") {
                aView.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                aViewChild.frame = CGRect(x: 10, y: 20, width: 30, height: 40)
                bView.frame = CGRect(x: 10, y: 80, width: 30, height: 50)
                bViewChild.frame = CGRect(x: 0, y: 0, width: 20, height: 10)
                
                bViewChild.layout.centers(of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: 15, y: -25, width: 20, height: 10)))
            }*/
        }
        
//        describe("the result of the centers() method") {
//            it("should centers the aView in the center of its parent") {
//                aView.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
//                
//                aView.layout.centers()
//                
//                expect(aView.frame).to(equal(CGRect(x: 30, y: 20, width: 40, height: 60)))
//            }
//        }
    }
}
