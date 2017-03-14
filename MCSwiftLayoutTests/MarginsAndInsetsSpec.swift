//
//  MarginsAndInsetsSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

class MarginsAndInsetsSpec: QuickSpec {
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
        // left&right margins and left&right insets
        //
        describe("the result of left&right margins and left&right insets when only the width is specified") {
            it("should adjust the aView") {
                aView.layout.width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.width(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.width(100).insetLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.width(100).insetLeft(10).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.width(100).insetHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.width(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins and left&right insets when the left coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.layout.left(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).insetLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).insetLeft(10).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).insetHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins and left&right insets when the right coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.layout.right(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).insetLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).insetLeft(10).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).insetHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.right(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right margins and left&right insets when the left and right coordinate are specified") {
            it("should adjust the aView") {
                aView.layout.left(140).right(240).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).insetLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).insetLeft(10).insetRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).insetHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.left(140).right(240).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
        
       
        //
        // top&bottom margins and top&bottom insets
        //
        // TODO: DO top and bottom !!! duplicate everything above!
        describe("the result of top&bottom margins and top&bottom insets when only the height is specified") {
            it("should adjust the aView") {
                aView.layout.height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.height(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.height(100).insetTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.height(100).insetTop(10).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.height(100).insetVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.height(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
        
        describe("the result of top&bottom margins and top&bottom insets when the top coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.layout.top(140).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).insetTop(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).insetTop(10).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).insetVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of top&bottom margins and top&bottom insets when the bottom coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).insetTop(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).insetTop(10).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).insetVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.bottom(140).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 30.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of top&bottom margins and top&bottom insets when the top and bottom coordinate are specified") {
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).insetTop(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).insetTop(10).insetBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).insetVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).margin(10).inset(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.layout.top(140).bottom(240).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
    }
}
