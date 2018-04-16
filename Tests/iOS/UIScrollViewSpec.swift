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

class UIScrollViewSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        
        var rootView: BasicView!
        var scrollView: PScrollView!

        /*
          root
           |
           |- scrollView
        */

        beforeEach {
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            viewController.view.addSubview(rootView)
            
            scrollView = PScrollView()
            rootView.addSubview(scrollView)
            
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            scrollView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        }
        
        describe("Layout a UIScrollView") {
            it("layout the UIScrollView") {
                scrollView.pin.all()
                
                expect(scrollView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(scrollView.bounds).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(scrollView.contentOffset).to(equal(CGPoint(x: 0, y: 0)))
            }

            it("should keep the contentOffset") {
                scrollView.contentOffset = CGPoint(x: 30, y: 30)

                scrollView.pin.all()

                expect(scrollView.frame).to(equal(CGRect(x: 0, y: 0, width: 400.0, height: 400.0)))
                expect(scrollView.bounds).to(equal(CGRect(x: 30, y: 30, width: 400.0, height: 400.0)))
                expect(scrollView.contentOffset).to(equal(CGPoint(x: 30, y: 30)))
            }
        }
    }
}
