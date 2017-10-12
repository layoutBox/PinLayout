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
        var viewController: UIViewController!
        
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
            _pinlayoutUnitTestLastWarning = nil
        
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            rootView.addSubview(aView)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
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
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.left(20.0%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
                expect(_pinlayoutUnitTestLastWarning).to(contain(["hCenter", "won't be applied", "left"]))
            }
            
            // hCenter(%)
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
                expect(_pinlayoutUnitTestLastWarning).to(contain(["vCenter", "won't be applied", "top"]))
            }
            
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 200.0, height: 10))
                unAttachedView.pin.vCenter(20%)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 200.0, height: 10)))
                expect(_pinlayoutUnitTestLastWarning).to(contain(["vCenter", "won't be applied", "view must be added"]))
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
                expect(_pinlayoutUnitTestLastWarning).to(contain(["vCenter", "won't be applied", "top"]))
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
    }
}
