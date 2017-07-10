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

class JustifyAlignSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: BasicView!
        var aView: BasicView!
        
        /*
          root
           |
            - aView
        */
        
        beforeSuite {
            setUnitTest(displayScale: 2)
        }

        beforeEach {
            unitTestLastWarning = nil
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
        }
        
        //
        // justify + warning
        //
        describe("justify() should warn that the justify cannot be applied") {
            it("test when missing left and right coordinate") {
                aView.pin.justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.width(100).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.left().pinEdges().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when missing right coordinate") {
                aView.pin.left().width(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify", "center", "won't be applied", "left and right"]))
            }
            
            it("test when hCenter has been set") {
                aView.pin.hCenter(60).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify", "center", "won't be applied", "hCenter"]))
            }
        }
        
        //
        // align + warning
        //
        describe("align() should warn that the alignment cannot be applied") {
            it("test when missing top and bottom coordinate") {
                aView.pin.align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.width(100).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing left and right coordinate") {
                aView.pin.left().pinEdges().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when missing right coordinate") {
                aView.pin.left().width(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
            }
            
            it("test when hCenter has been set") {
                aView.pin.hCenter(60).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom"]))
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
