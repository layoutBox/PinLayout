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

class RelativePositionMultipleViewsSpec: QuickSpec {
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
            _pinlayoutSetUnitTest(scale: 2)
            Pin.lastWarningText = nil

            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)
            
            bView = BasicView()
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        afterEach {
            _pinlayoutSetUnitTest(scale: nil)
        }
        
        //
        // above(of: UIViews.....) warnings
        //
        describe("the result of above(of: UIView...) with multiple relative views") {
            it("should warns the view bottom edge") {
                let unatachedView = PView()
                bViewChild.pin.above(of: unatachedView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40, y: 10, width: 60, height: 20)))
                expect(Pin.lastWarningText).to(contain(["above(of: (", ")", "won't be applied",
                                                        "must be added as a sub-view before being used as a reference."]))
            }

            it("should warns the view bottom edge") {
                let unatachedView = PView()
                bViewChild.pin.above(of: unatachedView, aligned: .left)
                expect(bViewChild.frame).to(equal(CGRect(x: 40, y: 10, width: 60, height: 20)))
                expect(Pin.lastWarningText).to(contain(["above(of: ", ", aligned: .left)", "won't be applied",
                                                        "must be added as a sub-view before being used as a reference."]))
            }
            
            it("should warns the view bottom edge") {
                let unatachedView = PView()
                bViewChild.pin.above(of: [aView, unatachedView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
                expect(Pin.lastWarningText).to(contain(["above", "won't be applied", "the reference view",
                                                        "must be added as a sub-view before being used as a reference."]))
            }
            
            it("Should warn, but the view should be anyway layout it above") {
                let unatachedView = PView()
                bViewChild.pin.above(of: [aView, unatachedView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
                expect(Pin.lastWarningText).to(contain(["above(of: [", "])", "won't be applied",
                                                        "the reference view", "must be added", "as a reference"]))
            }

            it("Should warn, but the view should be anyway layout it above") {
                let unatachedView = PView()
                bViewChild.pin.above(of: [aView, unatachedView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: -40.0, width: 60.0, height: 20.0)))
                expect(Pin.lastWarningText).to(contain(["above(of: [", "], aligned: .center)", "won't be applied", "the reference view", "must be added", "as a reference"]))
            }
        }
        
        //
        // above(of: UIViews.....)
        //
        describe("the result of above(of: UIView...) with multiple relative views") {
            it("should move the view above relative views") {
                bViewChild.pin.above(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .left)
                expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: -40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .right)
                expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .right).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .left).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: -50.0, width: 60.0, height: 20.0)))
            }
        }
    
        //
        // below(of: UIViews.....)
        //
        describe("the result of below(of: UIView...) with multiple relative views") {
            it("should move the view below relative views") {
                bViewChild.pin.below(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .left)
                expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .right)
                expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: 40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .right).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 90.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .left).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: 90.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 90.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center).marginLeft(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -27.5, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center).marginRight(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -47.5, y: 80.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // left(of: UIViews.....)
        //
        describe("the result of left(of: UIView...) with multiple relative views") {
            it("should move the view left relative views") {
                bViewChild.pin.left(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [bView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: -60.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .top)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: -20.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 60.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 0.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 15.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .bottom).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 50.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .top).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: -10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 15.0, width: 60.0, height: 20.0)))
            }

            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center).marginTop(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 25.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center).marginBottom(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 5.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // right(of: UIViews.....)
        //
        describe("the result of right(of: UIView...) with multiple relative views") {
            it("should move the view right relative views") {
                bViewChild.pin.right(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .top)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: -20.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 60.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 0.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 15.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .bottom).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 50.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .top).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: -10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 15.0, width: 60.0, height: 20.0)))
            }

            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center).marginTop(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 25.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center).marginBottom(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 5.0, width: 60.0, height: 20.0)))
            }
        }
    }
}
