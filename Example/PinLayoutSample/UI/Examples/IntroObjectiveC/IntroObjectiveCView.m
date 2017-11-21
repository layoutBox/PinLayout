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

#import <Foundation/Foundation.h>
#import "IntroObjectiveCView.h"
@import PinLayout;


@implementation IntroObjectiveCView {
    CGFloat topLayoutGuide;
    UIImageView* logo;
    UISegmentedControl* segmented;
    UILabel* textLabel;
    UIView* separatorView;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        Pin.logMissingLayoutCalls = true;
        
        topLayoutGuide = 0;
        self.backgroundColor = UIColor.whiteColor;
        
        logo = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"PinLayout-logo" inBundle:nil compatibleWithTraitCollection:nil]];
        [self addSubview:logo];
        
        segmented = [[UISegmentedControl alloc] initWithItems: @[@"Intro", @"1", @"2"]];
        [self addSubview:segmented];
        
        textLabel = [[UILabel alloc] init];
        textLabel.text = @"Swift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Concise syntax, readable & chainable.";
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.numberOfLines = 0;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:textLabel];
        
        separatorView = [[UIView alloc] init];
        separatorView.backgroundColor = UIColor.grayColor;
        
        [self addSubview:separatorView];
    }
    return self;
}

- (void)dealloc {
    Pin.logMissingLayoutCalls = false;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [[[[[[logo.pinObjc top] left] width:100] aspectRatio] marginWithTop:topLayoutGuide + 10 horizontal:10 bottom:10] layout];
    [[[[segmented.pinObjc rightOf:logo aligned:VerticalAlignTop] right] marginHorizontal:10] layout];
    [[[[[[textLabel.pinObjc belowOf:segmented aligned:HorizontalAlignLeft] widthOf:segmented] pinEdges] marginTop:10] sizeToFit:FitWidth] layout];
    [[[[[separatorView.pinObjc belowOfViews:@[logo, textLabel] aligned:HorizontalAlignLeft] rightTo:segmented.edge.right] height:1] marginTop:10] layout];
}

- (void) setLayoutGuidesTop:(CGFloat)top {
    topLayoutGuide = top;
}
@end
