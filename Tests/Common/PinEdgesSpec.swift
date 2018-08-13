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

class PinEdgesSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
        var rootView: BasicView!
        var aView: BasicView!
        var bView: BasicView!
        var bViewChild: BasicView!

        /*
          root
           |
            - aView
                |
                 - aViewChild
        */

        beforeEach {
            Pin.lastWarningText = nil
        
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            rootView.addSubview(aView)
            
            bView = BasicView()
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bView.addSubview(bViewChild)
            
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        }

        //
        // top
        //
        describe("the result of top(...)") {
        
            it("should adjust the aView") {
                aView.pin.top()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(0)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.top()
                let noParameterFrame = aView.frame

                aView.pin.top(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.top(20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 20.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(20).bottom()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 20.0, width: 200.0, height: 380.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(-20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: -20.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(-20).bottom()
                expect(aView.frame).to(equal(CGRect(x: 140, y: -20.0, width: 200.0, height: 420.0)))
            }
        
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.top(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 80.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: -80.0, width: 200.0, height: 100.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.top(insets)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 10.0, width: 200.0, height: 100.0)))
            }
        }

        //
        // left
        //
        describe("the result of left(...)") {
            it("should adjust the aView") {
                aView.pin.left()
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(0)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.left()
                let noParameterFrame = aView.frame

                aView.pin.left(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.left(-20)
                expect(aView.frame).to(equal(CGRect(x: -20, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(-20).right()
                expect(aView.frame).to(equal(CGRect(x: -20, y: 100.0, width: 420.0, height: 100.0)))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.left(20.0%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.left(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(20%)
                expect(aView.frame).to(equal(CGRect(x: 80, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(20%).right()
                expect(aView.frame).to(equal(CGRect(x: 80, y: 100.0, width: 320.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(-20%)
                expect(aView.frame).to(equal(CGRect(x: -80, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(-20%).right()
                expect(aView.frame).to(equal(CGRect(x: -80, y: 100.0, width: 480.0, height: 100.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.left(insets)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 200.0, height: 100.0)))
            }
        }

        //
        // bottom
        //
        describe("the result of bottom(...)") {
            it("should adjust the aView") {
                aView.pin.bottom()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 300.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(0)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 300.0, width: 200.0, height: 100.0)))
            }
            
            it("should have the same position without or with a 0 parameter value") {
                aView.pin.bottom()
                let noParameterFrame = aView.frame
                
                aView.pin.bottom(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(-20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 320.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top().bottom(-20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 420.0)))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.bottom(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 220.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top().bottom(20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 320.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 380.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top().bottom(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 480.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.bottom(insets)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 270.0, width: 200.0, height: 100.0)))
            }
        }

        //
        // right
        //
        describe("the result of right(...)") {
            it("should adjust the aView") {
                aView.pin.right()
                expect(aView.frame).to(equal(CGRect(x: 200, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(0)
                expect(aView.frame).to(equal(CGRect(x: 200, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.right()
                let noParameterFrame = aView.frame

                aView.pin.right(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.right(-20)
                expect(aView.frame).to(equal(CGRect(x: 220, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left().right(-20)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 420.0, height: 100.0)))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.right(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(20%)
                expect(aView.frame).to(equal(CGRect(x: 120, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left().right(20%)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 320.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(-20%)
                expect(aView.frame).to(equal(CGRect(x: 280, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left().right(-20%)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 480.0, height: 100.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.right(insets)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 200.0, height: 100.0)))
            }
        }
        
        //
        // hCenter
        //
        describe("the result of hCenter(...)") {
            it("should adjust the aView") {
                aView.pin.hCenter()
                expect(aView.frame).to(equal(CGRect(x: 100, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(0)
                expect(aView.frame).to(equal(CGRect(x: 100, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should have the same position without or with a 0 parameter value") {
                aView.pin.hCenter()
                let noParameterFrame = aView.frame
                
                aView.pin.hCenter(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(-20)
                expect(aView.frame).to(equal(CGRect(x: 80, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should not apply hCenter") {
                aView.pin.left().hCenter(-20)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 100.0)))
                expect(Pin.lastWarningText).to(contain(["hCenter", "won't be applied", "left"]))
            }
            
            // hCenter(%)
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.hCenter(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(40%)
                expect(aView.frame).to(equal(CGRect(x: 260, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(-20%)
                expect(aView.frame).to(equal(CGRect(x: 20, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            // hCenter(to: ...)
            it("should adjust the bView") {
                bView.pin.hCenter(to: aView.edge.left)
                expect(bView.frame).to(equal(CGRect(x: 85.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should adjust the bView") {
                bView.pin.hCenter(to: aView.edge.hCenter)
                expect(bView.frame).to(equal(CGRect(x: 185.0, y: 120.0, width: 110.0, height: 80.0)))
            }
            
            it("should adjust the bView") {
                bView.pin.hCenter(to: aView.edge.right)
                expect(bView.frame).to(equal(CGRect(x: 285.0, y: 120.0, width: 110.0, height: 80.0)))
            }
        }
        
        //
        // vCenter
        //
        describe("the result of vCenter(...)") {
            it("should adjust the aView") {
                aView.pin.vCenter()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(0)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should have the same position without or with a 0 parameter value") {
                aView.pin.vCenter()
                let noParameterFrame = aView.frame
                
                aView.pin.vCenter(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(-20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 130.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top().vCenter(-20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
                expect(Pin.lastWarningText).to(contain(["vCenter", "won't be applied", "top"]))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 230.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 70.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top().vCenter(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
                expect(Pin.lastWarningText).to(contain(["vCenter", "won't be applied", "top"]))
            }
            
            // vCenter(to: ...)
            it("should adjust the bView") {
                bView.pin.vCenter(to: aView.edge.top)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 110.0, height: 80.0)))
            }

            it("should adjust the bView") {
                bView.pin.vCenter(to: aView.edge.vCenter)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 110.0, height: 80.0)))
            }
            
            it("should adjust the bView") {
                bView.pin.vCenter(to: aView.edge.bottom)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 160.0, width: 110.0, height: 80.0)))
            }
            
            it("should adjust the bView") {
                bViewChild.pin.vCenter(to: aView.edge.vCenter)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 20.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // all()
        //
        describe("the result of all()") {
            it("should adjust the aView") {
                aView.pin.all()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 400.0, height: 400.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.all().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 380.0, height: 380.0)))
            }

            it("should adjust the aView") {
                aView.pin.all(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 380.0, height: 380.0)))
            }
            
            it("should adjust the bViewChild") {
                bViewChild.pin.all()
                expect(bViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 110.0, height: 80.0)))
            }
            
            it("should adjust the bViewChild") {
                bViewChild.pin.all().margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 60.0)))
            }

            it("should adjust the bViewChild") {
                bViewChild.pin.all(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 60.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.all(insets)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
            }

            it("should warn") {
                aView.pin.top(20).all()
                expect(Pin.lastWarningText).to(contain(["all() top coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.left(20).all()
                expect(Pin.lastWarningText).to(contain(["all() left coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.right(20).all()
                expect(Pin.lastWarningText).to(contain(["all() right coordinate", "won't be applied", "already been set to 20"]))
            }
            
            it("should warn") {
                aView.pin.bottom(20).all()
                expect(Pin.lastWarningText).to(contain(["all() bottom coordinate", "won't be applied", "already been set to 20"]))
            }
        }
        
        //
        // horizontally()
        //
        describe("the result of horizontally()") {
            it("should adjust the aView") {
                aView.pin.horizontally()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.horizontally().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 380.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.horizontally(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 380.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.horizontally(10%)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 320.0, height: 100.0)))
            }
            
            it("should adjust the bViewChild") {
                bViewChild.pin.horizontally()
                expect(bViewChild.frame).to(equal(CGRect(x: 0.0, y: 10.0, width: 110.0, height: 20.0)))
            }

            it("should adjust the bViewChild") {
                bViewChild.pin.horizontally().margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 20.0)))
            }

            it("should adjust the bViewChild") {
                bViewChild.pin.horizontally(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 90.0, height: 20.0)))
            }

            it("should adjust the bViewChild") {
                bViewChild.pin.horizontally(10%)
                expect(bViewChild.frame).to(equal(CGRect(x: 11.0, y: 10.0, width: 88.0, height: 20.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.horizontally(insets)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 340.0, height: 100.0)))
            }

            it("should warn") {
                aView.pin.left(20).horizontally()
                expect(Pin.lastWarningText).to(contain(["horizontally() left coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.right(20).horizontally()
                expect(Pin.lastWarningText).to(contain(["horizontally() right coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.left(10).horizontally(20)
                expect(Pin.lastWarningText).to(contain(["horizontally(20) left coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.right(10).horizontally(20)
                expect(Pin.lastWarningText).to(contain(["horizontally(20) right coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.left(10).horizontally(10%)
                expect(Pin.lastWarningText).to(contain(["horizontally(10%) left coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.right(10).horizontally(10%)
                expect(Pin.lastWarningText).to(contain(["horizontally(10%) right coordinate", "won't be applied", "already been set to 10"]))
            }
        }
        
        //
        // vertically()
        //
        describe("the result of vertically()") {
            it("should adjust the aView") {
                aView.pin.vertically()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 200.0, height: 400.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vertically().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 10.0, width: 200.0, height: 380.0)))
            }

            it("should adjust the aView") {
                aView.pin.vertically(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 10.0, width: 200.0, height: 380.0)))
            }

            it("should adjust the aView") {
                aView.pin.vertically(10%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 320.0)))
            }
            
            it("should adjust the bViewChild") {
                bViewChild.pin.vertically()
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 60.0, height: 80.0)))
            }
            
            it("should adjust the bViewChild") {
                bViewChild.pin.vertically().margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 60.0, height: 60.0)))
            }

            it("using insets") {
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.vertically(insets)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 10.0, width: 200.0, height: 360.0)))
            }

            it("should warn") {
                aView.pin.top(20).vertically()
                expect(Pin.lastWarningText).to(contain(["vertically() top coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.bottom(20).vertically()
                expect(Pin.lastWarningText).to(contain(["vertically() bottom coordinate", "won't be applied", "already been set to 20"]))
            }
            it("should warn") {
                aView.pin.top(10).vertically(20)
                expect(Pin.lastWarningText).to(contain(["vertically(20) top coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.bottom(10).vertically(20)
                expect(Pin.lastWarningText).to(contain(["vertically(20) bottom coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.top(10).vertically(10%)
                expect(Pin.lastWarningText).to(contain(["vertically(10%) top coordinate", "won't be applied", "already been set to 10"]))
            }
            it("should warn") {
                aView.pin.bottom(10).vertically(10%)
                expect(Pin.lastWarningText).to(contain(["vertically(10%) bottom coordinate", "won't be applied", "already been set to 10"]))
            }
        }
    }
}
