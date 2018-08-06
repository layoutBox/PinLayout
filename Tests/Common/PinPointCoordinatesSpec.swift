//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Quick
import Nimble
import PinLayout

class PinPointCoordinatesSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        
        var aView: BasicView!
        var aViewChild: BasicView!
        
        var bView: BasicView!
        var bViewChild: BasicView!
        
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
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)

            bView = BasicView()
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the centers(to: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.topLeft(to: rootView.anchor.topLeft)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }

            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                let unAttachedViewChild = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.addSubview(unAttachedViewChild)

                unAttachedViewChild.pin.topLeft(to: rootView.anchor.topLeft)

                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }

            it("should warns that the reference view is not added to any view ") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                aView.pin.topLeft(to: unAttachedView.anchor.topLeft)

                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 60)))
            }

            #if os(iOS) || os(tvOS)
            it("should layout the view even if the reference's superview is not added to any view") {
                let unAttachedView = BasicView()
                unAttachedView.frame = CGRect(x: 10, y: 10, width: 10, height: 10)

                let unAttachedViewChild = BasicView()
                unAttachedViewChild.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
                unAttachedView.addSubview(unAttachedViewChild)

                aView.pin.topLeft(to: unAttachedViewChild.anchor.topLeft)

                expect(aView.frame).to(equal(CGRect(x: 20, y: 20, width: 100, height: 60)))
            }
            #endif
        }
        
        //
        // topLeft
        //
        describe("the result of the topLeft() and topLeft(to: UIView) methods") {
            it("should position the aView's topLeft corner at the specified position") {
                aView.pin.top(25).left(25)
                expect(aView.frame).to(equal(CGRect(x: 25.0, y: 25.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topLeft corner on its parent's topLeft corner") {
                aView.pin.topLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topLeft corner on its parent's topLeft corner") {
                aView.pin.topLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topLeft corner on the specified view's topLeft corner") {
                aViewChild.pin.topLeft(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's topLeft corner on its parent sibling (bView)'s topLeft corner") {
                aViewChild.pin.topLeft(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 180.0, width: 50.0, height: 30.0)))
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
                aView.pin.top(100).hCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topCenter corner on its parent's topCenter corner") {
                aView.pin.topCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topCenter corner on its parent's topCenter corner") {
                aView.pin.topCenter(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 10.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topCenter corner on the specified view's topCenter corner") {
                aViewChild.pin.topCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 60.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's topCenter corner on its parent sibling (bView)'s topCenter corner") {
                aViewChild.pin.topCenter(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 180.0, width: 50.0, height: 30.0)))
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
                aView.pin.top(100).right(100)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topRight corner at the specified position") {
                aView.pin.topRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topRight corner at the specified position") {
                aView.pin.topRight(10)
                expect(aView.frame).to(equal(CGRect(x: 290.0, y: 10.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's topRight corner at the specified position") {
                aViewChild.pin.topRight(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 60.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 60.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's topRight corner at the specified position") {
                aViewChild.pin.topRight(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 180.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 180.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's topRight corner at the specified position") {
                bViewChild.pin.topRight(to: aViewChild.anchor.topRight)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: -80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // centerLeft
        //
        describe("the result of the centerLeft() and centerLeft(to: UIView) methods") {
            it("should position the aView's centerLeft corner at the specified position") {
                aView.pin.left(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 100, y: 270.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's centerLeft corner at the specified position") {
                aView.pin.centerLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's centerLeft corner at the specified position") {
                aView.pin.centerLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's centerLeft corner at the specified position") {
                aViewChild.pin.centerLeft(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 45.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's centerLeft corner at the specified position") {
                aViewChild.pin.centerLeft(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerLeft(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 165.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's centerLeft corner at the specified position") {
                bView.pin.centerLeft(to: aViewChild.anchor.centerLeft)
                expect(bView.frame).to(equal(CGRect(x: 150.0, y: 95.0, width: 110.0, height: 80.0)))
            }
            
            it("should position the aView's centerLeft corner at the specified position") {
                bViewChild.pin.centerLeft(to: aViewChild.anchor.centerLeft)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: -75.0, width: 60.0, height: 20.0)))
            }
        }

        //
        // center
        //
        describe("the result of the center() and center(to: UIView) methods") {
            it("should position the aView's center corner at the specified position") {
                aView.pin.hCenter(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 270.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's center corner at the specified position") {
                aView.pin.center()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's center corner at the specified position") {
                aView.pin.center(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 180.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                aViewChild.pin.center(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 45.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                aViewChild.pin.center(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 165.0, width: 50.0, height: 30.0)))
            }
        }

        //
        // centerRight
        //
        describe("the result of the centerRight() and centerRight(to: UIView) methods") {
            it("should position the aView's centerRight corner at the specified position") {
                aView.pin.right(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 270.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's centerRight corner at the specified position") {
                aView.pin.centerRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's centerRight corner at the specified position") {
                aView.pin.centerRight(10)
                expect(aView.frame).to(equal(CGRect(x: 290.0, y: 170.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's centerRight corner at the specified position") {
                aViewChild.pin.centerRight(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 45.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's centerRight corner at the specified position") {
                aViewChild.pin.centerRight(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.centerRight(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 165.0, width: 50.0, height: 30.0)))
            }
        }

        //
        // bottomLeft
        //
        describe("the result of the bottomLeft() and bottomLeft(to: UIView) methods") {
            it("should position the aView's bottomLeft corner at the specified position") {
                aView.pin.bottom(100).left(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 240.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomLeft corner at the specified position") {
                aView.pin.bottomLeft()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomLeft corner at the specified position") {
                aView.pin.bottomLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 330.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomLeft corner at the specified position") {
                aViewChild.pin.bottomLeft(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 30.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's bottomLeft corner at the specified position") {
                aViewChild.pin.bottomLeft(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 150.0, width: 50.0, height: 30.0)))
            }
        }

        //
        // bottomCenter
        //
        describe("the result of the bottomCenter() and bottomCenter(to: UIView) methods") {
            it("should position the aView's bottomCenter corner at the specified position") {
                aView.pin.bottom(100).hCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 240.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aView.pin.bottomCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 340.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aView.pin.bottomCenter(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 330.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aViewChild.pin.bottomCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 30.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aViewChild.pin.bottomCenter(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 50.0, height: 30.0)))
            }
        }

        //
        // bottomRight
        //
        describe("the result of the bottomRight() and bottomRight(to: UIView) methods") {
            it("should position the aView's bottomRight corner at the specified position") {
                aView.pin.bottom(100).right(100)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 240.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomRight corner at the specified position") {
                aView.pin.bottomRight()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomRight corner at the specified position") {
                aView.pin.bottomRight(10)
                expect(aView.frame).to(equal(CGRect(x: 290.0, y: 330.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomRight corner at the specified position") {
                aViewChild.pin.bottomRight(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's bottomRight corner at the specified position") {
                aViewChild.pin.bottomRight(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 70.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.centerLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.centerRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 150.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 150.0, width: 50.0, height: 30.0)))
            }
        }
    }
}
