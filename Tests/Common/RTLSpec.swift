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

class RTLSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
        var rootView: BasicView!
        var aView: BasicView!
        var bView: BasicView!
        
        /*
          root
           |
           |- aView
           |
            - bView
        */

        beforeEach {
            Pin.lastWarningText = nil
            Pin.layoutDirection(.ltr)
            
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            rootView.addSubview(aView)
            
            bView = BasicView()
            rootView.addSubview(bView)

            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
        }

        //
        // warnings
        //
        describe("warn") {
            it("should display a warning") {
                aView.pin.start(10).left(20)
                expect(Pin.lastWarningText).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                aView.pin.end(10).right(20)
                expect(Pin.lastWarningText).to(contain(["right", "won't be applied", "already been set to 10"]))
            }

            it("should display a warning") {
                Pin.layoutDirection(.auto)
                aView.pin.start(10).left(20)
                expect(Pin.lastWarningText).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.auto)
                aView.pin.end(10).right(20)
                expect(Pin.lastWarningText).to(contain(["right", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(10).left(20)
                expect(Pin.lastWarningText).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(10).right(20)
                expect(Pin.lastWarningText).to(contain(["right", "won't be applied", "already been set to 10"]))
            }

            it("should display a warning") {
                // With RTL
                Pin.layoutDirection(.rtl)
                aView.pin.start(10).right(20)
                expect(Pin.lastWarningText).to(contain(["right", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                // With RTL
                Pin.layoutDirection(.rtl)
                aView.pin.end(10).left(20)
                expect(Pin.lastWarningText).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
        }
        
        //
        // position
        //
        describe("RTL position") {
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(20)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(20)
                expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(20)
                expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end(20)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(20%)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(20%)
                expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(20%)
                expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end(20%)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(20)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(20)
                expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(20)
                expect(aView.frame).to(equal(CGRect(x: 280.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end(20)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(20%)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(20%)
                expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(20%)
                expect(aView.frame).to(equal(CGRect(x: 220.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end(20%)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("using insets") {
                Pin.layoutDirection(.rtl)
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.start(insets)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("using insets") {
                Pin.layoutDirection(.rtl)
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.end(insets)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("using insets") {
                Pin.layoutDirection(.ltr)
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.start(insets)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("using insets") {
                Pin.layoutDirection(.ltr)
                let insets = PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                aView.pin.end(insets)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        }
        
        //
        // margins
        //
        describe("RTL position") {
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start().end().marginStart(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 390.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start().end().marginStart(10)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 390.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start().end().marginEnd(10)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 390.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start().end().marginEnd(10)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 390.0, height: 60.0)))
            }
        }
        
        //
        // Edges
        //
        describe("RTL edges") {
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(to: bView.edge.start)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(to: bView.edge.start)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(to: bView.edge.end)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.start(to: bView.edge.end)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(to: bView.edge.start)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.end(to: bView.edge.start)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        }
        
        //
        // ANCHORS
        //
        describe("RTL anchors") {
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.topStart()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.topStart()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))
            }
        
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.topEnd()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 0.0, width: 100.0, height: 60.0)))
            
                Pin.layoutDirection(.rtl)
                aView.pin.topEnd()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.centerStart()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.centerStart()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.centerEnd()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.centerEnd()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 170.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.bottomStart()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.bottomStart()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.bottomEnd()
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.bottomEnd()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 340.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.topStart(to: bView.anchor.topStart)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.topStart(to: bView.anchor.topStart)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.topStart(to: bView.anchor.topEnd)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.topStart(to: bView.anchor.topEnd)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.topEnd(to: bView.anchor.topEnd)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.topEnd(to: bView.anchor.topEnd)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.centerStart(to: bView.anchor.centerStart)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 130.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.centerStart(to: bView.anchor.centerStart)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 130.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.centerEnd(to: bView.anchor.centerEnd)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 130.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.centerEnd(to: bView.anchor.centerEnd)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 130.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.bottomStart(to: bView.anchor.bottomStart)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.bottomStart(to: bView.anchor.bottomStart)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.bottomEnd(to: bView.anchor.bottomEnd)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 140.0, width: 100.0, height: 60.0)))
            }
        }
        
        //
        // relative
        //
        describe("RTL position") {
            // after
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.after(of: bView)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.after(of: bView)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.after(of: bView, aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.after(of: bView, aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.after(of: [bView])
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.after(of: [bView])
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.after(of: [bView], aligned: .bottom)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.after(of: [bView], aligned: .bottom)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            // before
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.before(of: bView)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.before(of: bView)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.before(of: [bView])
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.before(of: [bView])
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.before(of: bView, aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.before(of: bView, aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.before(of: [bView], aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.before(of: [bView], aligned: .top)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 120.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.before(of: [bView], aligned: .bottom)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.before(of: [bView], aligned: .bottom)
                expect(aView.frame).to(equal(CGRect(x: 270.0, y: 140.0, width: 100.0, height: 60.0)))
            }
            
            // below
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.below(of: bView, aligned: .start)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 200.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.below(of: bView, aligned: .start)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 200.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.ltr)
                aView.pin.below(of: bView, aligned: .end)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 200.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the position") {
                Pin.layoutDirection(.rtl)
                aView.pin.below(of: bView, aligned: .end)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 200.0, width: 100.0, height: 60.0)))
            }
        }

        // TODO
//        cView.pin.verticallyBetween(aView, and: bView, aligned: .start)
//        cView.pin.verticallyBetween(bView, and: aView, aligned: .start)
//
//        cView.pin.verticallyBetween(aView, and: bView, aligned: .end)
//        cView.pin.verticallyBetween(bView, and: aView, aligned: .end)

    }
}
