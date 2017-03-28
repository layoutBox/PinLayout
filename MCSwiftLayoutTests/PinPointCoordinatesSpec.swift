//
//  PinPointCoordinatesSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import PinLayout

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
                unAttachedView.pin.center(to: rootView.anchor.bottomCenter)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
        }
        
        //
        // topLeft
        //
        describe("the result of the topLeft() and topLeft(to: UIView) methods") {
            
            it("should position the aView's topLeft corner at the specified position") {
                aView.pin.topLeft(to: CGPoint(x: 25, y: 25))
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 25.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topLeft corner on its parent's topLeft corner") {
                aView.pin.topLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topLeft corner on the specified view's topLeft corner") {
//                aViewChild.pin.topLeftPin.topLeft, of: aView)
//                aViewChild.pin.topLeftaView.pin.topLeft)
//                aViewChild.pin.topLeft<#T##pin: PinType##PinType#>, of: <#T##UIView#>)
                aViewChild.pin.topLeft(to: aView.anchor.topLeft)

                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's topLeft corner on its parent sibling (bView)'s topLeft corner") {
                aViewChild.pin.topLeft(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bView's topLeft corner on its sibling's (aView) children (aViewChild)'s topLeft corner") {
                bView.pin.topLeft(to: aViewChild.anchor.topLeft)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the bViewChild's topLeft corner on its parent sibling's (aView) children (aViewChild)'s topLeft corner") {
                bViewChild.pin.topLeft(to: aViewChild.anchor.topLeft)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // topCenter
        //
        describe("the result of the topCenter() and topCenter(to: UIView) methods") {
            
            it("should position the aView's topCenter corner at the specified position") {
                aView.pin.topCenter(to: CGPoint(x: 100, y: 100))
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topCenter corner on its parent's topCenter corner") {
                aView.pin.topCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topCenter corner on the specified view's topCenter corner") {
                aViewChild.pin.topCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's topCenter corner on its parent sibling (bView)'s topCenter corner") {
                aViewChild.pin.topCenter(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bView's topCenter corner on its sibling's (aView) children (aViewChild)'s topCenter corner") {
                bView.pin.topCenter(to: aViewChild.anchor.topCenter)
                expect(bView.frame).to(equal(CGRect(x: 120.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the bViewChild's topCenter corner on its parent sibling's (aView) children (aViewChild)'s topCenter corner") {
                bViewChild.pin.topCenter(to: aViewChild.anchor.topCenter)
                expect(bViewChild.frame).to(equal(CGRect(x: -15.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        
        //
        // topRight
        //
        describe("the result of the topRight() and topRight(to: UIView) methods") {
            it("should position the aView's topRight corner at the specified position") {
                aView.pin.topRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topRight corner at the specified position") {
                aViewChild.pin.topRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's topRight corner at the specified position") {
                aViewChild.pin.topRight(to: bView.anchor.topRight)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topRight corner at the specified position") {
                bView.pin.topRight(to: aViewChild.anchor.topRight)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's topRight corner at the specified position") {
                bViewChild.pin.topRight(to: aViewChild.anchor.topRight)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // leftCenter
        //
        describe("the result of the leftCenter() and leftCenter(to: UIView) methods") {
            it("should position the aView's leftCenter corner at the specified position") {
                aView.pin.leftCenter()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                aViewChild.pin.leftCenter(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                aViewChild.pin.leftCenter(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                bView.pin.leftCenter(to: aViewChild.anchor.leftCenter)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                bViewChild.pin.leftCenter(to: aViewChild.anchor.leftCenter)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }

/*
        //
        // center
        //
        describe("the result of the center() and center(to: UIView) methods") {
            it("should position the aView's center corner at the specified position") {
                aView.pin.center()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                aViewChild.pin.center(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                aViewChild.pin.center(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                bView.pin.center(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 120.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                bViewChild.pin.center(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -15.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // rightCenter
        //
        describe("the result of the rightCenter() and rightCenter(to: UIView) methods") {
            it("should position the aView's rightCenter corner at the specified position") {
                aView.pin.rightCenter()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's rightCenter corner at the specified position") {
                aViewChild.pin.rightCenter(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's rightCenter corner at the specified position") {
                aViewChild.pin.rightCenter(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's rightCenter corner at the specified position") {
                bView.pin.rightCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's rightCenter corner at the specified position") {
                bViewChild.pin.rightCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -20.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // bottomLeft
        //
        describe("the result of the bottomLeft() and bottomLeft(to: UIView) methods") {
            it("should position the aView's bottomLeft corner at the specified position") {
                aView.pin.bottomLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's bottomLeft corner at the specified position") {
                aViewChild.pin.bottomLeft(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomLeft corner at the specified position") {
                aViewChild.pin.bottomLeft(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomLeft corner at the specified position") {
                bView.pin.bottomLeft(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's bottomLeft corner at the specified position") {
                bViewChild.pin.bottomLeft(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -10.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // bottomCenter
        //
        describe("the result of the bottomCenter() and bottomCenter(to: UIView) methods") {
            it("should position the aView's bottomCenter corner at the specified position") {
                aView.pin.bottomCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's bottomCenter corner at the specified position") {
                aViewChild.pin.bottomCenter(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomCenter corner at the specified position") {
                aViewChild.pin.bottomCenter(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomCenter corner at the specified position") {
                bView.pin.bottomCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 120.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's bottomCenter corner at the specified position") {
                bViewChild.pin.bottomCenter(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -15.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // bottomRight
        //
        describe("the result of the bottomRight() and bottomRight(to: UIView) methods") {
            it("should position the aView's bottomRight corner at the specified position") {
                aView.pin.bottomRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's bottomRight corner at the specified position") {
                aViewChild.pin.bottomRight(to: aView)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomRight corner at the specified position") {
                aViewChild.pin.bottomRight(to: bView)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's bottomRight corner at the specified position") {
                bView.pin.bottomRight(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 70.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's bottomRight corner at the specified position") {
                bViewChild.pin.bottomRight(to: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: -20.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }*/
    }
}
