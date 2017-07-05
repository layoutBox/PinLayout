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

class RelativePositionMultipleViewsSpec: QuickSpec {
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
            unitTestLastWarning = nil
            
            viewController = UIViewController()
            
            rootView = UIView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = UIView()
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            rootView.addSubview(aView)
            
            aViewChild = UIView()
            aViewChild.frame = CGRect(x: 10, y: 20, width: 50, height: 30)
            aView.addSubview(aViewChild)
            
            bView = UIView()
            bView.frame = CGRect(x: 160, y: 120, width: 110, height: 80)
            rootView.addSubview(bView)
            
            bViewChild = UIView()
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
            bView.addSubview(bViewChild)
        }
        
        //
        // above(of: UIViews.....) warnings
        //
        describe("the result of above(of: UIView...) with multiple relative views") {
            it("should warns the view bottom edge") {
                let unatachedView = UIView()
                bViewChild.pin.above(of: unatachedView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40, y: 10, width: 60, height: 20)))
                expect(unitTestLastWarning).to(contain(["above", "won't be applied", "no valid references"]))
            }
            
            it("should warns the view bottom edge") {
                let unatachedView = UIView()
                bViewChild.pin.above(of: [aView, unatachedView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
                expect(unitTestLastWarning).to(contain(["above", "won't be applied", "the reference view", "must be added", "as a reference"]))
            }
            
            it("Should warn, but the view should be anyway layout it above") {
                let unatachedView = UIView()
                bViewChild.pin.above(of: [aView, unatachedView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
                expect(unitTestLastWarning).to(contain(["above", "won't be applied", "the reference view", "must be added", "as a reference"]))
            }
        }
        
        //
        // above(of: UIViews.....)
        //
        describe("the result of above(of: UIView...) with multiple relative views") {
            it("should move the view above relative views") {
                bViewChild.pin.above(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .left)
                expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: -40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .right)
                expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: -40.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .right).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: -50.0, width: 60.0, height: 20.0)))
            }

            it("should move the view above relative views") {
                bViewChild.pin.above(of: [aView, bView], aligned: .left).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: -50.0, width: 60.0, height: 20.0)))
            }
        }
    
        //
        // below(of: UIViews.....)
        //
        describe("the result of below(of: UIView...) with multiple relative views") {
            it("should move the view below relative views") {
                bViewChild.pin.below(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .left)
                expect(bViewChild.frame).to(equal(CGRect(x: -120.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .right)
                expect(bViewChild.frame).to(equal(CGRect(x: 50.0, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -100.0, y: 40.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 80.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .right).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 40.0, y: 90.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .left).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -110.0, y: 90.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view below relative views") {
                bViewChild.pin.below(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -37.5, y: 90.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // left(of: UIViews.....)
        //
        describe("the result of left(of: UIView...) with multiple relative views") {
            it("should move the view left relative views") {
                bViewChild.pin.left(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [bView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: -60.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .top)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: -20.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 60.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 0.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -180.0, y: 15.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .bottom).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 50.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .top).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: -10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view left relative views") {
                bViewChild.pin.left(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: -190.0, y: 15.0, width: 60.0, height: 20.0)))
            }
        }
        
        //
        // right(of: UIViews.....)
        //
        describe("the result of right(of: UIView...) with multiple relative views") {
            it("should move the view right relative views") {
                bViewChild.pin.right(of: aView)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView])
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .top)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: -20.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .bottom)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 60.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: aView, aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: -20.0, y: 0.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center)
                expect(bViewChild.frame).to(equal(CGRect(x: 110.0, y: 15.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .bottom).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 50.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .top).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: -10.0, width: 60.0, height: 20.0)))
            }
            
            it("should move the view right relative views") {
                bViewChild.pin.right(of: [aView, bView], aligned: .center).margin(10)
                expect(bViewChild.frame).to(equal(CGRect(x: 120.0, y: 15.0, width: 60.0, height: 20.0)))
            }
        }     
    }
}
