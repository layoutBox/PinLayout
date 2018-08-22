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
        }
        
        //
        // above(of: UIViews.....) warnings
        //
        describe("the result of between(...)") {
            it("should warns view being layouted cannot be used as one of the references") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.betweenH(aView, and: bView)
                expect(Pin.lastWarningText).to(contain(["betweenH((BasicView, Frame: (40.0, 100.0, 200.0, 100.0))", ") won't be applied",
                                                        "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should warns the view bottom edge view being layouted cannot be used as one of the references (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.betweenH(bView, and: cView)
                expect(Pin.lastWarningText).to(contain(["betweenH((BasicView, Frame: (0.0, 0.0, 0.0, 0.0))", "won't be applied",
                                                        "the view being layouted cannot be used as one of the references"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }

            it("should warns the view bottom edge view being layouted cannot be used as one of the references (2)") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 100)
                cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
                bView.pin.betweenH(aView, and: cView)
                expect(Pin.lastWarningText).to(contain(["betweenH(of: (BasicView, Frame: (40.0, 100.0, 200.0, 100.0))) won't be applied",
                                                                  "there is no horizontal space between these views"]))
                expect(bView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
            }


//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(aView, and: cView)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 0.0, width: 70.0, height: 50.0)))

//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 100, width: 110, height: 80)
//        bView.pin.betweenH(aView, and: cView, aligned: .top).marginHorizontal(4)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 70.0, height: 50.0)))

//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(cView, and: aView, aligned: .top)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 140.0, width: 70.0, height: 50.0)))


//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(aView, and: cView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 125.0, width: 70.0, height: 50.0)))

//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(cView, and: aView, aligned: .center)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 155.0, width: 70.0, height: 50.0)))


//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(aView, and: cView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 150.0, width: 70.0, height: 50.0)))

//        aView.frame = CGRect(x: 40, y: 100, width: 50, height: 100)
//        bView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        cView.frame = CGRect(x: 160, y: 140, width: 110, height: 80)
//        bView.pin.betweenH(cView, and: aView, aligned: .bottom)
//        expect(bView.frame).to(equal(CGRect(x: 90.0, y: 170.0, width: 70.0, height: 50.0)))
        }
    }
}
