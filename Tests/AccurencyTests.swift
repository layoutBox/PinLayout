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

@testable import PinLayout


class AccurencyTests: QuickSpec {
    var viewController: UIViewController!
    var rootView: UIView!
    
    override func spec() {
        var viewController: UIViewController!
        
        var rootView: BasicView!
        var aView: BasicView!
        
        beforeEach {
            viewController = UIViewController()
            
            rootView = BasicView(text: "", color: .white)
            rootView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            viewController.view.addSubview(rootView)
            
            aView = BasicView(text: "View A", color: UIColor.red.withAlphaComponent(0.5))
//            aView.frame = CGRect(x: 140, y: 100, width: 200, height: 100)
            rootView.addSubview(aView)
        }
        
//        describe("Test accurency") {
//            it("") {
//                
//                Coordinates.overwriteDisplayScaleForUnitTest(scale: 1)
//                aView.pin.top(1.33).left(1.33).width(1.33).height(1.33)
////                expect(aView.top).to(equal(2))
//                expect(aView.frame).to(equal(CGRect(x: 2, y: 2, width: 2, height: 2)))
//            }
//        }
    }
}
/*

- (void)testCeilFloatToStandardDisplayScale {
    [MCUIViewLayoutPosition overrideDisplayScaleForTest:1.0];
    CGFloat ceiledFloat = [MCUIViewLayoutPosition ceilFloatToDisplayScale:1.33];
    XCTAssertEqualWithAccuracy(ceiledFloat, 2.0f, DESIRED_ACCURACY);
    }
    
    - (void)testCeilFloatToRetinaDisplayScale {
        [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
        CGFloat ceiledFloat = [MCUIViewLayoutPosition ceilFloatToDisplayScale:1.33];
        XCTAssertEqualWithAccuracy(ceiledFloat, 1.5f, DESIRED_ACCURACY);
        }
        
        - (void)testCeilFloatToRetinaPlusDisplayScale {
            [MCUIViewLayoutPosition overrideDisplayScaleForTest:3.0];
            CGFloat ceiledFloat = [MCUIViewLayoutPosition ceilFloatToDisplayScale:1.33];
            XCTAssertEqualWithAccuracy(ceiledFloat, 1.333333f, DESIRED_ACCURACY);
            }
            
            - (void)testFloorFloatToStandardDisplayScale {
                [MCUIViewLayoutPosition overrideDisplayScaleForTest:1.0];
                
                CGFloat flooredFloat = [MCUIViewLayoutPosition floorFloatToDisplayScale:1.75];
                XCTAssertEqualWithAccuracy(flooredFloat, 1.0f, DESIRED_ACCURACY);
                }
                
                - (void)testFloorFloatToRetinaDisplayScale {
                    [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
                    
                    CGFloat flooredFloat = [MCUIViewLayoutPosition floorFloatToDisplayScale:1.75];
                    XCTAssertEqualWithAccuracy(flooredFloat, 1.5f, DESIRED_ACCURACY);
                    }
                    
                    - (void)testFloorFloatToRetinaPlusDisplayScale {
                        [MCUIViewLayoutPosition overrideDisplayScaleForTest:3.0];
                        
                        CGFloat flooredFloat = [MCUIViewLayoutPosition floorFloatToDisplayScale:1.75];
                        XCTAssertEqualWithAccuracy(flooredFloat, 1.666666f, DESIRED_ACCURACY);
                        }
                        
                        - (void)testRoundFloatToStandardDisplayScaleGoingDown {
                            [MCUIViewLayoutPosition overrideDisplayScaleForTest:1.0];
                            
                            CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.49];
                            XCTAssertEqualWithAccuracy(flooredFloat, 1.0f, DESIRED_ACCURACY);
                            }
                            
                            - (void)testRoundFloatToStandardDisplayScaleGoingUp {
                                [MCUIViewLayoutPosition overrideDisplayScaleForTest:1.0];
                                
                                CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.50];
                                XCTAssertEqualWithAccuracy(flooredFloat, 2.0f, DESIRED_ACCURACY);
                                }
                                
                                - (void)testRoundFloatToRetinaDisplayScaleGoingUp {
                                    [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
                                    
                                    CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.75];
                                    XCTAssertEqualWithAccuracy(flooredFloat, 2.0f, DESIRED_ACCURACY);
                                    }
                                    
                                    - (void)testRoundFloatToRetinaDisplayScaleGoingUpUnder1_5 {
                                        [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
                                        
                                        CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.25];
                                        XCTAssertEqualWithAccuracy(flooredFloat, 1.5f, DESIRED_ACCURACY);
                                        }
                                        
                                        - (void)testRoundFloatToRetinaDisplayScaleDownUnder1_5 {
                                            [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
                                            
                                            CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.24];
                                            XCTAssertEqualWithAccuracy(flooredFloat, 1.0f, DESIRED_ACCURACY);
                                            }
                                            
                                            - (void)testRoundFloatToRetinaDisplayScaleGoingDown {
                                                [MCUIViewLayoutPosition overrideDisplayScaleForTest:2.0];
                                                
                                                CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.74];
                                                XCTAssertEqualWithAccuracy(flooredFloat, 1.5f, DESIRED_ACCURACY);
                                                }
                                                
                                                - (void)testRoundFloatToRetinaPlusDisplayScaleToTwo {
                                                    [MCUIViewLayoutPosition overrideDisplayScaleForTest:3.0];
                                                    
                                                    CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.85];
                                                    XCTAssertEqualWithAccuracy(flooredFloat, 2.0f, DESIRED_ACCURACY);
                                                    }
                                                    
                                                    - (void)testRoundFloatToRetinaPlusDisplayScaleLowerFraction {
                                                        [MCUIViewLayoutPosition overrideDisplayScaleForTest:3.0];
                                                        
                                                        CGFloat flooredFloat = [MCUIViewLayoutPosition roundFloatToDisplayScale:1.49];
                                                        XCTAssertEqualWithAccuracy(flooredFloat, 1.333333f, DESIRED_ACCURACY);
}*/
