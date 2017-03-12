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

class PinEdgeCoordinateSpec: QuickSpec {
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

        describe("the result of the pinTop(edge: VerticalEdge, of: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.layout.pinTop(.top, of: aView)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
        }
        
        
        //        aViewChild.layout.pinBottom(.top, of: aView) //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
        //        aViewChild.layout.pinBottom(.top, of: bView)      //CGRect(x: 10.0, y: 70.0, width: 50.0, height: 30.0)
        //        bViewChild.layout.pinBottom(.top, of: aViewChild) //CGRect(x: 40.0, y: -100.0, width: 60.0, height: 20.0)
        //
        //        aViewChild.layout.pinBottom(.bottom, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
        //        aViewChild.layout.pinBottom(.bottom, of: bView)      //CGRect(x: 10.0, y: 150.0, width: 50.0, height: 30.0)
        //        bViewChild.layout.pinBottom(.bottom, of: aViewChild) //CGRect(x: 40.0, y: -70.0, width: 60.0, height: 20.0)
        
        //        aViewChild.layout.pinRight(.left, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
        //        aViewChild.layout.pinRight(.left, of: bView)      //CGRect(x: -30.0, y: 20.0, width: 50.0, height: 30.0)
        //        bViewChild.layout.pinRight(.left, of: aViewChild) //CGRect(x: -70.0, y: 10.0, width: 60.0, height: 20.0)
        //
        //        aViewChild.layout.pinRight(.right, of: aView)      //CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)
        //        aViewChild.layout.pinRight(.right, of: bView)      //CGRect(x: 80.0, y: 20.0, width: 50.0, height: 30.0)
        //        bViewChild.layout.pinRight(.right, of: aViewChild) //CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)

        //
        // pinTop
        //
        describe("the result of the pinTop(edge: VerticalEdge, of: UIView)") {
            
            it("should position the aViewChild's top edge on its parent's top edge") {
                aViewChild.layout.pinTop(.top, of: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 0.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's top edge on its parent sibling (bView)'s top edge") {
                aViewChild.layout.pinTop(.top, of: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's top edge on its sibling's children (aViewChild)'s top edge") {
                bViewChild.layout.pinTop(.top, of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -80.0, width: 60.0, height: 20.0)))
            }
            
            it("should position the aViewChild's top edge on its parent's bottom edge") {
                aViewChild.layout.pinTop(.bottom, of: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 60.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's top edge on its parent sibling (bView)'s bottom edge") {
                aViewChild.layout.pinTop(.bottom, of: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 180.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's top edge on its sibling's children (aViewChild)'s bottom edge") {
                bViewChild.layout.pinTop(.bottom, of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinLeft
        //
        describe("the result of the pinLeft(edge: VerticalEdge, of: UIView)") {
            
            it("should position the aViewChild's left edge on its parent's left edge") {
                aViewChild.layout.pinLeft(.left, of: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's left edge on its parent sibling (bView)'s left edge") {
                aViewChild.layout.pinLeft(.left, of: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's left edge on its sibling's children (aViewChild)'s left edge") {
                bViewChild.layout.pinLeft(.left, of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should position the aViewChild's left edge on its parent's right edge") {
                aViewChild.layout.pinLeft(.right, of: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's left edge on its parent sibling (bView)'s right edge") {
                aViewChild.layout.pinLeft(.right, of: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's left edge on its sibling's children (aViewChild)'s right edge") {
                bViewChild.layout.pinLeft(.right, of: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 60.0, height: 20.0)))
            }
        }
    }
}
