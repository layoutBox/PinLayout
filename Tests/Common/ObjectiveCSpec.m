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

#import <Foundation/Foundation.h>

@import Quick;
@import Nimble;
@import XCTest;
@import UIKit;
@import PinLayout;

QuickSpecBegin(ObjectiveCSpec)

describe(@"test Objective-C interface", ^{
    __block UIViewController* viewController = nil;
    __block UIView* rootView = nil;
    __block UIView* aView = nil;
    
    beforeEach(^{
        Pin.logMissingLayoutCalls = false;
        Pin.lastWarningText = nil;
        
        viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        
        rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [viewController.view addSubview:rootView];
        
        aView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 100, 60)];
        [rootView addSubview:aView];
    });
    
    afterEach(^{
        Pin.logMissingLayoutCalls = false;
    });
    
    describe(@"generic objective-c tests", ^{
        it(@"Access Pin properties and methods", ^{
            [Pin initPinLayout];
            [Pin layoutDirection:LayoutDirectionLtr];
            Pin.safeAreaInsetsDidChangeMode = PinSafeAreaInsetsDidChangeModeAlways;
            Pin.logWarnings = true;
        });

        it(@"basic pinlayout calls", ^{
            [[[aView pinObjc] top:10] layout];
            expect(@(aView.frame)).to(equal(@(CGRectMake(40, 10, 100, 60))));
        });
        
        it(@"using Pin.logMissingLayoutCalls", ^{
            Pin.logMissingLayoutCalls = true;
            [[aView pinObjc] top:10];
            //expect(Pin.lastWarningText).to(contain(@"PinLayout commands have been issued without calling the 'layout()' method to complete the layout"));
        });

        it(@"using Pin.logMissingLayoutCalls set to false", ^{
            Pin.logMissingLayoutCalls = false;
            [[[aView pinObjc] top:10] layout];
            expect(@(aView.frame)).to(equal(@(CGRectMake(40, 10, 100, 60))));
            expect(Pin.lastWarningText).to(beNil());
        });
        
        it(@"check the access to PinLayout methods from objective-c", ^{
            [[[rootView pinObjc] wrapContent] layout];
            [[[rootView pinObjc] wrapContentWithType:WrapTypeVertically] layout];
            [[[rootView pinObjc] wrapContentWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)] layout];
            [[[rootView pinObjc] wrapContentWithType:WrapTypeAll insets:UIEdgeInsetsMake(0, 0, 0, 0)] layout];
            [[[rootView pinObjc] wrapContentWithPadding:10] layout];
            [[[rootView pinObjc] wrapContentWithType:WrapTypeHorizontally padding:10] layout];            
        });
    });
});

QuickSpecEnd
