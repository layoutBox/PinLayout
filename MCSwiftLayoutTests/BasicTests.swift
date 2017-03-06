//
//  BasicTests.swift
//  MCSwiftLayout
//
//  Created by DION, Luc (MTL) on 2017-03-05.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//
import Quick
import Nimble

class BasicTestsSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: UIView!
        
        var childLevel1: UIView!
        var childLevel2: UIView!
        
        var anotherChildLevel1: UIView!
        var anotherChildLevel2: UIView!
        
        /*
          root
           |
            - childLevel1
           |    |
           |     - childLevel2
           |
            - anotherChildLevel1
                |
                 - anotherChildLevel2
        */

        beforeEach {
            viewController = UIViewController()
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            viewController.view.addSubview(rootView)
            
            childLevel1 = UIView()
            rootView.addSubview(childLevel1)
            
            childLevel2 = UIView()
            childLevel1.addSubview(childLevel2)

            anotherChildLevel1 = UIView()
            rootView.addSubview(anotherChildLevel1)
            
            anotherChildLevel2 = UIView()
            anotherChildLevel1.addSubview(anotherChildLevel2)
        }
        
        describe("the result of the centers(of: UIView) method") {
            it("should warns that the view is not added to any view") {
                let unAttachedView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
                unAttachedView.layout.centers(of: rootView)
                
                expect(unAttachedView.frame).to(equal(CGRect(x: 10, y: 10, width: 10, height: 10)))
            }
            
            it("should centers the childLevel1 in the center of its parent") {
                childLevel1.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                childLevel1.layout.centers(of: rootView)
                
                expect(childLevel1.frame).to(equal(CGRect(x: 30, y: 20, width: 40, height: 60)))
            }
            
            it("should centers the childLevel1 in the center of its sibling anotherChildLevel1") {
                anotherChildLevel1.frame = CGRect(x: 10, y: 10, width: 30, height: 50)
                
                childLevel1.frame = CGRect(x: 10, y: 10, width: 40, height: 60)
                childLevel1.layout.centers(of: anotherChildLevel1)
                
                expect(childLevel1.frame).to(equal(CGRect(x: 5, y: 5, width: 40, height: 60)))
            }
            
            it("should centers the anotherChildLevel1 in the center of its sibling (childLevel1) sub child (childLevel2)") {
                childLevel1.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                childLevel2.frame = CGRect(x: 10, y: 20, width: 20, height: 40)
                anotherChildLevel1.frame = CGRect(x: 10, y: 10, width: 30, height: 50)
                
                anotherChildLevel1.layout.centers(of: childLevel2)
                
                expect(anotherChildLevel1.frame).to(equal(CGRect(x: 15, y: 35, width: 30, height: 50)))
            }
            
            it("should centers the childLevel2 in the center of anotherChildLevel1") {
                childLevel1.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                childLevel2.frame = CGRect(x: 10, y: 20, width: 20, height: 40)
                anotherChildLevel1.frame = CGRect(x: 10, y: 10, width: 30, height: 50)
                
                childLevel2.layout.centers(of: anotherChildLevel1)
                
                expect(childLevel2.frame).to(equal(CGRect(x: 5, y: -5, width: 20, height: 40)))
            }
            
            it("should centers the anotherChildLevel2 in the center of its parent's sibling (childLevel1) sub child (childLevel2)") {
                childLevel1.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                childLevel2.frame = CGRect(x: 10, y: 20, width: 30, height: 40)
                anotherChildLevel1.frame = CGRect(x: 10, y: 80, width: 30, height: 50)
                anotherChildLevel2.frame = CGRect(x: 0, y: 0, width: 20, height: 10)
                
                anotherChildLevel2.layout.centers(of: childLevel2)
                expect(anotherChildLevel2.frame).to(equal(CGRect(x: 15, y: -25, width: 20, height: 10)))
            }
        }
        
        describe("the result of the centers() method") {
            it("should centers the childLevel1 in the center of its parent") {
                childLevel1.frame = CGRect(x: 10, y: 20, width: 40, height: 60)
                
                childLevel1.layout.centers()
                
                expect(childLevel1.frame).to(equal(CGRect(x: 30, y: 20, width: 40, height: 60)))
            }
        }
    }
}
