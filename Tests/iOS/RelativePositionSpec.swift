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

class RelativePositionSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
        var rootView: BasicView!
        
        var aView: BasicView!
        var aViewChild: BasicView!
        
        var bView: BasicView!
        
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
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 100, y: 100, width: 200, height: 160)
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aViewChild.frame = CGRect(x: 45, y: 50, width: 80, height: 80)
            aView.addSubview(aViewChild)
            
            bView = BasicView()
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
