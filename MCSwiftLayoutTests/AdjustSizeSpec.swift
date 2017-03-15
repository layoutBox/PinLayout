//
//  AdjustSizeSpec.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble
import MCSwiftLayout

class AdjustSizeSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
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
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 140, y: 100, width: 100, height: 60)
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
            
            aViewChild = BasicView(text: "View A Child", color: UIColor.red.withAlphaComponent(1))
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)
            
            bView = BasicView(text: "View B", color: UIColor.blue.withAlphaComponent(0.5))
            bView.frame = CGRect(x: 160, y: 200, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = BasicView(text: "View B Child", color: UIColor.blue.withAlphaComponent(0.7))
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }

        describe("the result of the width(...) methods") {
            it("should ajust the width of aView") {
                aView.layout.width(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 35, height: 60.0)))
            }
            
            it("should ajust the width of aView") {
                aView.layout.width(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 60.0)))
            }
        }
        
        describe("the result of the height(...) methods") {
            it("should ajust the height of aView") {
                aView.layout.height(35)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 35.0)))
            }
            
            it("should ajust the height of aView") {
                aView.layout.height(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 30.0)))
            }
        }
        
        describe("the result of the size(...) methods") {
        
            it("should ajust the size of aView") {
                aView.layout.size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 25.0, height: 25.0)))
            }
            
            it("should warn that size() won't be applied") {
                aView.layout.width(90).size(CGSize(width: 25, height: 25))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
            
            it("should ajust the size of aView by calling a size(...) method") {
                aView.layout.size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 30.0)))
            }
        
            it("should warn that size(of) won't be applied") {
                aView.layout.width(90).size(of: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
        }
        
        describe("the result of the sizeThatFits(...) methods") {
            
            it("should ajust the size of aView by calling sizeThatFits(size: CGSize) method") {
                aView.layout.sizeThatFits(size: CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(size) method") {
                aView.layout.sizeThatFits(size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 100))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should warn that sizeThatFits(size:) won't be applied") {
                aView.layout.top(0).bottom(70).sizeThatFits(size: CGSize(width: 100, height: CGFloat.greatestFiniteMagnitude))
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 0.0, width: 100.0, height: 70.0)))
            }

            it("should ajust the size of aView by calling sizeThatFits(width: CGFloat) method") {
                aView.layout.sizeThatFits(width: 100)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 16.0)))
            }
            
            it("should warn that sizeThatFits(width:) won't be applied") {
                aView.layout.height(90).sizeThatFits(width: 100)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 90.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(widthOf: UIView) method") {
                aView.layout.sizeThatFits(widthOf: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should warn that sizeThatFits(widthOf:) won't be applied") {
                aView.layout.sizeThatFits(width: 80).sizeThatFits(widthOf: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 80.0, height: 20.0)))
            }

            it("should ajust the size of aView by calling sizeThatFits(height: CGFloat) method") {
                aView.layout.sizeThatFits(height: 100)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 16.0, height: 100.0)))
            }
            
            it("should warn that sizeThatFits(height:) won't be applied") {
                aView.layout.width(90).sizeThatFits(height: 100)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(heightOf: UIView) method") {
                aView.layout.sizeThatFits(heightOf: aViewChild)
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 53.3333333333333, height: 30.0), within: 0.3))
            }
            
            it("should warn that sizeThatFits(heightOf:) won't be applied") {
                aView.layout.width(90).sizeThatFits(heightOf: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
            
            it("should ajust the size of aView by calling sizeThatFits(sizeOf: UIView) method") {
                aView.layout.sizeThatFits(sizeOf: aViewChild)
                expect(aView.frame).to(beCloseTo(CGRect(x: 140.0, y: 100.0, width: 50.0, height: 32.0)))
            }
            
            it("should warn that sizeThatFits(sizeOf:) won't be applied") {
                aView.layout.width(90).sizeThatFits(sizeOf: aViewChild)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 60.0)))
            }
        }
    }
}
