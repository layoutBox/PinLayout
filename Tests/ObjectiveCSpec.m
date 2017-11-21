//
//  ObjectiveCSpec.m
//  PinLayout
//
//  Created by DION, Luc (MTL) on 2017-11-21.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

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
        Pin.warnMissingLayoutCalls = false;
        Pin.lastWarningText = nil;
        
        viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        
        rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [viewController.view addSubview:rootView];
        
        aView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 100, 60)];
        [rootView addSubview:aView];
    });
    
    afterEach(^{
        Pin.warnMissingLayoutCalls = false;
    });
    
    describe(@"its click", ^{
        it(@"is loud", ^{
            [[[aView pinObjc] top:10] layout];
            expect(@(aView.frame)).to(equal(@(CGRectMake(40, 10, 100, 60))));
        });
        
        it(@"using Pin.warnMissingLayoutCalls", ^{
            Pin.warnMissingLayoutCalls = true;
            [[aView pinObjc] top:10];
            expect(@(aView.frame)).to(equal(@(CGRectMake(40, 10, 100, 60))));
            expect(Pin.lastWarningText).to(contain(@"PinLayout commands have been issued without calling the 'layout()' method to complete the layout"));
        });

        it(@"using Pin.warnMissingLayoutCalls set to false", ^{
            Pin.warnMissingLayoutCalls = false;
            [[[aView pinObjc] top:10] layout];
            expect(@(aView.frame)).to(equal(@(CGRectMake(40, 10, 100, 60))));
            expect(Pin.lastWarningText).to(beNil());
        });
    });
});

QuickSpecEnd
