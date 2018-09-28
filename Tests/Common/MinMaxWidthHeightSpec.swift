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

class MinMaxWidthHeightSpec: QuickSpec {
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
        // minWidth
        //
        describe("the result of the minWidth(...)") {
            it("should adjust the width of aView") {
                aView.pin.left().minWidth(50)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 60)
                
                aView.pin.left().minWidth(50)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 60)
                aView.pin.left().minWidth(25%)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left().width(100).minWidth(150) // width < minWidth
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left().width(100).minWidth(50) // width > minWidth
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).marginLeft(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).marginRight(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.right(100).minWidth(300)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 300.0, height: 60.0)))
            }
            
            it("should adjust the width to 500 and keep the view in the center") {
                aView.pin.left().right().minWidth(500)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 500.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(20).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(20).minWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify(.left)", "won't be applied", "justification is not applied when hCenter has been set"]))
            }
        }
        
        //
        // maxWidth
        //
        describe("the result of the maxWidth(...)") {
            it("should adjust the width of aView") {
                aView.pin.left().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 60)
                
                aView.pin.left().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 60)
                
                aView.pin.left().maxWidth(25%)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        
            it("should adjust the width of aView") {
                aView.pin.left().maxWidth(150).marginLeft(50)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left().right().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 150.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left().width(200).maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.right().width(200).maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 100.0, width: 150.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left(0).right(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 300, height: 60)
                aView.pin.left(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left(0).width(100%).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(0).right(0).marginRight(100).maxWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify(.center)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify(.right)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify(.left)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(Pin.lastWarningText).to(contain(["justify(.center)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 85.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).marginRight(20).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 130.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(100%).maxWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
        }

        #if os(iOS) || os(tvOS)
        //
        // minWidth/maxWidth & fitSize()
        //
        describe("the result of the minWidth/maxWidth & fitSize()") {
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).maxHeight(20).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).maxHeight(20).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSizeHard") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).maxHeight(20).minHeight(14).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 14)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).height(14).maxHeight(20).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSizeHard") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).height(14).maxHeight(20).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }

            it("should adjust the width when using fitSizeHard") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).height(14).maxHeight(5).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 5)))
            }

            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).sizeToFit(.width).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(100%).maxWidth(250).sizeToFit(.width).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().maxWidth(250).sizeToFit(.width).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 6.5)))
            }
                
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(10).minWidth(250).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(10).minWidth(250).sizeToFit(.width).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(10).minWidth(250).marginLeft(10).sizeToFit(.width).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(250).marginLeft(10).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 250.0, height: 60)))
            }
        }
        #endif
        
        //
        // minHeight
        //
        describe("the result of the minHeight(...)") {
            it("should adjust the height of aView") {
                aView.pin.top().minHeight(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 30)
                
                aView.pin.top().minHeight(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 25.0, height: 50.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 30)
                
                aView.pin.top().minHeight(25%)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 25.0, height: 100.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top().height(100).minHeight(150) // height < minHeight
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top().height(100).minHeight(50) // height > minHeight
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).marginTop(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).marginBottom(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.bottom(100).minHeight(300)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 300.0)))
            }
            
            it("should adjust the height to 500 and keep the view in the center") {
                aView.pin.top().bottom().minHeight(500)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 500.0)))
            }
            
            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(20).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(20).minHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.top)", "won't be applied", "alignment is not applied when vCenter has been set"]))
            }
        }
        
        //
        // maxHeight
        //
        describe("the result of the maxHeight(...)") {
            it("should adjust the height of aView") {
                aView.pin.top().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 200)

                aView.pin.top().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 200)
                
                aView.pin.top().maxHeight(25%)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().maxHeight(150).marginTop(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().bottom().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().height(200).maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.bottom().height(200).maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 250.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).bottom(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 300)
                aView.pin.top(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).height(100%).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).bottom(0).marginBottom(100).maxHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.top)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.bottom)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.top)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.center)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(Pin.lastWarningText).to(contain(["align(.bottom)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 20.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 85.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).marginBottom(20).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 130.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(100%).maxHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }
        }

        #if os(iOS) || os(tvOS)
        //
        // minHeight/maxHeight & fitSize()
        //
        describe("the result of the minHeight/maxWidth & fitSize()") {
            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(100%).maxHeight(200).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(100%).maxHeight(200).sizeToFit(.height).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(100%).maxHeight(200).sizeToFit(.height).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().maxHeight(200).sizeToFit(.height).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(10).minHeight(200).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(10).minHeight(200).sizeToFit(.height).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(10).minHeight(200).marginTop(10).sizeToFit(.height).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using fitSize") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(200).marginTop(10).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 100.0, height: 200.0)))
            }
        }
        #endif
    }
}
