//
//  PinPointCoordinatesSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

class PinPointCoordinatesSpec: QuickSpec {
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
            - aView
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

        describe("the result of the centers(to: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.layout.pinCenter(to: rootView)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
        }
        
        //
        // topLeft
        //
        describe("the result of the topLeft() and topLeft(to: UIView) methods") {
            
            it("should position the aView's topLeft corner at the specified position") {
                aView.layout.pinTopLeft(to: CGPoint(x: 25, y: 25))
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 25.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topLeft corner on its parent's topLeft corner") {
                aView.layout.pinTopLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
//            it("should position the aViewChild's topLeft corner on the specified view's topLeft corner") {
//                aViewChild.layout.pinTopLeft(Pin.topLeft, to: aView)
//                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
//            }

            it("should position the aViewChild's topLeft corner on its parent sibling (bView)'s topLeft corner") {
                aViewChild.layout.pinTopLeft(to: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bView's topLeft corner on its sibling's (aView) children (aViewChild)'s topLeft corner") {
                bView.layout.pinTopLeft(to: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the bViewChild's topLeft corner on its parent sibling's (aView) children (aViewChild)'s topLeft corner") {
                bViewChild.layout.pinTopLeft(to: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // topCenter
        //
        describe("the result of the topCenter() and topCenter(to: UIView) methods") {
            
            it("should position the aView's topCenter corner at the specified position") {
                aView.layout.pinTopCenter(to: CGPoint(x: 100, y: 100))
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topCenter corner on its parent's topCenter corner") {
                aView.layout.pinTopCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topCenter corner on the specified view's topCenter corner") {
                aViewChild.layout.pinTopCenter(to: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's topCenter corner on its parent sibling (bView)'s topCenter corner") {
                aViewChild.layout.pinTopCenter(to: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bView's topCenter corner on its sibling's (aView) children (aViewChild)'s topCenter corner") {
                bView.layout.pinTopCenter(to: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the bViewChild's topCenter corner on its parent sibling's (aView) children (aViewChild)'s topCenter corner") {
                bViewChild.layout.pinTopCenter(to: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        
        //
        // pinTopRight
        //
        describe("the result of the pinTopRight() and pinTopRight(to: UIView) methods") {
            it("should position the aView's pinTopRight corner at the specified position") {
                aView.layout.pinTopRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinTopRight corner at the specified position") {
                aViewChild.layout.pinTopRight(to: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's pinTopRight corner at the specified position") {
                aViewChild.layout.pinTopRight(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's pinTopRight corner at the specified position") {
                bView.layout.pinTopRight(to: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinTopRight corner at the specified position") {
                bViewChild.layout.pinTopRight(to: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinLeftCenter
        //
        describe("the result of the pinLeftCenter() and pinLeftCenter(to: UIView) methods") {
            it("should position the aView's pinLeftCenter corner at the specified position") {
                aView.layout.pinLeftCenter()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinLeftCenter corner at the specified position") {
                aViewChild.layout.pinLeftCenter(to: aView)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinLeftCenter corner at the specified position") {
                aViewChild.layout.pinLeftCenter(to: bView)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinLeftCenter corner at the specified position") {
                bView.layout.pinLeftCenter(to: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinLeftCenter corner at the specified position") {
                bViewChild.layout.pinLeftCenter(to: aViewChild)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }

/*
        //
        // pinCenter
        //
        describe("the result of the pinCenter() and pinCenter(to: UIView) methods") {
            it("should position the aView's pinCenter corner at the specified position") {
                aView.layout.pinCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinCenter corner at the specified position") {
                aViewChild.layout.pinCenter(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinCenter corner at the specified position") {
                aViewChild.layout.pinCenter(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinCenter corner at the specified position") {
                bView.layout.pinCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 120.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinCenter corner at the specified position") {
                bViewChild.layout.pinCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -15.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinRightCenter
        //
        describe("the result of the pinRightCenter() and pinRightCenter(to: UIView) methods") {
            it("should position the aView's pinRightCenter corner at the specified position") {
                aView.layout.pinRightCenter()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinRightCenter corner at the specified position") {
                aViewChild.layout.pinRightCenter(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinRightCenter corner at the specified position") {
                aViewChild.layout.pinRightCenter(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinRightCenter corner at the specified position") {
                bView.layout.pinRightCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinRightCenter corner at the specified position") {
                bViewChild.layout.pinRightCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -20.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinBottomLeft
        //
        describe("the result of the pinBottomLeft() and pinBottomLeft(to: UIView) methods") {
            it("should position the aView's pinBottomLeft corner at the specified position") {
                aView.layout.pinBottomLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinBottomLeft corner at the specified position") {
                aViewChild.layout.pinBottomLeft(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomLeft corner at the specified position") {
                aViewChild.layout.pinBottomLeft(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomLeft corner at the specified position") {
                bView.layout.pinBottomLeft(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinBottomLeft corner at the specified position") {
                bViewChild.layout.pinBottomLeft(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -10.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinBottomCenter
        //
        describe("the result of the pinBottomCenter() and pinBottomCenter(to: UIView) methods") {
            it("should position the aView's pinBottomCenter corner at the specified position") {
                aView.layout.pinBottomCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinBottomCenter corner at the specified position") {
                aViewChild.layout.pinBottomCenter(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomCenter corner at the specified position") {
                aViewChild.layout.pinBottomCenter(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomCenter corner at the specified position") {
                bView.layout.pinBottomCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 120.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinBottomCenter corner at the specified position") {
                bViewChild.layout.pinBottomCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -15.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // pinBottomRight
        //
        describe("the result of the pinBottomRight() and pinBottomRight(to: UIView) methods") {
            it("should position the aView's pinBottomRight corner at the specified position") {
                aView.layout.pinBottomRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's pinBottomRight corner at the specified position") {
                aViewChild.layout.pinBottomRight(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomRight corner at the specified position") {
                aViewChild.layout.pinBottomRight(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's pinBottomRight corner at the specified position") {
                bView.layout.pinBottomRight(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's pinBottomRight corner at the specified position") {
                bViewChild.layout.pinBottomRight(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -20.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }*/
    }
}
