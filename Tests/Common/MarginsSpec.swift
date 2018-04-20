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

class MarginsSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
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
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
            rootView.addSubview(aView)
        }

        //
        // left&right margins
        //
        describe("the result of left&right margins when only the width is specified") {
            it("should adjust the aView") {
                aView.pin.width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right percent margins when only the width is specified") {
            it("should adjust the aView") {
                aView.pin.width(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins when the left coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right percent margins when the left coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).width(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginLeft(2.5%).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).pinEdges().marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).width(100).marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }
        
        describe("the result of left&right margins when the right coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.right(140).width(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(20)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right percent margins when the right coordinate and the width are specified") {
            it("should adjust the aView") {
                aView.pin.right(140).width(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(5%)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginLeft(2.5%).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).pinEdges().marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 170.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.right(140).width(100).marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 100.0, height: 120.0)))
            }
        }

        describe("the result of left&right margins when the left and right coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(20)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(10)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }

        describe("the result of left&right percent margins when the left and right coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(2.5%).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).margin(5%)
                expect(aView.frame).to(equal(CGRect(x: 160.0, y: 100.0, width: 60.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 90.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginLeft(2.5%).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.left(140).right(160).marginHorizontal(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 150.0, y: 100.0, width: 80.0, height: 120.0)))
            }
        }
        
        //
        // top&bottom margins
        //
        // TODO: DO top and bottom !!! duplicate everything above!
        describe("the result of top&bottom margins when only the height is specified") {
            it("should adjust the aView") {
                aView.pin.height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.height(100 - 20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 80.0)))
            }
        }

        describe("the result of top&bottom percent margins when only the height is specified") {
            it("should adjust the aView") {
                aView.pin.height(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.height(100 - 20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 100.0, width: 200.0, height: 80.0)))
            }
        }
        
        describe("the result of top&bottom margins when the top coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
        }

        describe("the result of top&bottom percent margins when the top coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).height(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(2.5%).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).pinEdges().marginTop(5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).height(100).marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 100.0)))
            }
        }
        
        //
        // bottom & height
        //
        describe("the result of top&bottom margins when the bottom coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
        }

        describe("the result of top&bottom percent margins when the bottom coordinate and the height are specified") {
            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginTop(2.5%).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).pinEdges().marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 50.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.bottom(260).height(100).marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 30.0, width: 200.0, height: 100.0)))
            }
        }
        
        //
        // top & bottom
        //
        describe("the result of top&bottom margins when the top and bottom coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should obtain the same result with or without pinEdges()") {
                aView.pin.top(140).bottom(160).margin(10)
                let frameWithoutPinEdgest = aView.frame

                aView.pin.top(140).bottom(160).pinEdges().margin(10)

                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginTop(20).marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 60.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
        }

        describe("the result of top&bottom percent margins when the top and bottom coordinate are specified") {
            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should obtain the same result with or without pinEdges()") {
                aView.pin.top(140).bottom(160).margin(2.5%)
                let frameWithoutPinEdgest = aView.frame

                aView.pin.top(140).bottom(160).pinEdges().margin(2.5%)

                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(10).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).pinEdges().marginTop(5%).marginBottom(5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 160.0, width: 200.0, height: 60.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 140.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginTop(2.5%).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.top(140).bottom(160).marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 150.0, width: 200.0, height: 80.0)))
            }
        }
        
        //
        // hCenter
        //
        describe("the result of top&bottom margins when the hCenter is specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 210.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 190.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(-100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should obtain the same result with or without pinEdges()") {
                aView.pin.hCenter(100).margin(10)
                let frameWithoutPinEdgest = aView.frame
                
                aView.pin.hCenter(100).pinEdges().margin(10)
                
                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(10)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 90, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 250, y: 100.0, width: 90, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(10).marginRight(10)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 80.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 275.0, y: 100.0, width: 50.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100)
                expect(aView.frame).to(equal(CGRect(x: 275.0, y: 100.0, width: 50.0, height: 100.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(25%)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(-25%)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 120.0)))
            }
        }

        describe("the result of top&bottom percent margins when the hCenter is specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 210.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 190.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(-100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 0.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should obtain the same result with or without pinEdges()") {
                aView.pin.hCenter(100).margin(2.5%)
                let frameWithoutPinEdgest = aView.frame

                aView.pin.hCenter(100).pinEdges().margin(2.5%)

                expect(aView.frame).to(equal(frameWithoutPinEdgest))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 90, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 250, y: 100.0, width: 90, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(100).pinEdges().marginLeft(2.5%).marginRight(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 260.0, y: 100.0, width: 80.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 275.0, y: 100.0, width: 50.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).width(50).height(100)
                expect(aView.frame).to(equal(CGRect(x: 275.0, y: 100.0, width: 50.0, height: 100.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(25%)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 100.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(-25%)
                expect(aView.frame).to(equal(CGRect(x: 0, y: 100.0, width: 200.0, height: 120.0)))
            }
        }
        
        //
        // vCenter
        //
        describe("the result of top&bottom margins when the vCenter is specified") {
            it("should adjust the aView") {
                aView.pin.vCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 240.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 250.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 230.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginVertical(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 80.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(20).marginBottom(20)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 270.0, width: 200.0, height: 60.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 90.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginBottom(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 250.0, width: 200.0, height: 90.0)))
            }
            it("should adjust the aView") {
                aView.pin.vCenter(50%).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 340.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.vCenter(-25%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 120.0)))
            }
        }

        describe("the result of top&bottom percent margins when the vCenter is specified") {
            it("should adjust the aView") {
                aView.pin.vCenter(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 240.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 250.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 230.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginVertical(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 80.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(5%).marginBottom(5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 270.0, width: 200.0, height: 60.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 260.0, width: 200.0, height: 90.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(100).height(100).pinEdges().marginBottom(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 250.0, width: 200.0, height: 90.0)))
            }
            it("should adjust the aView") {
                aView.pin.vCenter(50%).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 340.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.vCenter(-25%)
                expect(aView.frame).to(equal(CGRect(x: 140.0, y: 40.0, width: 200.0, height: 120.0)))
            }
        }
        
        //
        // hCenter and vCenter
        //
        describe("the result of top&bottom margins when the hCenter and vCenter are specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).margin(10)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 240.0, width: 200.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).width(100).pinEdges().marginTop(10)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 250.0, width: 100.0, height: 120.0)))
            }
            
            it("should adjust the aView") {
                aView.pin.hCenter(50%).vCenter(50%)
                expect(aView.frame).to(equal(CGRect(x: 300, y: 340, width: 200.0, height: 120.0)))
            }
        }

        describe("the result of top&bottom percent margins when the hCenter and vCenter are specified") {
            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).margin(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 200.0, y: 240.0, width: 200.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(100).vCenter(100).width(100).pinEdges().marginTop(2.5%)
                expect(aView.frame).to(equal(CGRect(x: 250.0, y: 250.0, width: 100.0, height: 120.0)))
            }

            it("should adjust the aView") {
                aView.pin.hCenter(50%).vCenter(50%)
                expect(aView.frame).to(equal(CGRect(x: 300, y: 340, width: 200.0, height: 120.0)))
            }
        }
        
        //
        // margin using UIEdgeInsets and NSDirectionalEdgeInsets
        //
        describe("the result of top&bottom margins when the hCenter and vCenter are specified") {
            it("should adjust the aView") {
                aView.pin.top().bottom().left().right().margin(PEdgeInsets(top: 10, left: 20, bottom: 30, right: 40))
                expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
            }

            #if os(iOS) || os(tvOS)
            if #available(iOS 11.0, tvOS 11.0, *) {
                it("should adjust the aView") {
                    Pin.layoutDirection(.ltr)
                    aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
                    expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
                }
                
                it("should adjust the aView") {
                    Pin.layoutDirection(.rtl)
                    aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
                    expect(aView.frame).to(equal(CGRect(x: 40.0, y: 10.0, width: 340.0, height: 360.0)))
                }
                
                it("should adjust the aView") {
                    Pin.layoutDirection(.auto)
                    aView.pin.top().bottom().start().end().margin(NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40))
                    expect(aView.frame).to(equal(CGRect(x: 20.0, y: 10.0, width: 340.0, height: 360.0)))
                }
            }
            #endif
        }
    }
}
