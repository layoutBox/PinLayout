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

class JustifyAlignSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        var aView: BasicView!
        
        /*
          root
           |
            - aView
        */

        beforeEach {
            _pinlayoutSetUnitTest(scale: 2)
            Pin.lastWarningText = nil
            
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
        }

        afterEach {
            _pinlayoutSetUnitTest(scale: nil)
        }
        
        //
        // justify + warning
        //
        describe("justify() should warn that the justify cannot be applied") {
            it("test when missing left and right coordinate") {
                aView.pin.justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.width(100).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.left().pinEdges().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing right coordinate") {
                aView.pin.left().width(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when hCenter has been set and justify() won't be applied") {
                aView.pin.hCenter(60).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 210.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify", "center", "won't be applied", "hCenter"]))
            }
        }
        
        //
        // align + warning
        //
        describe("align() should warn that the alignment cannot be applied") {
            it("test when missing top and bottom coordinate") {
                aView.pin.align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.width(100).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.left().pinEdges().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing right coordinate") {
                aView.pin.left().width(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when hCenter has been set and align() won't be applied") {
                aView.pin.hCenter(60).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 210.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
        }
        
        //
        // justify + width
        //
        describe("the result of the width(...) with justify") {
            it("should adjust the width and justify left aView") {
                aView.pin.left().right().width(250)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width and justify left aView") {
                aView.pin.left().right().width(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width and justify center aView") {
                aView.pin.left().right().width(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width and justify right aView") {
                aView.pin.left().right().width(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width and justify left aView") {
                aView.pin.left(50).right(50).width(200).justify(.left)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 200.0, height: 60.0)))
                
                aView.pin.left().right().marginHorizontal(50).width(200).justify(.left)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 200.0, height: 60.0)))
                
                expect(rect1).to(equal(rect2))
            }
            
            it("should adjust the width and justify center aView") {
                aView.pin.left(50).right(50).width(200).justify(.center)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
                
                aView.pin.left().right().marginHorizontal(50).width(200).justify(.center)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
                
                expect(rect1).to(equal(rect2))
            }
            
            it("should adjust the width and justify right aView") {
                aView.pin.left(50).right(50).width(200).justify(.right)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 200.0, height: 60.0)))
                
                aView.pin.left().right().marginHorizontal(50).width(200).justify(.right)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 200.0, height: 60.0)))
                
                expect(rect1).to(equal(rect2))
            }
        }
        
        //
        // align + height
        //
        describe("the result of the height(...) with align") {
            it("should adjust the height and justify left aView") {
                aView.pin.top().bottom().height(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height and justify left aView") {
                aView.pin.top().bottom().height(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the width and align center aView") {
                aView.pin.top().bottom().height(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the width and align right aView") {
                aView.pin.top().bottom().height(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the width and align left aView") {
                aView.pin.top(50).bottom(50).height(200).align(.top)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 200.0)))

                aView.pin.top().bottom().marginVertical(50).height(200).align(.top)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 200.0)))

                expect(rect1).to(equal(rect2))
            }

            it("should adjust the height and align center aView") {
                aView.pin.top(50).bottom(50).height(200).align(.center)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))

                aView.pin.top().bottom().marginVertical(50).height(200).align(.center)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))

                expect(rect1).to(equal(rect2))
            }

            it("should adjust the height and align bottom aView") {
                aView.pin.top(50).bottom(50).height(200).align(.bottom)
                let rect1 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 200.0)))

                aView.pin.top().bottom().marginVertical(50).height(200).align(.bottom)
                let rect2 = aView.frame
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 200.0)))

                expect(rect1).to(equal(rect2))
            }
        }
        
        //
        // justify + pinEdges
        //
        describe("the result of the pinEdges(...) with justify") {
            it("should adjust the width and justify left aView") {
                aView.pin.left().width(100).pinEdges().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        }
        
        //
        // align + pinEdges
        //
        describe("the result of the pinEdges(...) with align") {
            it("should adjust the width and justify left aView") {
                aView.pin.top().height(100).pinEdges().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
            }
        }
    }
}
