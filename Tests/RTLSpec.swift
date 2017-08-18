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

class RTLSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
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
            unitTestLastWarning = nil
            Pin.layoutDirection(.ltr)
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
            rootView.addSubview(bView)
        }

        //
        // warnings
        //
        describe("warn") {
            it("should display a warning") {
                aView.pin.start(10).left(20)
                expect(unitTestLastWarning).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                aView.pin.end(10).right(20)
                expect(unitTestLastWarning).to(contain(["right", "won't be applied", "already been set to 10"]))
            }

            it("should display a warning") {
                Pin.layoutDirection(.auto)
                aView.pin.start(10).left(20)
                expect(unitTestLastWarning).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.auto)
                aView.pin.end(10).right(20)
                expect(unitTestLastWarning).to(contain(["right", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.ltr)
                aView.pin.start(10).left(20)
                expect(unitTestLastWarning).to(contain(["left", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                Pin.layoutDirection(.ltr)
                aView.pin.end(10).right(20)
                expect(unitTestLastWarning).to(contain(["right", "won't be applied", "already been set to 10"]))
            }

            it("should display a warning") {
                // With RTL
                Pin.layoutDirection(.rtl)
                aView.pin.start(10).right(20)
                expect(unitTestLastWarning).to(contain(["right", "won't be applied", "already been set to 10"]))
            }
            
            it("should display a warning") {
                // With RTL
                Pin.layoutDirection(.rtl)
                aView.pin.end(10).left(20)
                expect(unitTestLastWarning).to(contain(["left", "won't be applied", "already been set to 10"]))
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
    }
}
