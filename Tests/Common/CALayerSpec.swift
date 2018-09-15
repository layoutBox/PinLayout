//  Copyright (c) 2018 Luc Dion
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

class CALayerSpec: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var rootView: BasicView!
        var rootLayer: CALayer!
        var aLayer: CALayer!
        var bLayer: CALayer!

        /*
         rootLayer
         |
          - aLayer
            bLayer
         */

        beforeEach {
            _pinlayoutSetUnitTest(scale: 2)
            Pin.lastWarningText = nil
            Pin.logMissingLayoutCalls = false

            viewController = PViewController()
            viewController.view = BasicView()

            rootView = BasicView()
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)

            rootLayer = CALayer()
            rootLayer.frame = CGRect(x: 0, y: 0, width: 400, height: 400)

            aLayer = CALayer()
            aLayer.bounds.size = CGSize(width: 50, height: 50)
            bLayer = CALayer()
            bLayer.bounds.size = CGSize(width: 20, height: 20)

            #if os(macOS)
            rootView.wantsLayer = true
            rootView.layer?.addSublayer(rootLayer)
            #else
            rootView.layer.addSublayer(rootLayer)
            #endif

            rootLayer.addSublayer(aLayer)
            rootLayer.addSublayer(bLayer)

            viewController.view.addSubview(rootView)
        }

        afterEach {
            _pinlayoutSetUnitTest(scale: nil)
            Pin.logMissingLayoutCalls = false
        }

        //
        // CALayer is already heavily tested since UIView delegate it's layout to it's layer.
        // Validate only the direct usability.
        //
        describe("test CALayer interface") {
            it("should work with basic pinlayout calls") {
                aLayer.pin.top(10).left(10).width(20%).height(80%)
                bLayer.pin.right(of: aLayer, aligned: .center)
                expect(aLayer.frame).to(equal(CGRect(x: 10, y: 10, width: 80, height: 320)))
            }

            it("should be able to be positioned relatively to edges") {
                aLayer.pin.top().right(to: rootLayer.edge.right)
                expect(aLayer.frame).to(equal(CGRect(x: 350, y: 0, width: 50, height: 50)))
            }

            it("should be able to be positioned relatively to anchors") {
                aLayer.pin.topLeft(to: rootLayer.anchor.center)
                expect(aLayer.frame).to(equal(CGRect(x: 200, y: 200, width: 50, height: 50)))
            }

            it("should support pinFrame properly when a transform is set") {
                rootLayer.transform = CATransform3DIdentity

                bLayer.frame = aLayer.frame

                aLayer.transform = CATransform3DMakeScale(2, 2, 1)
                bLayer.transform = CATransform3DMakeScale(2, 2, 1)

                aLayer.pin.top(100).left(100).width(100).height(50)
                bLayer.pinFrame.top(100).left(100).width(100).height(50)

                expect(aLayer.frame).to(equal(CGRect(x: 50, y: 75, width: 200, height: 100)))
                expect(aLayer.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 50)))
                expect(bLayer.frame).to(equal(CGRect(x: 100, y: 100, width: 100, height: 50)))
                expect(bLayer.bounds).to(equal(CGRect(x: 0, y: 0, width: 50, height: 25)))
            }
        }
    }
}
