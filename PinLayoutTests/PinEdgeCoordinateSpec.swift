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

class PinEdgeCoordinateSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: UIView!
        
        var aView: UIView!
        var aViewChild: UIView!
        
        var bView: UIView!
        var bViewChild: UIView!
        
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
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = UIView()
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = UIView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)

            bView = UIView()
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = UIView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the top(edge: VerticalEdge, of: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.pin.top(to: aView.edge.top)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
        }
        
        //
        // top
        //
        describe("the result of the top(edge: VerticalEdge, of: UIView)") {
            
            it("should position the aViewChild's top edge on its parent's top edge") {
                aViewChild.pin.top(to: aView.edge.top)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 0.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's top edge on its parent sibling (bView)'s top edge") {
                aViewChild.pin.top(to: bView.edge.top)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 100.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's top edge on its sibling's children (aViewChild)'s top edge") {
                bViewChild.pin.top(to: aViewChild.edge.top)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -80.0, width: 60.0, height: 20.0)))
            }
            
            it("should position the aViewChild's top edge on its parent's bottom edge") {
                aViewChild.pin.top(to: aView.edge.bottom)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 60.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's top edge on its parent sibling (bView)'s bottom edge") {
                aViewChild.pin.top(to: bView.edge.bottom)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 180.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's top edge on its sibling's children (aViewChild)'s bottom edge") {
                bViewChild.pin.top(to: aViewChild.edge.bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // left
        //
        describe("the result of the left(edge: VerticalEdge, of: UIView)") {
            
            it("should position the aViewChild's left edge on its parent's left edge") {
                aViewChild.pin.left(to: aView.edge.left)
                expect(aViewChild.frame).to(equal(CGRect(x: 0.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's left edge on its parent sibling (bView)'s left edge") {
                aViewChild.pin.left(to: bView.edge.left)
                expect(aViewChild.frame).to(equal(CGRect(x: 20.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's left edge on its sibling's children (aViewChild)'s left edge") {
                bViewChild.pin.left(to: aViewChild.edge.left)
                expect(bViewChild.frame).to(equal(CGRect(x: -10.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should position the aViewChild's left edge on its parent's right edge") {
                aViewChild.pin.left(to: aView.edge.right)
                expect(aViewChild.frame).to(equal(CGRect(x: 100.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the aViewChild's left edge on its parent sibling (bView)'s right edge") {
                aViewChild.pin.left(to: bView.edge.right)
                expect(aViewChild.frame).to(equal(CGRect(x: 130.0, y: 20.0, width: 50.0, height: 30.0)))
            }
            
            it("should position the bViewChild's left edge on its sibling's children (aViewChild)'s right edge") {
                bViewChild.pin.left(to: aViewChild.edge.right)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 60.0, height: 20.0)))
            }
        }

        //
        // bottom
        //
        describe("the result of the bottom(edge: HorizontalEdge, of: UIView)") {

            it("should position the aViewChild's left edge on its parent's left edge") {
                aViewChild.pin.bottom(to: aView.edge.top)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: -30.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's left edge on its parent sibling (bView)'s left edge") {
                aViewChild.pin.bottom(to: bView.edge.top)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 70.0, width: 50.0, height: 30.0)))
            }

            it("should position the bViewChild's left edge on its sibling's children (aViewChild)'s left edge") {
                aViewChild.pin.bottom(to: aView.edge.bottom)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 30.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's left edge on its parent's right edge") {
                aViewChild.pin.bottom(to: bView.edge.bottom)
                expect(aViewChild.frame).to(equal(CGRect(x: 10.0, y: 150.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild's left edge on its parent sibling (bView)'s right edge") {
                bViewChild.pin.bottom(to: aViewChild.edge.bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -70.0, width: 60.0, height: 20.0)))
            }
        }

        //
        // right edge
        //
        describe("the result of the right(edge: HorizontalEdge, of: UIView)") {

            it("should position the aViewChild") {
                aViewChild.pin.right(to: aView.edge.left)
                expect(aViewChild.frame).to(equal(CGRect(x: -50.0, y: 20.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild") {
                aViewChild.pin.right(to: bView.edge.left)
                expect(aViewChild.frame).to(equal(CGRect(x: -30.0, y: 20.0, width: 50.0, height: 30.0)))
            }

            it("should position the aViewChild") {
                bViewChild.pin.right(to: aViewChild.edge.left)
                expect(bViewChild.frame).to(equal(CGRect(x: -70.0, y: 10.0, width: 60.0, height: 20.0)))
            }

            it("should position the aViewChild") {
                aViewChild.pin.right(to: aView.edge.right)
                expect(aViewChild.frame).to(equal(CGRect(x: 50.0, y: 20.0, width: 50.0, height: 30.0)))
            }

            it("should position the bViewChild") {
                aViewChild.pin.right(to: bView.edge.right)
                expect(aViewChild.frame).to(equal(CGRect(x: 80.0, y: 20.0, width: 50.0, height: 30.0)))
            }

            it("should position the bViewChild") {
                bViewChild.pin.right(to: aViewChild.edge.right)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)))
            }
        }
    }
}
