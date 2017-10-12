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

import XCTest
@testable import PinLayout

class PinLayoutTests: XCTestCase {
    var viewController: UIViewController!
    var rootView: UIView!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIViewController()
        
        rootView = UIView()
        rootView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        viewController.view.addSubview(rootView)
    }
    
    func testExample() {
        let child1 = UIView()
        rootView.addSubview(child1)

//        pin(rootView).topLeft(to: child1.pin.center)
//        rootView.pin.topLeft(to: child1.pin.center)
        
//        child1.pin.pinCenter(of: rootView)
//        print("child1.frame: \(child1.frame)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
