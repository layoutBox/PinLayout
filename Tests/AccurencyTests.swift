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
