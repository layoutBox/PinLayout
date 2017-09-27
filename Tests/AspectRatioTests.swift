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

class AspectRatioTests: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: BasicView!
        var aView: BasicView!
        var bView: BasicView!
        var imageView: UIImageView!
        
        /*
         root
         |
         - aView
         - bView
         - imageView
         */
        
        beforeSuite {
            _pinlayoutSetUnitTest(displayScale: 2)
        }
        
        beforeEach {
            _pinlayoutUnitTestLastWarning = nil
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            rootView.addSubview(aView)
            
            bView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            bView.frame = CGRect(x: 160, y: 120, width: 120, height: 40)
            rootView.addSubview(bView)
            
            imageView = UIImageView(image: UIImage(color: UIColor.red, size: CGSize(width: 100, height: 50)))
            imageView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
            rootView.addSubview(imageView)
        }
        
        //
        // aspectRatio(: CGFloat)
        //
        describe("the result of the aspectRatio(CGFloat)") {
            it("should warn about fitSize()") {
                aView.pin.left().width(100%).aspectRatio(2).fitSize()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["fitSize() won't be applied", "conflicts", "aspectRatio"]))
            }
            
            it("should warn about fitSize()") {
                aView.pin.left().height(100).aspectRatio(2).fitSize()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["fitSize() won't be applied", "conflicts", "aspectRatio"]))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).fitSize().aspectRatio(2)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio(2.0) won't be applied", "conflicts", "fitSize"]))
            }

            it("should warn about aspectRatio(:CGFloat)") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().height(100).fitSize().aspectRatio(2)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio(2.0) won't be applied", "conflicts", "fitSize"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().aspectRatio(2)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio won't be applied", "neither the width nor the height can be determined"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().width(100%).aspectRatio(-2)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(-2)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().width(100%).aspectRatio(0)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 400.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio(:CGFloat)") {
                aView.pin.left().height(100).aspectRatio(0)
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio", "won't be applied", "must be greater than zero"]))
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
        
        //
        // aspectRatio()
        //
        describe("the result of the aspectRatio(CGFloat)") {
            it("should warn about aspectRatio()") {
                aView.pin.left().width(100).aspectRatio()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio() won't be applied", "the layouted must be an UIImageView()"]))
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 100.0)))
            }
            
            it("should warn about aspectRatio()") {
                imageView.pin.left().aspectRatio()
                expect(_pinlayoutUnitTestLastWarning).to(contain(["aspectRatio won't be applied", "neither the width nor the height can be determined"]))
                expect(imageView.frame).to(equal(CGRect(x: 0.0, y: 10.0, width: 60.0, height: 60.0)))
            }
            
            it("should apply aspectRatio()") {
                imageView.pin.left().width(200).aspectRatio()
                expect(imageView.frame).to(beCloseTo(CGRect(x: 0.0, y: 10, width: 200, height: 100), within: 0.5))
            }
        }
        
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
        }
    }
}
