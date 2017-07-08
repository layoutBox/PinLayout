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

class MarginsSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var rootView: BasicView!
        var aView: BasicView!
        
        /*
          root
           |
            - aView
                |
                 - aViewChild
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
            rootView.addSubview(aView)
        }

        //
        // left&right margins
        //
        describe("the result of left&right margins when only the width is specified") {
            it("should adjust the aView") {
                aView.pin.width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins when the left coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins when the right coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.right(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(20)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right margins when the left and right coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(20)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
        
       
        //
        // top&bottom margins
        //
        // TODO: DO top and bottom !!! duplicate everything above!
        describe("the result of top&bottom margins when only the height is specified") {
            it("should adjust the aView") {
                aView.pin.height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.height(100 - 20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 80.0)))
            }
        }
        
        describe("the result of top&bottom margins when the top coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
        }
        
        //
        // bottom & height
        //
        describe("the result of top&bottom margins when the bottom coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
        }
        
        //
        // top & bottom
        //
        describe("the result of top&bottom margins when the top and bottom coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should obtain the same result with or without pinEdges()") {
                aView.pin.top(140).bottom(160).margin(10)
                let frameWithoutPinEdgest = aView.frame

                aView.pin.top(140).bottom(160).pinEdges().margin(10)

                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginTop(20).marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 60.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
        }
        
        //
        // hCenter
        //
        describe("the result of top&bottom margins when the hCenter is specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should obtain the same result with or without pinEdges()") {
                aView.pin.hCenter(100).margin(10)
                let frameWithoutPinEdgest = aView.frame
                
                aView.pin.hCenter(100).pinEdges().margin(10)
                
                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 90, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 50, y: 100.0, width: 90, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 50.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 50.0, height: 100.0)))
            }
        }
        
        //
        // vCenter
        //
        describe("the result of top&bottom margins when the vCenter is specified") {
            it("should adjust the aView") {
                aView.pin.vCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 60.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 60.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(20).marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 70.0, width: 200.0, height: 60.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 60.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 90.0)))
            }
            it("should adjust the aView") {
                aView.pin.vCenter(50%).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 120.0)))
            }
        }
        
        //
        // hCenter and vCenter
        //
        describe("the result of top&bottom margins when the hCenter and vCenter are specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 40.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).width(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 40.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(50%).vCenter(50%)
                expect(aView.frame).to(equal(CGRect(x: 100, y: 140, width: 200.0, height: 120.0)))
            }
        }
    }
}
