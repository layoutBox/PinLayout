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

class BetweenSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
        var rootView: BasicView!
        
        var aView: BasicView!
        var aViewChild: BasicView!
        
        var bView: BasicView!
        var bViewChild: BasicView!

        var cView: BasicView!
        
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
            _pinlayoutSetUnitTest(scale: 2)
            Pin.lastWarningText = nil

            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 64, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aView.addSubview(aViewChild)
            
            bView = BasicView()
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bView.addSubview(bViewChild)

            cView = BasicView()
            rootView.addSubview(cView)
        }

        afterEach {
            _pinlayoutSetUnitTest(scale: nil)
            Pin.resetWarnings()
        }
        
        //
        // horizontallyBetween(...)
        //
        describe("the result of horizontallyBetween(...)") {
            it("should warns view being layouted cannot be used as one of the references") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: bView)
                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (40.0, 100.0, 200.0, 100.0))", ") won't be applied",
                                                        "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should warns the view being layouted cannot be used as one of the references (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(bView, and: cView)
                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (0.0, 0.0, 0.0, 0.0))", "won't be applied",
                                                        "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should warns that there is no space between views") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView)
                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (40.0, 100.0, 200.0, 100.0)), ",
                                                        " won't be applied", "there is no horizontal space between these views"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should not warns because Pin.activeLogWarnings.betweenNoSpaceAvailableBetweenViews is set to false") {
                Pin.activeWarnings.noSpaceAvailableBetweenViews = false
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView)
                expect(Pin.lastWarningText).to(beNil())
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should warns that there is no space between views. Use superview as reference") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(rootView, and: cView, aligned: .bottom)

                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (0.0, 64.0, 400.0, 400.0)), ",
                                                        " won't be applied", "there is no horizontal space between these views"]))
            }

            it("should warns that there is no space between views. Use self as reference") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(viewController.view, and: cView, aligned: .bottom)
                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (0.0, 0.0, 0.0, 0.0)), ",
                                                        " won't be applied", "must be added as a sub-view before being used as a reference"]))
            }

            it("should horizontally layout between") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 0.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 100, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (3)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(cView, and: aView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 140.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (3)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 125.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (4)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(cView, and: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 155.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (5)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 150.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between (6)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(cView, and: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 170.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between align center") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 125.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between align center (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(cView, and: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 155.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between align bottom (1)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(aView, and: cView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 150.0, width: 70.0, height: 50.0)))
            }

            it("should horizontally layout between align bottom (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
                bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.horizontallyBetween(cView, and: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 90.0, y: 170.0, width: 70.0, height: 50.0)))
            }
        }

        //
        // horizontallyBetween() when using child views from other container
        //
        describe("the result of horizontallyBetween(...) when using child views from other container") {
            it("should layout between (1)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aViewChild, and: bViewChild)
                expect(cView.frame).to(equal(CGRect(x: 120.0, y: 100.0, width: 100.0, height: 80.0)))
            }

            it("should layout between (2)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aViewChild, and: bViewChild, aligned: .top)
                expect(cView.frame).to(equal(CGRect(x: 120.0, y: 60.0, width: 100.0, height: 80.0)))
            }

            it("should layout between (3)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aViewChild, and: bViewChild, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 120.0, y: 40.0, width: 100.0, height: 80.0)))
            }

            it("should layout between (4)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aViewChild, and: bViewChild, aligned: .bottom)
                expect(cView.frame).to(equal(CGRect(x: 120.0, y: 20.0, width: 100.0, height: 80.0)))
            }

            it("should layout between (5)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(bViewChild, and: aViewChild, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 120.0, y: 150.0, width: 100.0, height: 80.0)))
            }

            it("should layout between (6)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aView, and: aViewChild, aligned: .top)

                expect(Pin.lastWarningText).to(contain(["horizontallyBetween((BasicView, Frame: (10.0, 10.0, 120.0, 150.0)), ",
                                                        ", aligned: .top)", " won't be applied", "there is no horizontal space between these views"]))
            }

            it("should layout between (7)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(aView, and: bViewChild, aligned: .top)
                expect(cView.frame).to(equal(CGRect(x: 130.0, y: 10.0, width: 90.0, height: 80.0)))
            }

            it("should layout between (8)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 180, y: 170, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.horizontallyBetween(bViewChild, and: aView, aligned: .top)
                expect(cView.frame).to(equal(CGRect(x: 130.0, y: 180.0, width: 90.0, height: 80.0)))
            }
        }

        //
        // verticallyBetween(...)
        //
        describe("the result of verticallyBetween(...)") {
            it("should warns view being layouted cannot be used as one of the references") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.frame = CGRect(x: 10, y: 10, width: 11, height: 12)
                bView.pin.verticallyBetween(aView, and: bView)
                expect(Pin.lastWarningText).to(contain(["verticallyBetween((BasicView, Frame: (40.0, 100.0, 200.0, 100.0))", ") won't be applied", "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 11.0, height: 12.0)))
            }

            it("should warns view being layouted cannot be used as one of the references") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.frame = CGRect(x: 10, y: 10, width: 11, height: 12)
                bView.pin.verticallyBetween(bView, and: cView)
                expect(Pin.lastWarningText).to(contain(["verticallyBetween((BasicView, Frame: (10.0, 10.0, 11.0, 12.0))", ") won't be applied", "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 11.0, height: 12.0)))
            }

            it("should warns that there is no space between views") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.frame = CGRect(x: 10, y: 10, width: 11, height: 12)
                bView.pin.verticallyBetween(aView, and: cView)
                expect(Pin.lastWarningText).to(contain(["verticallyBetween((BasicView, Frame: (40.0, 100.0, 200.0, 100.0))", " won't be applied", "there is no vertical space between these views"]))
                expect(bView.frame).to(equal(CGRect(x: 10.0, y: 10.0, width: 11.0, height: 12.0)))
            }

            it("should not warns because Pin.activeLogWarnings.betweenNoSpaceAvailableBetweenViews is set to false") {
                Pin.activeWarnings.noSpaceAvailableBetweenViews = false
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.verticallyBetween(aView, and: cView)
                expect(Pin.lastWarningText).to(beNil())
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should vertically layout between") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView)
                expect(cView.frame).to(equal(CGRect(x: 0.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (2)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 0, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView)
                expect(cView.frame).to(equal(CGRect(x: 0.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (3)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView, aligned: .left)
                expect(cView.frame).to(equal(CGRect(x: 10.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (4)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView, aligned: .left)
                expect(cView.frame).to(equal(CGRect(x: 180.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (5)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 15.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (6)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 200.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (7)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView, aligned: .right)
                expect(cView.frame).to(equal(CGRect(x: 20.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (8)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView, aligned: .right)
                expect(cView.frame).to(equal(CGRect(x: 220.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (9)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView, aligned: .start)
                expect(cView.frame).to(equal(CGRect(x: 10.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (10)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView, aligned: .start)
                expect(cView.frame).to(equal(CGRect(x: 180.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (11)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bView, aligned: .end)
                expect(cView.frame).to(equal(CGRect(x: 20.0, y: 160.0, width: 110.0, height: 80.0)))
            }

            it("should vertically layout between (12)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                bView.frame = CGRect(x: 180, y: 240, width: 150, height: 50)
                cView.frame = CGRect(x: 40, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bView, and: aView, aligned: .end)
                expect(cView.frame).to(equal(CGRect(x: 220.0, y: 160.0, width: 110.0, height: 80.0)))
            }
        }

        //
        // verticallyBetween(...) when using child views from other container
        //
        describe("the result of verticallyBetween(...) when using child views from other container") {
            it("should layout between (1)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aViewChild, and: bViewChild)
                expect(cView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 110.0, height: 130.0)))
            }

            it("should layout between (2)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aViewChild, and: bViewChild, aligned: .left)
                expect(cView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 110.0, height: 130.0)))
            }

            it("should layout between (3)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aViewChild, and: bViewChild, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 25.0, y: 100.0, width: 110.0, height: 130.0)))
            }

            it("should layout between (4)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aViewChild, and: bViewChild, aligned: .right)
            }

            it("should layout between (5)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bViewChild, and: aViewChild, aligned: .center)
                expect(cView.frame).to(equal(CGRect(x: 115.0, y: 100.0, width: 110.0, height: 130.0)))
            }

            it("should layout between (6)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aViewChild, and: bViewChild, aligned: .start)
                expect(cView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 110.0, height: 130.0)))
            }

            it("should layout between (7)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: aViewChild, aligned: .left)
                expect(Pin.lastWarningText).to(contain(["verticallyBetween((BasicView, Frame: (10.0, 10.0, 120.0, 150.0)),", " won't be applied", "there is no vertical space between these views"]))
            }

            it("should layout between (8)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(aView, and: bViewChild, aligned: .left)
                expect(cView.frame).to(equal(CGRect(x: 10.0, y: 160.0, width: 110.0, height: 70.0)))
            }

            it("should layout between (9)") {
                aView.frame = CGRect(x: 10, y: 10, width: 120, height: 150)
                aViewChild.frame = CGRect(x: 30, y: 50, width: 80, height: 40)
                bView.frame = CGRect(x: 100, y: 220, width: 150, height: 50)
                bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
                cView.frame = CGRect(x: 30, y: 100, width: 110, height: 80)
                cView.pin.verticallyBetween(bViewChild, and: aView, aligned: .right)
                expect(cView.frame).to(equal(CGRect(x: 90.0, y: 160.0, width: 110.0, height: 70.0)))
            }
        }
    }
}
