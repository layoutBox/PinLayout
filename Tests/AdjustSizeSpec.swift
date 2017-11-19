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
            _pinlayoutSetUnitTest(displayScale: 2)
        }

        beforeEach {
            _pinlayoutUnitTestLastWarning = nil
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
            
            aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
            aView.addSubview(aViewChild)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            rootView.addSubview(bView)
            
            bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
            bView.addSubview(bViewChild)
            
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
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
                expect(_pinlayoutUnitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s height won't be applied") {
                aView.pin.height(90).size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 25.0, height: 90.0)))
                expect(_pinlayoutUnitTestLastWarning).to(contain(["size", "height", "won't be applied", "value has already been set"]))
            }
            
            it("should adjust the size of aView by calling a size(...) method") {
                aView.pin.size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should warn that size(of)'s width won't be applied") {
                aView.pin.width(90).size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 30.0)))
                expect(_pinlayoutUnitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s width won't be applied") {
                aView.pin.width(90).size(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 20.0)))
                expect(_pinlayoutUnitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
            
            it("should warn that size()'s width won't be applied") {
                aView.pin.width(90).size(50%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 200.0)))
                expect(_pinlayoutUnitTestLastWarning).to(contain(["size", "width", "won't be applied", "value has already been set"]))
            }
        }

        //
        // fitSize
        //
        describe("the result of the fitSize() method") {
            it("should not adjust the size of aView if width or height has not been specified") {
                aView.pin.fitSize()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["fitSize() won't be applied", "neither the width nor the height can be determined"]))                
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.size(of: aViewChild).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.size(CGSize(width: 20, height: 100)).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit(.height) method") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should adjust the size of aView by calling sizeToFit(.width) method") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.size(CGSize(width: 20, height: 100)).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should adjust the size and position the view by calling center(), height() and fitSize()") {
                aViewChild.pin.center(to: aView.anchor.center).height(40).fitSize()
                expect(aViewChild.frame).to(equal(CGRect(x: 30.0, y: 10.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the size and position the view by calling center(), width() and fitSize()") {
                aViewChild.pin.center(to: aView.anchor.center).width(20).fitSize()
                expect(aViewChild.frame).to(equal(CGRect(x: 40.0, y: -10.0, width: 20.0, height: 80.0)))
            }
        }
        
        describe("the result of the fitSize() method when pinning left and right edges") {
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 300.0, height: 5.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).marginLeft(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 290.0, height: 6)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 290.0, height: 6.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).fitSize().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.left(20).right(80).marginLeft(10).marginRight(10).fitSize().justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 280.0, height: 6.0)))
            }
        }
        
        describe("the result of the fitSize() method when pinning top and bottom edges") {
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 20.0, width: 5.5, height: 300)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6, height: 290)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 20.0, width: 6, height: 290)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6, height: 280)))
            }
        }
        
        describe("the result of the fitSize() method when pinning right edge + width") {
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).marginLeft(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).marginLeft(10).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 90.0, y: 100.0, width: 200, height: 8)))
            }
        }
        
        describe("the result of the fitSize() method when pinning right edge + width + pinEdges()") {
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().fitSize()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200, height: 8)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 190, height: 8.5)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 190, height: 8.5)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 180, height: 9)))
            }
            
            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.right(100).width(200).pinEdges().marginLeft(10).marginRight(10).fitSize().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 110.0, y: 100.0, width: 180, height: 9)))
            }

            it("should adjust the size with fitSize() and distribute extra width") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).marginBottom(10).fitSize().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 9, height: 180)))
            }
        }

        describe("the result of the fitSize() method when pinning bottom edge + height") {
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 90.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 90.0, width: 8, height: 200)))
            }
        }
        
        describe("the result of the fitSize() method when pinning bottom edge + height + pinEdges()") {
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8, height: 200)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 8.5, height: 190)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 8.5, height: 190)))
            }
            
            it("should adjust the size with fitSize() and distribute extra height") {
                aView.pin.bottom(100).height(200).pinEdges().marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 110.0, width: 9, height: 180)))
            }
        }
        
        describe("the result of the fitSize() method when pinning top, left, bottom and right edges") {
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 200.0, height: 8)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 30.0, width: 200.0, height: 8)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 200.0, height: 8.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 190.0, height: 8.5)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 20.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).marginBottom(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9.0)))
            }
        }
        
        describe("the result of the fitSize() with justify() or align()") {
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).fitSize().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).fitSize().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(15).marginRight(5).marginTop(10).fitSize().justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 35.0, y: 30.0, width: 180.0, height: 9)))
            }

            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).fitSize().align(.top)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 30.0, width: 180.0, height: 9)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(180).right(180).marginLeft(10).marginRight(10).marginTop(10).fitSize().align(.center)
                expect(aView.frame).to(beCloseTo(CGRect(x: 30.0, y: 120.5, width: 180.0, height: 9.0), within: 0.5))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).left(20).bottom(80).right(180).marginLeft(15).marginRight(5).marginTop(10).fitSize().align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 35.0, y: 311.0, width: 180.0, height: 9.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).fitSize().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6.0, height: 280.0)))
            }
            
            it("should adjust the size with fitSize()") {
                aView.pin.top(20).bottom(80).marginTop(10).marginBottom(10).fitSize().align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 6.0, height: 280.0)))
            }
        }
        
        //
        // fitSize()
        //
        describe("the result of the fitSize() method") {
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should adjust the size of aView by calling fitSize()") {
                aView.pin.top(0).height(70).width(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 100.0, height: 16.0)))
            }

            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(90).width(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(of: aViewChild).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(80).width(of: aViewChild).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 20.0)))
            }

            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(100).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(of: aViewChild).fitSize()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0), within: 0.4))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(90).height(of: aViewChild).fitSize()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.size(of: aViewChild).fitSize()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(90).size(of: aViewChild).fitSize()
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 17.6), within: 0.4))
            }
        }
        
        //
        // fitSize && min/max width/height
        //
        describe("the result of the fitSize() method when min/max width/height are set") {
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(100).minHeight(20).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 20.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.width(100).maxHeight(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 10.0)))
            }
            
            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(100).maxWidth(10).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 10.0, height: 100.0)))
            }

            it("should adjust the size of aView by calling fitSize() method") {
                aView.pin.height(100).minWidth(20).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
        }
        
        //
        // fitHeight && fitWidth
        //
        describe("the result of the sizeToFit(.height) && sizeToFit(.width)") {
            it("should warn method") {
                aView.pin.width(100).fitSize().sizeToFit(.width)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["sizeToFit(.width)", "won't be applied", "conflicts with fitSize()"]))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
        
            it("should warn method") {
                aView.pin.width(100).fitSize().sizeToFit(.height)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["sizeToFit(.height)", "won't be applied", "conflicts with fitSize()"]))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
        
            it("should warn method") {
                aView.pin.width(100).aspectRatio(2).sizeToFit(.width)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["sizeToFit(.width)", "won't be applied", "aspectRatio: 2"]))
            }
            
            it("should warn method") {
                aView.pin.sizeToFit(.width).aspectRatio(2)
                expect(_pinlayoutUnitTestLastWarning).to(contain([" aspectRatio(2.0)", "won't be applied", "conflicts with sizeToFit(.width)"]))
            }
            
            it("should warn method") {
                aView.pin.width(100).fitSize().aspectRatio(2)
                expect(_pinlayoutUnitTestLastWarning).to(contain([" aspectRatio(2.0)", "won't be applied", "conflicts with fitSize()"]))
            }
        }
        
        //
        // fitWidth
        //
        describe("the result of the sizeToFit(.width)") {
            it("should adjust the aView") {
                aView.pin.sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
        
            it("should adjust the aView") {
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.minWidth(160).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 160.0, height: 10.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.maxWidth(50).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
        }
        
        //
        // fitHeight
        //
        describe("the result of the sizeToFit(.height)") {
            it("should adjust the aView") {
                aView.pin.sizeToFit(.height)
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 27, height: 60.0), within: 0.5))
            }
            
            it("should adjust the aView") {
                aView.pin.height(50).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.minHeight(160).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 10.0, height: 160.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.maxHeight(50).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))
            }
        }
        
        //
        // sizeToFit(.width)
        //
        describe("the result of the sizeToFit(.width) when the value return by sizeThatFits() is smaller then the width") {
            it("should adjust the aView") {
                aView.pin.sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 40.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.width(50).sizeToFit(.widthFlexible)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 40.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 160.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.widthFlexible)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 10.0, height: 160.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.size(CGSize(width: 20, height: 100)).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 20.0, height: 160.0)))
            }
        }
        
        //
        // sizeToFit(.height)
        //
        describe("the result of the sizeToFit(.height) when the value return by sizeThatFits() is smaller then the width") {
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 60.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.sizeToFit(.heightFlexible)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 60.0)))
            }
        
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.sizeToFit(.heightFlexible)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))
            }
        }
        
        //
        // fitSize() / sizeToFit(..)
        //
        describe("the result of the fitSize()") {
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.width(50).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))
            }

            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 40.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = 10
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6), within: 0.5))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = 10
                aView.pin.width(50).sizeToFit(.width)
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 26.6), within: 0.5))
            }
        
            it("should adjust the aView") {
                aView.pin.height(50).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 32.0, height: 50.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.height(50).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = -10
                aView.pin.height(50).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 50.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = 10
                aView.pin.height(30).fitSize()
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 30.0)))
            }
            
            it("should adjust the aView") {
                aView.sizeThatFitSizeOffset = 10
                aView.pin.height(30).sizeToFit(.height)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 40.0, height: 30.0)))
            }
        }
    }
}
