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

class AdjustSizeSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
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
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
            
            aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the width(...) methods") {
            it("should ajust the width of aView") {
                aView.pin.width(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 35, height: 60.0)))
            }

            it("should not ajust the width of aView") {
                aView.pin.width(-20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100, height: 60.0)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                aView.pin.width(percent: 50)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 200, height: 60)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                aView.pin.width(percent: 200)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 800, height: 60)))
            }

            it("should not adjust the width(percent: CGFloat) of aView") {
                aView.pin.width(percent: -20)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 60)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 30))
                unAttachedView.pin.width(percent: 50)
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 20, height: 30)))
            }

            it("should ajust the width of aView") {
                aView.pin.width(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 60.0)))
            }
        }
        
        describe("the result of the height(...) methods") {
            it("should ajust the height of aView") {
                aView.pin.height(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 35.0)))
            }

            it("should not ajust the height of aView") {
                aView.pin.height(-20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                aView.pin.height(percent: 50)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 200)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                aView.pin.height(percent: 200)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 800)))
            }

            it("should ajust the width(percent: CGFloat) of aView") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 30))
                unAttachedView.pin.height(percent: 50)
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 20, height: 30)))
            }

            it("should ajust the height of aView") {
                aView.pin.height(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 30.0)))
            }
        }
        
        describe("the result of the size(...) methods") {
        
            it("should ajust the size of aView") {
                aView.pin.size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 25.0, height: 25.0)))
            }
            
            it("should warn that size() won't be applied") {
                aView.pin.width(90).size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
            
            it("should ajust the size of aView by calling a size(...) method") {
                aView.pin.size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should warn that size(of) won't be applied") {
                aView.pin.width(90).size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
        }

        //
        // sizeToFit
        //
        describe("the result of the sizeToFit() method") {
            it("should ajust the size of aView by calling sizeToFit() method without having specified width and height") {
                aView.pin.sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
        
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.width(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
        
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.height(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
        
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.height(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0), within: 0.3))
            }
        
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should ajust the size of aView by calling sizeToFit() method") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should ajust the size and position the view by calling center(), height() and sizeToFit()") {
                aViewChild.pin.center(to: aView.anchor.center).height(40).sizeToFit()
                expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))
            }
            
            it("should ajust the size and position the view by calling center(), width() and sizeToFit()") {
                aViewChild.pin.center(to: aView.anchor.center).width(20).sizeToFit()
                expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))
            }
        }
        
        describe("the result of the sizeThatFits(...) methods") {
            
            it("should ajust the size of aView by calling sizeThatFits(size: CGSize) method") {
                aView.pin.width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(size) method") {
                aView.pin.height(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits") {
                aView.pin.top(0).height(70).width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 100.0, height: 16.0)))
            }

            it("should ajust the size of aView by calling sizeThatFits(width: CGFloat) method") {
                aView.pin.width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should warn that sizeThatFits(width:) won't be applied") {
                aView.pin.height(90).width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(widthOf: UIView) method") {
                aView.pin.width(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should warn that sizeThatFits(widthOf:) won't be applied") {
                aView.pin.width(80).width(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 20.0)))
            }

            it("should ajust the size of aView by calling sizeThatFits(height: CGFloat) method") {
                aView.pin.height(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should warn that sizeThatFits(height:) won't be applied") {
                aView.pin.width(90).height(100).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(heightOf: UIView) method") {
                aView.pin.height(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0), within: 0.4))
            }
            
            it("should warn that sizeThatFits(heightOf:) won't be applied") {
                aView.pin.width(90).height(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(sizeOf: UIView) method") {
                aView.pin.size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should warn that sizeThatFits(sizeOf:) won't be applied") {
                aView.pin.width(90).size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
        }
    }
}
