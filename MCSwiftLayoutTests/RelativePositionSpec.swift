//
//  RelativePositionSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

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
        // above(of:aligned:)
        //
        describe("the result of above(of:aligned: left)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.above(of: aView, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.above(of: aViewChild, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 145.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of above(of:aligned: center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.above(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 180.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.above(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 165.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of above(of:aligned: right)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.above(of: aView, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 260.0, y: 60.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.above(of: aViewChild, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 185.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // left(of:aligned:)
        //
        describe("the result of left(of:aligned: .top)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.left(of: aView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.left(of: aViewChild, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 150.0, width: 40.0, height: 40.0)))
            }
        }

        describe("the result of left(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.left(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 160.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.left(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 170.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of left(of:aligned: .bottom)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.left(of: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 220.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.left(of: aViewChild, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 190.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // below(of:aligned:)
        //
        describe("the result of below(of:aligned: .left)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.below(of: aView, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 100.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.below(of: aViewChild, aligned: .left)
                expect(bView.frame).to(equal(CGRect(x: 145.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of below(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.below(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 180.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.below(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 165.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of below(of:aligned: .right)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.below(of: aView, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 260.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.below(of: aViewChild, aligned: .right)
                expect(bView.frame).to(equal(CGRect(x: 185.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // right(of:aligned:)
        //
        describe("the result of right(of:aligned: .top)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.right(of: aView, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 100.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.right(of: aViewChild, aligned: .top)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 150.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of right(of:aligned: .center)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.right(of: aView, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 160.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.right(of: aViewChild, aligned: .center)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 170.0, width: 40.0, height: 40.0)))
            }
        }
        
        describe("the result of right(of:aligned: .bottom)") {
            it("should adjust the bView position relative to its sibling (aView)") {
                bView.layout.right(of: aView, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 220.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView position relative ot its sibling children (aViewChild)") {
                bView.layout.right(of: aViewChild, aligned: .bottom)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 190.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // above(of:)
        //
        describe("the result of above(of:)") {
            it("should adjust the bView bottom edge relative to its sibling (aView)") {
                bView.layout.above(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 60.0, width: 40.0, height: 40.0)))
            }

            it("should adjust the bView bottom edge relative to its sibling (aView)") {
                bView.layout.above(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 110.0, width: 40.0, height: 40.0)))
            }
        }
        
        //
        // left(of:)
        //
        describe("the result of left(of:)") {
            it("should adjust the bView right edge relative to its sibling (aView)") {
                bView.layout.left(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 60.0, y: 200.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView right edge relative to its sibling (aView)") {
                bView.layout.left(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 105.0, y: 200.0, width: 40.0, height: 40.0)))
            }
        }

        //
        // below(of:)
        //
        describe("the result of below(of:)") {
            it("should adjust the bView top edge relative to its sibling (aView)") {
                bView.layout.below(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 260.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView top edge relative to its sibling (aView)") {
                bView.layout.below(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 160.0, y: 230.0, width: 40.0, height: 40.0)))
            }
        }

        //
        // right(of:)
        //
        describe("the result of right(of:)") {
            it("should adjust the bView left edge relative to its sibling (aView)") {
                bView.layout.right(of: aView)
                expect(bView.frame).to(equal(CGRect(x: 300.0, y: 200.0, width: 40.0, height: 40.0)))
            }
            
            it("should adjust the bView left edge relative to its sibling (aView)") {
                bView.layout.right(of: aViewChild)
                expect(bView.frame).to(equal(CGRect(x: 225.0, y: 200.0, width: 40.0, height: 40.0)))
            }
        }
    }
}
