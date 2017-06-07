// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
                unAttachedView.pin.topLeft(to: rootView.anchor.topLeft)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }

            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                let unAttachedViewChild = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.addSubview(unAttachedViewChild)

                unAttachedViewChild.pin.topLeft(to: rootView.anchor.topLeft)

                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }

            it("should warns that the reference view is not added to any view ") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                aView.pin.topLeft(to: unAttachedView.anchor.topLeft)

                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 60)))
            }

            it("should layout the view even if the reference's superview is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                let unAttachedViewChild = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.addSubview(unAttachedViewChild)

                aView.pin.topLeft(to: unAttachedViewChild.anchor.topLeft)

                expect(aView.frame).to(equal(CGRect(x: 20, y: 20, width: 100, height: 60)))
            }
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
            
            it("should position the aViewChild's topLeft corner on the specified view's topLeft corner") {
                aViewChild.pin.topLeft(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: aView.anchor.rightCenter)
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
                aViewChild.pin.topLeft(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topLeft(to: bView.anchor.rightCenter)
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
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's topCenter corner on its parent's topCenter corner") {
                aView.pin.topCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aViewChild's topCenter corner on the specified view's topCenter corner") {
                aViewChild.pin.topCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: aView.anchor.rightCenter)
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
                aViewChild.pin.topCenter(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topCenter(to: bView.anchor.rightCenter)
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
                aViewChild.pin.topRight(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: aView.anchor.rightCenter)
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
                aViewChild.pin.topRight(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 140.0, width: 50.0, height: 30.0)))
                aViewChild.pin.topRight(to: bView.anchor.rightCenter)
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
        // leftCenter
        //
        describe("the result of the leftCenter() and leftCenter(to: UIView) methods") {
            it("should position the aView's leftCenter corner at the specified position") {
                aView.pin.left(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 100, y: 70.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's leftCenter corner at the specified position") {
                aView.pin.leftCenter()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                aViewChild.pin.leftCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.rightCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 45.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aView's leftCenter corner at the specified position") {
                aViewChild.pin.leftCenter(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.rightCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.leftCenter(to: bView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 165.0, width: 50.0, height: 30.0)))
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

        //
        // center
        //
        describe("the result of the center() and center(to: UIView) methods") {
            it("should position the aView's center corner at the specified position") {
                aView.pin.hCenter(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 70.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's center corner at the specified position") {
                aView.pin.center()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should position the aView's center corner at the specified position") {
                aViewChild.pin.center(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: aView.anchor.rightCenter)
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
                aViewChild.pin.center(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.center(to: bView.anchor.rightCenter)
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
        // rightCenter
        //
        describe("the result of the rightCenter() and rightCenter(to: UIView) methods") {
            it("should position the aView's rightCenter corner at the specified position") {
                aView.pin.right(100).vCenter(100)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 70.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's rightCenter corner at the specified position") {
                aView.pin.rightCenter()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's rightCenter corner at the specified position") {
                aViewChild.pin.rightCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.rightCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 15.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 45.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: aView.anchor.bottomRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 45.0, width: 50.0, height: 30.0)))
            }

            it("should position the aView's rightCenter corner at the specified position") {
                aViewChild.pin.rightCenter(to: bView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 85.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.rightCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 125.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.bottomLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.bottomCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 165.0, width: 50.0, height: 30.0)))
                aViewChild.pin.rightCenter(to: bView.anchor.bottomRight)
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
                aViewChild.pin.bottomLeft(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: aView.anchor.rightCenter)
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
                aViewChild.pin.bottomLeft(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomLeft(to: bView.anchor.rightCenter)
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
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 240.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aView.pin.bottomCenter()
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 340.0, width: 100.0, height: 60.0)))
            }

            it("should position the aView's bottomCenter corner at the specified position") {
                aViewChild.pin.bottomCenter(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 75.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: aView.anchor.rightCenter)
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
                aViewChild.pin.bottomCenter(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -5.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomCenter(to: bView.anchor.rightCenter)
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
                aViewChild.pin.bottomRight(to: aView.anchor.topLeft)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.topCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.topRight)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: -30.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: aView.anchor.rightCenter)
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
                aViewChild.pin.bottomRight(to: bView.anchor.leftCenter)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.center)
                expect(aViewChild.frame).to(equal(CGRect(x: 25.0, y: 110.0, width: 50.0, height: 30.0)))
                aViewChild.pin.bottomRight(to: bView.anchor.rightCenter)
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
