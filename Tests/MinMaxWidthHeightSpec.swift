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

class MinMaxWidthHeightSpec: QuickSpec {
    override func spec() {
        var viewController: UIViewController!
        var rootView: BasicView!
        var aView: BasicView!
        
        /*
          root
           |
            - aView
        */
        
        beforeSuite {
            setUnitTest(displayScale: 2)
        }

        beforeEach {
            unitTestLastWarning = nil
            
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
            aView.frame = CGRect(x: 40, y: 100, width: 100, height: 60)
            aView.sizeThatFitsExpectedArea = 40 * 40
            rootView.addSubview(aView)
        }

        //
        // minWidth
        //
        describe("the result of the minWidth(...)") {
            it("should adjust the width of aView") {
                aView.pin.left().minWidth(50)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 60)
                
                aView.pin.left().minWidth(50)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 50.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 60)
                aView.pin.left().minWidth(25%)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left().width(100).minWidth(150) // width < minWidth
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left().width(100).minWidth(50) // width > minWidth
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 200.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).marginLeft(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(100).right(100).marginRight(100).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.right(100).minWidth(300)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 300.0, height: 60.0)))
            }
            
            it("should adjust the width to 500 and keep the view in the center") {
                aView.pin.left().right().minWidth(500)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 500.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(20).minWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(20).minWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify(.left)", "won't be applied", "justification is not applied when hCenter has been set"]))
            }
        }
        
        //
        // maxWidth
        //
        describe("the result of the maxWidth(...)") {
            it("should adjust the width of aView") {
                aView.pin.left().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 60)
                
                aView.pin.left().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 200, height: 60)
                
                aView.pin.left().maxWidth(25%)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 100.0, height: 60.0)))
            }
        
            it("should adjust the width of aView") {
                aView.pin.left().maxWidth(150).marginLeft(50)
                expect(aView.frame).to(equal(CGRect(x: 50.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left().right().maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 150.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left().width(200).maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 150.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.right().width(200).maxWidth(150)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 100.0, width: 150.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left(0).right(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 300, height: 60)
                aView.pin.left(0).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }

            it("should adjust the width of aView") {
                aView.pin.left(0).width(100%).maxWidth(250).marginLeft(100)
                expect(aView.frame).to(equal(CGRect(x: 100.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width of aView") {
                aView.pin.left(0).right(0).marginRight(100).maxWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify(.center)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().width(100%).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify(.right)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify(.left)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
                expect(unitTestLastWarning).to(contain(["justify(.center)", "won't be applied", "left and right coordinates"]))
            }
            
            it("should adjust the width using justify") {
                aView.pin.right().width(100%).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 85.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width using justify") {
                aView.pin.left().right().marginLeft(20).marginRight(20).maxWidth(250).justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 130.0, y: 100.0, width: 250.0, height: 60.0)))
            }
            
            it("should adjust the width when using hCenter") {
                aView.pin.hCenter().width(100%).maxWidth(250)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 60.0)))
            }
        }
        
        //
        // minWidth/maxWidth & sizeToFit()
        //
        describe("the result of the minWidth/maxWidth & sizeToFit()") {
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(100%).maxWidth(250).sizeToFit().justify(.left)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(100%).maxWidth(250).sizeToFit().justify(.right)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().maxWidth(250).sizeToFit().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 6.5)))
            }
                
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().width(10).minWidth(250).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(10).minWidth(250).sizeToFit().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 75.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(10).minWidth(250).marginLeft(10).sizeToFit().justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 250.0, height: 6.5)))
            }
            
            it("should adjust the width when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.left().right().width(250).marginLeft(10).justify(.center)
                expect(aView.frame).to(equal(CGRect(x: 80.0, y: 100.0, width: 250.0, height: 60)))
            }
        }
        
        
        //
        // minHeight
        //
        describe("the result of the minHeight(...)") {
            it("should adjust the height of aView") {
                aView.pin.top().minHeight(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 30)
                
                aView.pin.top().minHeight(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 25.0, height: 50.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 25, height: 30)
                
                aView.pin.top().minHeight(25%)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 25.0, height: 100.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top().height(100).minHeight(150) // height < minHeight
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top().height(100).minHeight(50) // height > minHeight
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 200.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).marginTop(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.top(100).bottom(100).marginBottom(100).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height of aView") {
                aView.pin.bottom(100).minHeight(300)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 300.0)))
            }
            
            it("should adjust the height to 500 and keep the view in the center") {
                aView.pin.top().bottom().minHeight(500)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 500.0)))
            }
            
            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(20).minHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }
            
            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(20).minHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.top)", "won't be applied", "alignment is not applied when vCenter has been set"]))
            }
        }
        
        //
        // maxHeight
        //
        describe("the result of the maxHeight(...)") {
            it("should adjust the height of aView") {
                aView.pin.top().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 200)

                aView.pin.top().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }
            
            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 200)
                
                aView.pin.top().maxHeight(25%)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 100.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().maxHeight(150).marginTop(50)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 50.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().bottom().maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top().height(200).maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.bottom().height(200).maxHeight(150)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 250.0, width: 100.0, height: 150.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).bottom(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 60.0)))
            }

            it("should adjust the height of aView") {
                aView.frame = CGRect(x: 40, y: 100, width: 100, height: 300)
                aView.pin.top(0).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).height(100%).maxHeight(250).marginTop(100)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height of aView") {
                aView.pin.top(0).bottom(0).marginBottom(100).maxHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.top)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().height(100%).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 00.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.bottom)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.top)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.center)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.bottom().height(100%).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
                expect(unitTestLastWarning).to(contain(["align(.bottom)", "won't be applied", "top and bottom coordinates"]))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 20.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 85.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 150.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height using align") {
                aView.pin.top().bottom().marginTop(20).marginBottom(20).maxHeight(250).align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 130.0, width: 100.0, height: 250.0)))
            }

            it("should adjust the height when using hCenter") {
                aView.pin.vCenter().height(100%).maxHeight(250)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 75.0, width: 100.0, height: 250.0)))
            }
        }

        //
        // minHeight/maxHeight & sizeToFit()
        //
        describe("the result of the minHeight/maxWidth & sizeToFit()") {
            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(100%).maxHeight(200).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(100%).maxHeight(200).sizeToFit().align(.top)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(100%).maxHeight(200).sizeToFit().align(.bottom)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 200.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().maxHeight(200).sizeToFit().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().height(10).minHeight(200).sizeToFit()
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 0.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(10).minHeight(200).sizeToFit().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 100.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(10).minHeight(200).marginTop(10).sizeToFit().align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 8.0, height: 200.0)))
            }

            it("should adjust the height when using sizeToFit") {
                aView.sizeThatFitsExpectedArea = 40 * 40
                aView.pin.top().bottom().height(200).marginTop(10).align(.center)
                expect(aView.frame).to(equal(CGRect(x: 40.0, y: 105.0, width: 100.0, height: 200.0)))
            }
        }
    }
}
