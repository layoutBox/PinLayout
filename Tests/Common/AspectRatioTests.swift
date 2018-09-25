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

class AspectRatioTests: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        var aView: BasicView!
        var bView: BasicView!

        #if os(iOS) || os(tvOS)
        var imageView: UIImageView!
        #endif
        
        /*
         root
         |
         - aView
         - bView
         - imageView
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
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            rootView.addSubview(aView)
            
            bView = BasicView()
            bView.frame = CGRect(x: 160, y: 120, width: 120, height: 40)
            rootView.addSubview(bView)

            #if os(iOS) || os(tvOS)
            imageView = UIImageView(image: UIImage(color: UIColor.red, size: CGSize(width: 100, height: 50)))
            imageView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
            rootView.addSubview(imageView)
            #endif
        }

        afterEach {
            _pinlayoutSetUnitTest(scale: nil)
            Pin.resetWarnings()
        }
        
        //
        // aspectRatio(: CGFloat)
        //
        describe("the result of the aspectRatio(CGFloat)") {
            #if os(iOS) || os(tvOS)
            it("should warn about fitSize()") {
                aView.pin.left().height(100).aspectRatio(2).sizeToFit(.width)
                expect(Pin.lastWarningText).to(contain(["sizeToFit(.width) won't be applied", "conflicts", "aspectRatio"]))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).sizeToFit(.width).aspectRatio(2)
                expect(Pin.lastWarningText).to(contain(["aspectRatio(2.0) won't be applied", "conflicts", "sizeToFit"]))
            }

            it("should warn about aspectRatio(:CGFloat)") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().height(100).sizeToFit(.height).aspectRatio(2)
                expect(Pin.lastWarningText).to(contain(["aspectRatio(2.0) won't be applied", "conflicts", "sizeToFit"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            #endif
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().aspectRatio(2)
                expect(Pin.lastWarningText).to(contain(["aspectRatio won't be applied", "neither the width nor the height can be determined"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().width(100%).aspectRatio(-2)
                expect(Pin.lastWarningText).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(-2)
                expect(Pin.lastWarningText).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().width(100%).aspectRatio(0)
                expect(Pin.lastWarningText).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(0)
                expect(Pin.lastWarningText).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should apply aspectRatio(:CGFloat)") {
                aView.pin.left().width(100%).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 200.0)))
            }
            
            it("should apply aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should apply aspectRatio(:CGFloat)") {
                aView.pin.left().width(100).aspectRatio(0.5)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 200.0)))
            }
            
            it("should apply aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(0.5)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 100.0)))
            
            }
        }
        
        //
        // aspectRatio(of: UIView)
        //
        describe("the result of the aspectRatio(of: UIView)") {
            it("should apply aspectRatio(of: UIView)") {
                aView.pin.left().width(100).aspectRatio(of: bView)
                let bViewRatio = bView.frame.width / bView.frame.height
                expect(aView.frame).to(beCloseTo(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 100 / bViewRatio), within: 0.5))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).aspectRatio(of: bView)
                let bViewRatio = bView.frame.width / bView.frame.height
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100 * bViewRatio, height: 100.0)))
            }
        }

        #if os(iOS) || os(tvOS)
        //
        // aspectRatio()
        //
        describe("the result of the aspectRatio(CGFloat)") {
            it("should warn about aspectRatio()") {
                aView.pin.left().width(100).aspectRatio()
                expect(Pin.lastWarningText).to(contain(["aspectRatio() won't be applied", "the layouted view must be an UIImageView()"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 100.0)))
            }

            it("should warn about aspectRatio() if no image is set") {
                imageView.image = nil
                imageView.pin.left().width(100).aspectRatio()
                expect(Pin.lastWarningText).to(contain(["aspectRatio() won't be applied", "the layouted UIImageView's image hasn't been set (aspectRatioImageNotSet)"]))
            }

            it("should not warn about aspectRatio() if no image is set") {
                Pin.activeWarnings.aspectRatioImageNotSet = false
                imageView.image = nil
                imageView.pin.left().width(100).aspectRatio()
                expect(Pin.lastWarningText).to(beNil())
                expect(imageView.frame).to(equal(CGRect(x: 0.0, y: 10.0, width: 100.0, height: 60.0)))
            }

//            guard Pin.logWarnings &&  else { return self }
//            warnWontBeApplied(")", context)
            
            it("should warn about aspectRatio()") {
                imageView.pin.left().aspectRatio()
                expect(Pin.lastWarningText).to(contain(["aspectRatio won't be applied", "neither the width nor the height can be determined"]))
                expect(imageView.frame).to(equal(CGRect(x: 0.0, y: 10.0, width: 60.0, height: 60.0)))
            }
            
            it("should apply aspectRatio()") {
                imageView.pin.left().width(200).aspectRatio()
                expect(imageView.frame).to(beCloseTo(CGRect(x: 0.0, y: 10, width: 200, height: 100), within: 0.5))
            }
        }
        #endif
        
        //
        // aspectRatio && min/max width/height
        //
        describe("the result of the aspectRatio(CGFloat)") {
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).aspectRatio(2).minWidth(240)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 240.0, height: 100.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).aspectRatio(2).maxWidth(140)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 140.0, height: 100.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().width(100).aspectRatio(2).minHeight(70)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 70.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().width(100).aspectRatio(2).maxHeight(30)
                    expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 30.0)))
            }

            it("should apply aspectRatio()") {
                aView.pin.left().width(100).maxWidth(80).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 80.0, height: 40.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().width(100).minWidth(100).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 50.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().width(100).maxWidth(80).aspectRatio(2).maxHeight(30)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 80.0, height: 30.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).maxHeight(80).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 160.0, height: 80.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).minHeight(120).aspectRatio(2)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 240.0, height: 120.0)))
            }
            
            it("should apply aspectRatio()") {
                aView.pin.left().height(100).maxHeight(80).aspectRatio(2).maxWidth(140)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 140.0, height: 80.0)))
            }
        }
    }
}
