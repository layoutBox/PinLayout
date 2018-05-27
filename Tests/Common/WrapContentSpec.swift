//  Copyright (c) 2018 Luc Dion
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

class WrapContentSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        
        /*
          root
           |
            - aView
           |    |
           |    |- aViewChild
                |- aViewChild2
                |- aViewChild3
        */
        var aView: BasicView!
        var aViewChild: BasicView!
        var aViewChild2: BasicView!
        var aViewChild3: BasicView!

        beforeSuite {
            _pinlayoutSetUnitTest(displayScale: 2)
        }

        beforeEach {
            Pin.lastWarningText = nil
            
            viewController = PViewController()
            viewController.view = BasicView()

            rootView = BasicView()
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aView.addSubview(aViewChild)

            aViewChild2 = BasicView()
            aView.addSubview(aViewChild2)

            aViewChild3 = BasicView()
            aView.addSubview(aViewChild3)

            rootView.frame = CGRect(x: 0, y: 100, width: 400, height: 400)
        }

        describe("wrapContent") {
            it("wrap and update subviews position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent()

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 260.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 200.0, y: 0.0, width: 60.0, height: 60.0)))
            }

            it("wrapContent(.all) should have the same result") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent(.all)

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 260.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 200.0, y: 0.0, width: 60.0, height: 60.0)))
            }

            it("wrapContent(.width) + wrapContent(.height) should have the same result") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent(.width)
                aView.pin.wrapContent(.height)

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 260.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 200.0, y: 0.0, width: 60.0, height: 60.0)))
            }

            it("wrapContent(.all) and update subviews position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent(.all)

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 260.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 100.0, y: 0.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 200.0, y: 0.0, width: 60.0, height: 60.0)))
            }

            it("wrapContent(.width) and update subviews position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent(.width)

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 260.0, height: 100.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 120.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 100.0, y: 120.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 200.0, y: 120.0, width: 60.0, height: 60.0)))
            }
            it("wrapContent(.height) and update subviews position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 260, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 360, y: 120, width: 60, height: 60)

                aView.pin.wrapContent(.height)

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 200.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 160.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 260.0, y: 0.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 360.0, y: 0.0, width: 60.0, height: 60.0)))
            }
            it("wrap and update subviews position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 180, y: 140, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 220, y: 180, width: 60, height: 60)

                aView.pin.wrapContent()

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 120.0, height: 120.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 60.0, y: 60.0, width: 60.0, height: 60.0)))
            }

            it("wrap when views are of size zero") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: 160, y: 120, width: 0, height: 0)
                aViewChild2.frame = CGRect(x: 180, y: 140, width: 0, height: 0)
                aViewChild3.frame = CGRect(x: 220, y: 180, width: 0, height: 0)

                aView.pin.wrapContent()

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 60.0, height: 60.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 0.0, height: 0.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 60.0, y: 60.0, width: 0.0, height: 0.0)))
            }

            it("wrap with subviews with negative position") {
                aView.frame = CGRect(x: 20, y: 10, width: 200, height: 100)
                aViewChild.frame = CGRect(x: -40, y: -40, width: 100, height: 40)
                aViewChild2.frame = CGRect(x: 350, y: 120, width: 60, height: 60)
                aViewChild3.frame = CGRect(x: 350, y: -100, width: 60, height: 60)

                aView.pin.wrapContent()

                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 450.0, height: 280.0)))
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 60.0, width: 100.0, height: 40.0)))
                expect(aViewChild2.frame).to(equal(CGRect(x: 390.0, y: 220.0, width: 60.0, height: 60.0)))
                expect(aViewChild3.frame).to(equal(CGRect(x: 390.0, y: 0.0, width: 60.0, height: 60.0)))
            }
            it("wrap and update subviews position") {

            }
            it("wrap and update subviews position") {
                // warning
                aView.pin.wrapContent().width(20)
            }

            it("wrap and update subviews position") {
                // warning
                aView.pin.width(20).wrapContent()
            }

            it("wrap and update subviews position") {
                // warning
                aView.pin.height(20).wrapContent()
            }
        }
    }
}
