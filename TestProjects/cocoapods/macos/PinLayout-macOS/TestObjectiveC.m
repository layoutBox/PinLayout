//
//  TestObjectiveC.m
//  PinLayoutPodTester
//
//  Created by DION, Luc (MTL) on 2017-10-12.
//  Copyright © 2017 Mirego. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AppKit;
@import PinLayout;

@interface IntroObjectiveCView: NSView {
}
@end

@implementation IntroObjectiveCView {
    CGFloat topLayoutGuide;
    NSImageView* logo;
    NSView* separatorView;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        topLayoutGuide = 0;

        logo = [[NSImageView alloc] init];
        separatorView = [[NSView alloc] init];
    }
    return self;
}

- (void)layout {
    [super layout];

    [[[[[logo.pinObjc top] left] width:100] marginWithTop:topLayoutGuide + 10 horizontal:10 bottom:10] layout];
    [[[[separatorView.pinObjc belowOf:logo aligned:HorizontalAlignLeft] height:1] marginTop:10] layout];
}

@end
