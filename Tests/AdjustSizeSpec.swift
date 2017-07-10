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
            it("should adjust the width of aView") {
                aView.pin.width(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 35, height: 60.0)))
            }

            it("shouldn't adjust the width of aView due to a negative width") {
                aView.pin.width(-20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100, height: 60.0)))
            }

            it("should adjust the width(percent: Percent) of aView") {
                aView.pin.width(50%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 200, height: 60)))
            }
            
            it("should adjust the width(percent: Percent) of aView") {
                aView.pin.width(200%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 800, height: 60)))
            }

            it("should not adjust the width(percent: Percent) of aView due to a negative width") {
                aView.pin.width(-20%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 60)))
            }

            it("should adjust the width(percent: Percent) of aView") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 30))
                unAttachedView.pin.width(50%)
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 20, height: 30)))
            }

            it("should adjust the width of aView") {
                aView.pin.width(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 60.0)))
            }
        
            // Negative width
            it("should adjust the left but warn that the width won't be applied due to a negative width") {
                aView.pin.left(300).right(300)
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["computed width (-200.0)", "greater than or equal to zero", "view will keep its current width"]))
            }
        }
        
        describe("the result of the height(...) methods") {
            it("should adjust the height of aView") {
                aView.pin.height(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 35.0)))
            }

            it("should not adjust the height of aView") {
                aView.pin.height(-20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.height(50%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 200)))
            }

            it("should adjust the height of aView") {
                aView.pin.height(200%)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100, height: 800)))
            }

            it("should adjust the height of aView") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 20, height: 30))
                unAttachedView.pin.height(50%)
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 20, height: 30)))
            }

            it("should adjust the height of aView") {
                aView.pin.height(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 30.0)))
            }
            
            // Negative height
            it("should adjust the top but warn that the height won't be applied due to a negative height") {
                aView.pin.top(300).bottom(300)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 300.0, width: 100.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["computed height (-200.0)", "greater than or equal to zero", "view will keep its current height"]))
            }
        }
        
        describe("the result of the size(...) methods") {
        
            it("should adjust the size of aView") {
                aView.pin.size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 25.0, height: 25.0)))
            }
            
            it("should adjust the size of aView") {
                aView.pin.size(100)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 100.0)))
            }
            
            it("should adjust the size of aView") {
                aView.pin.size(50%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 200.0)))
            }
            
            it("should warn that size()'s width won't be applied") {
                aView.pin.width(90).size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 25.0)))
                expect(unitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s height won't be applied") {
                aView.pin.height(90).size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 25.0, height: 90.0)))
                expect(unitTestLastWarning).to(contain(["size", "height", "won't be applied", "value has already been set"]))
            }
            
            it("should adjust the size of aView by calling a size(...) method") {
                aView.pin.size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should warn that size(of)'s width won't be applied") {
                aView.pin.width(90).size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 30.0)))
                expect(unitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s width won't be applied") {
                aView.pin.width(90).size(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 20.0)))
                expect(unitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s width won't be applied") {
                aView.pin.width(90).size(50%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 200.0)))
                expect(unitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
        }

        //
        // sizeToFit
        //
        describe("the result of the sizeToFit() method") {
            it("should adjust the size of aView by calling sizeToFit() method without having specified width and height") {
                aView.pin.sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should adjust the size and position the view by calling center(), height() and sizeToFit()") {
                aViewChild.pin.center(to: aView.anchor.center).height(40).sizeToFit()
                expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the size and position the view by calling center(), width() and sizeToFit()") {
                aViewChild.pin.center(to: aView.anchor.center).width(20).sizeToFit()
                expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))
            }
        }
        
        describe("the result of the sizeToFit() method when pinning left and right edges") {
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 300.0, height: 5.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).marginLeft(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 290.0, height: 6)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 290.0, height: 6.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).sizeToFit().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).sizeToFit().justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
        }
        
        describe("the result of the sizeToFit() method when pinning top and bottom edges") {
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 20.0, width: 5.5, height: 300)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6, height: 290)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 20.0, width: 6, height: 290)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6, height: 280)))
            }
        }
        
        
        describe("the result of the sizeToFit() method when pinning right edge + width") {
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).marginLeft(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).marginLeft(10).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 200, height: 8)))
            }
        }
        
        describe("the result of the sizeToFit() method when pinning right edge + width + pinEdges()") {
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 190, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 190, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 180, height: 9)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).marginRight(10).sizeToFit().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 180, height: 9)))
            }

            it("should adjust the size with sizeToFit() and distribute extra width") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).marginBottom(10).sizeToFit().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 9, height: 180)))
            }
        }

        describe("the result of the sizeToFit() method when pinning bottom edge + height") {
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 90.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginTop(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 90.0, width: 8, height: 200)))
            }
        }
        
        describe("the result of the sizeToFit() method when pinning bottom edge + height + pinEdges()") {
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 8.5, height: 190)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8.5, height: 190)))
            }
            
            it("should adjust the size with sizeToFit() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 9, height: 180)))
            }
        }
        
        describe("the result of the sizeToFit() method when pinning top, left, bottom and right edges") {
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 200.0, height: 8)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 30.0, width: 200.0, height: 8)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 200.0, height: 8.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginTop(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).marginBottom(10).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(15).marginRight(5).marginTop(10).sizeToFit().justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 35.0, y: 30.0, width: 180.0, height: 9)))
            }

            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit().align(.top)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).sizeToFit().align(.center)
                expect(aView.frame).to(beCloseTo(CGRect(x: 30.0, y: 120.5, width: 180.0, height: 9.0), within: 0.5))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).left(20).bottom(80).right(180).marginLeft(15).marginRight(5).marginTop(10).sizeToFit().align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 35.0, y: 311.0, width: 180.0, height: 9.0)))
            }
            
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).sizeToFit().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6.0, height: 280.0)))
            }
            
            it("should adjust the size with sizeToFit()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).sizeToFit().align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6.0, height: 280.0)))
            }
        }
        
        describe("the result of the sizeToFit(...) methods") {
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.height(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit()") {
                aView.pin.top(0).height(70).width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 100.0, height: 16.0)))
            }

            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.height(90).width(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(80).width(of: aViewChild).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 20.0)))
            }

            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.height(100).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.height(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0), within: 0.4))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(90).height(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit() method") {
                aView.pin.width(90).size(of: aViewChild).sizeToFit()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
        }
    }
}
