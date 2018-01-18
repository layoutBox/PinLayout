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

class TransformSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        
        var rootView: BasicView!
        var aView: BasicView!
        
        var bView: BasicView!
        var bViewChild: BasicView!
        
        /*
          root
           |
           |- aView
           |   |
           |    - aViewChild
           |
           - bView
               |
               - bViewChild
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            rootView.addSubview(aView)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            rootView.addSubview(bView)
            
            bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
            bView.addSubview(bViewChild)
            
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
            bView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        }
        
        describe("Using top, bottom, left, right, width and height") {
            it("Parent: No transform  Child: No transform") {
                rootView.transform = .identity
                aView.transform = .identity
                
                aView.pin.top(100).left(100).width(100).height(50)
                
                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 100.0, height: 50.0)))
            }
            
            it("Parent: No transform  Child: Scale transform") {
                rootView.transform = .identity
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.top(100).left(100).width(100).height(50)
                
                // The view should keep its transform
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 75.0, width: 200.0, height: 100.0)))
                
                // If we clear the transform, the view should retrieve the original frame.
                aView.transform = CGAffineTransform.identity
                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 100.0, height: 50.0)))
            }
            
            it("Parent: No transform  Child: No transform") {
                rootView.transform = .identity
                aView.transform = .identity
                
                aView.pin.top().bottom().left().right()
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.top().bottom().left().right()
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.top().left().width(100%).height(100%)
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
        }
            
        describe("Using topLeft and bottomRight") {
            it("Parent: No transform  Child: No transform") {
                rootView.transform = .identity
                aView.transform = .identity
                
                aView.pin.topLeft().bottomRight()
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.topLeft().bottomRight()
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
        }
        
        describe("Using anchors") {
            it("Parent: No transform  Child: No transform") {
                rootView.transform = .identity
                aView.transform = .identity
                
                aView.pin.topLeft(to: rootView.anchor.topLeft).bottomRight(to: rootView.anchor.bottomRight)
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.topLeft().bottomRight()
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: No transform  bView: Scale transform") {
                aView.transform = .identity
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.topLeft(to: bView.anchor.topLeft)//.bottomRight(to: bView.anchor.bottomRight)

                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 120.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 120.0)))
                
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
            }
            
            it("aView: No transform  bView: Scale transform") {
                aView.transform = .identity
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.top().left().bottomRight(to: bView.anchor.bottomRight)
                
                // aView should be the size of the untransformed bView size (100, 50).
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
                
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
            }
            
            it("Parent: No transform  Child: Scale transform") {
                rootView.transform = .identity
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.topLeft(to: rootView.anchor.topLeft).bottomRight(to: rootView.anchor.bottomRight)
                
                expect(aView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: Scale transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.topLeft().bottomRight()
                
                expect(aView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.topLeft(to: rootView.anchor.topLeft).bottomRight(to: rootView.anchor.bottomRight)
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.frame = CGRect(x: 100, y: 100, width: 400, height: 400)
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.topLeft(to: rootView.anchor.topLeft).bottomRight(to: rootView.anchor.bottomRight)
                
                expect(aView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -100, y: -100, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
        }
        
        describe("Using edge") {
            it("Parent: No transform  Child: No transform") {
                rootView.transform = .identity
                aView.transform = .identity
                
                aView.pin.top(to: rootView.edge.top).bottom(to: rootView.edge.bottom)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0, width: 200.0, height: 400.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: No transform  Child: Scale transform") {
                rootView.transform = .identity
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.top(to: rootView.edge.top).bottom(to: rootView.edge.bottom)
                
                expect(aView.frame).to(equal(CGRect(x: 40, y: -200, width: 400.0, height: 800.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity
                
                aView.pin.top(to: rootView.edge.top).bottom(to: rootView.edge.bottom)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 0, width: 200.0, height: 400.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("Parent: Scale transform  Child: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.top(to: rootView.edge.top).bottom(to: rootView.edge.bottom)
                
                expect(aView.frame).to(equal(CGRect(x: 40, y: -200, width: 400.0, height: 800.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200.0, height: 400.0)))
                
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
        }
        
        describe("Using width(of:) height(of:) size(of:)") {
            it("aView: No transform  bView: No transform") {
                aView.transform = .identity
                bView.transform = .identity
                
                aView.pin.width(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100.0, height: 120.0)))
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: No transform  bView: Scale transform") {
                aView.transform = .identity
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.width(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100.0, height: 120.0)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
            }
            
            it("aView: Scale transform  bView: Scale transform") {
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.width(of: bView)
                
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 120)))
                expect(aView.frame).to(equal(CGRect(x: 90, y: 40, width: 200.0, height: 240.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
            }
            
            it("aView: No transform  bView: No transform") {
                aView.transform = .identity
                bView.transform = .identity
                
                aView.pin.height(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 200.0, height: 50.0)))
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: No transform  bView: Scale transform") {
                aView.transform = .identity
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.height(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 200.0, height: 50.0)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
            }
            
            it("aView: Scale transform  bView: Scale transform") {
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.height(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 40, y: 75, width: 400.0, height: 100.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 200, height: 50)))
    
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
            }
            
            it("aView: No transform  bView: No transform") {
                aView.transform = .identity
                bView.transform = .identity
                
                aView.pin.size(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100.0, height: 50.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: No transform  bView: Scale transform") {
                aView.transform = .identity
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.size(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 140, y: 100, width: 100.0, height: 50.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 50.0)))
            }
            
            it("aView: Scale transform  bView: Scale transform") {
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                bView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.size(of: bView)
                
                expect(aView.frame).to(equal(CGRect(x: 90, y: 75, width: 200.0, height: 100.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(bView.frame).to(equal(CGRect(x: -50, y: -25, width: 200.0, height: 100.0)))
                expect(bView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
            }
        }
        
        describe("Using right()") {
            it("aView: No transform  aView: No transform") {
                aView.transform = .identity
                bView.transform = .identity
                
                aView.pin.right().width(100)
                
                expect(aView.frame).to(equal(CGRect(x: 300, y: 100, width: 100.0, height: 120.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 120.0)))
                expect(aView.center).to(equal(CGPoint(x: 350, y: 160)))
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: No transform  aView: Scale transform") {
                rootView.transform = .identity
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
                aView.pin.right().width(100)
                
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 40.0, width: 200.0, height: 240.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 120.0)))
                expect(aView.center).to(equal(CGPoint(x: 350, y: 160)))
                expect(rootView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
            
            it("aView: Scale transform  aView: No transform") {
                rootView.transform = CGAffineTransform(scaleX: 2, y: 2)
                aView.transform = .identity

                aView.pin.right().width(100)
                
                expect(aView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 100.0, height: 120.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 120.0)))
                expect(aView.center).to(equal(CGPoint(x: 350, y: 160)))
                expect(rootView.frame).to(equal(CGRect(x: -200, y: -200, width: 800.0, height: 800.0)))
                expect(rootView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
            }
        }

        describe("Modifying layer.anchorPoint change the view.center position") {
            it("aView: Default layer.anchorPoint (0.5, 0.5)") {
                aView.pin.top(100).left(100).width(100).height(100)

                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 100.0, height: 100.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                expect(aView.center).to(equal(CGPoint(x: 150, y: 150)))
            }

            it("aView: With layer.anchorPoint change (0.25, 0.25)") {
                aView.layer.anchorPoint = CGPoint(x: 0.25, y: 0.25) // default is 0.5, 0.5 (Center)
                aView.pin.top(100).left(100).width(100).height(100)

                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 100.0, height: 100.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                expect(aView.center).to(equal(CGPoint(x: 125, y: 125)))
            }

            it("aView: With layer.anchorPoint change (1, 1)") {
                aView.layer.anchorPoint = CGPoint(x: 1, y: 1) // default is 0.5, 0.5 (Center)
                aView.pin.top(100).left(100).width(100).height(100)

                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 100.0, height: 100.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                expect(aView.center).to(equal(CGPoint(x: 200, y: 200)))
            }

            it("aView: With layer.anchorPoint change (0, 0) + transform scale 2") {
                aView.layer.anchorPoint = CGPoint(x: 0, y: 0) // default is 0.5, 0.5 (Center)
                aView.transform = CGAffineTransform(scaleX: 2, y: 2)

                aView.pin.top(100).left(100).width(100).height(100)

                expect(aView.frame).to(equal(CGRect(x: 100, y: 100, width: 200.0, height: 200.0)))
                expect(aView.bounds).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                expect(aView.center).to(equal(CGPoint(x: 100, y: 100)))
            }

        }
    }
}
