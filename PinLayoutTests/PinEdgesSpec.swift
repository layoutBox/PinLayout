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

class PinEdgesSpec: QuickSpec {
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
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            rootView.addSubview(aView)
        }

        //
        // top
        //
        describe("the result of top(...)") {
            it("should adjust the aView") {
                aView.pin.top()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(0)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.top()
                let noParameterFrame = aView.frame

                aView.pin.top(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
        }

        //
        // left
        //
        describe("the result of left(...)") {
            it("should adjust the aView") {
                aView.pin.left()
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(0)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.left()
                let noParameterFrame = aView.frame

                aView.pin.left(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
        }

        //
        // bottom
        //
        describe("the result of bottom(...)") {
            it("should adjust the aView") {
                aView.pin.bottom()
                expect(aView.frame).to(equal(CGRect(x: 140, y: 300.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(0)
                expect(aView.frame).to(equal(CGRect(x: 140, y: 300.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.bottom()
                let noParameterFrame = aView.frame

                aView.pin.bottom(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
        }

        //
        // right
        //
        describe("the result of right(...)") {
            it("should adjust the aView") {
                aView.pin.right()
                expect(aView.frame).to(equal(CGRect(x: 200, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(0)
                expect(aView.frame).to(equal(CGRect(x: 200, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should have the same position without or with a 0 parameter value") {
                aView.pin.right()
                let noParameterFrame = aView.frame

                aView.pin.right(0)
                expect(aView.frame).to(equal(noParameterFrame))
            }
        }
    }
}
