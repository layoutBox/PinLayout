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

class RelativePositionSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var rootView: UIView!
        
        var aView: UIView!
        var aViewChild: UIView!
        
        var bView: UIView!
        
        /*
          root
           |
            - aView
           |    |
           |     - aViewChild
           |
            - bView
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = UIView()
            aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
            rootView.addSubview(aView)
            
            aViewChild = UIView()
            aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
            aView.addSubview(aViewChild)
            
            bView = UIView()
            bView.frame = CGRect(x: 160, y: 200, width: 40, height: 40)
            rootView.addSubview(bView)
        }
        
        //
        // above(of:)
        //
        describe("the result of above(of:)") {
            it("should adjust the bView bottom edge relative to its sibling (aView)") {
                bView.pin.above(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView bottom edge relative to its sibling (aView)") {
                bView.pin.above(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // above(of:aligned:)
        //
        describe("the result of above(of:aligned: left)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.above(of: [aView, aViewChild])
                bView.pin.above(of: [aView, aViewChild], aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.above(of: aViewChild, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 145.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of above(of:aligned: center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.above(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 180.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.above(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 165.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of above(of:aligned: right)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.above(of: aView, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 260.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.above(of: aViewChild, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 185.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // left(of:)
        //
        describe("the result of left(of:)") {
            it("should adjust the bView right edge relative to its sibling (aView)") {
                bView.pin.left(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 200.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView right edge relative to its sibling (aView)") {
                bView.pin.left(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 200.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // left(of:aligned:)
        //
        describe("the result of left(of:aligned: .top)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.left(of: aView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.left(of: aViewChild, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 40.0, height: 40.0)))
            }
        }

        describe("the result of left(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.left(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 160.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.left(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 170.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of left(of:aligned: .bottom)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.left(of: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 220.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.left(of: aViewChild, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 190.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // below(of:)
        //
        describe("the result of below(of:)") {
            it("should adjust the bView top edge relative to its sibling (aView)") {
                bView.pin.below(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView top edge relative to its sibling (aView)") {
                bView.pin.below(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // below(of:aligned:)
        //
        describe("the result of below(of:aligned: .left)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.below(of: aView, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.below(of: aViewChild, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 145.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of below(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.below(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 180.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.below(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 165.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of below(of:aligned: .right)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.below(of: aView, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 260.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.below(of: aViewChild, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 185.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        
        //
        // right(of:)
        //
        describe("the result of right(of:)") {
            it("should adjust the bView left edge relative to its sibling (aView)") {
                bView.pin.right(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 200.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView left edge relative to its sibling (aView)") {
                bView.pin.right(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 200.0, width: 40.0, height: 40.0)))
            }
        }
        
        // right(of:aligned:)
        //
        describe("the result of right(of:aligned: .top)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.right(of: aView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.right(of: aViewChild, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 150.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of right(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.right(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 160.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.right(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 170.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of right(of:aligned: .bottom)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.pin.right(of: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 220.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.pin.right(of: aViewChild, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 190.0, width: 40.0, height: 40.0)))
            }
        }
    }
}
