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

class PinEdgeCoordinateSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
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
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = BasicView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)

            bView = BasicView()
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the top(edge: VerticalEdge, of: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = PView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
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
