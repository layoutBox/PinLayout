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

class ReadableLayoutMargins: QuickSpec {
    override func spec() {
        var viewController: PViewController!
        var window: UIWindow!
        
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
            viewController = PViewController()
            viewController.view = BasicView()
            
            rootView = BasicView()
            viewController.view.addSubview(rootView)
            
            aView = BasicView()
            rootView.addSubview(aView)
            
            bView = BasicView()
            rootView.addSubview(bView)
            
            bViewChild = BasicView()
            bView.addSubview(bViewChild)
            
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 120)
            bView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
            bViewChild.frame = CGRect(x: 40, y: 10, width: 60, height: 20)
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("Using pin.readableMargins") {
            it("test") {
                setupWindow(with: viewController)

                aView.pin.all(rootView.pin.readableMargins)
                
                expect(aView.frame).to(equal(rootView.readableContentGuide.layoutFrame))
            }
        }

        describe("Using pin.layoutMargins") {
            it("test") {
                setupWindow(with: viewController)

                aView.pin.all(rootView.pin.layoutMargins)
                
                let layoutMargins = rootView.layoutMargins
                let aViewFrame = CGRect(
                    x: layoutMargins.left,
                    y: layoutMargins.top,
                    width: rootView.frame.width - (layoutMargins.left + layoutMargins.right),
                    height: rootView.frame.height - (layoutMargins.top + layoutMargins.bottom)
                )
                expect(aView.frame).to(equal(aViewFrame))
            }
        }
        
        #if os(iOS)
        describe("Using pin.keyboardArea") {
            it("test") {
                setupWindow(with: viewController)
                
                rootView.pin.top(0).horizontally()
                rootView.pin.bottom(rootView.pin.keyboardArea.height)

                let keyboardLayoutFrame: CGRect
                
                if #available(iOS 15, *) {
                    keyboardLayoutFrame = rootView.keyboardLayoutGuide.layoutFrame
                } else {
                    keyboardLayoutFrame = .zero
                }
                
                let screenSize = viewController.view.frame
                let expectedRootViewFrame = CGRect(
                    x: .zero,
                    y: .zero,
                    width: screenSize.width,
                    height: screenSize.height - keyboardLayoutFrame.height
                )
                
                expect(rootView.frame).to(equal(expectedRootViewFrame))
                expect(rootView.pin.keyboardArea).to(equal(keyboardLayoutFrame))
            }
        }
        #endif
    }
}
