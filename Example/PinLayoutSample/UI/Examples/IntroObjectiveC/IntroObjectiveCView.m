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

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [[[[[[logo.pinObjc top] left] width:100] aspectRatio] marginWithTop:topLayoutGuide + 10 horizontal:10 bottom:10] layout];
    [[[[segmented.pinObjc rightOf:logo aligned:VerticalAlignTop] right] marginHorizontal:10] layout];
    [[[[[[textLabel.pinObjc belowOf:segmented aligned:HorizontalAlignLeft] widthOf:segmented] pinEdges] marginTop:10] fitSize] layout];
    [[[[[separatorView.pinObjc belowOfViews:@[logo, textLabel] aligned:HorizontalAlignLeft] rightTo:segmented.edge.right] height:1] marginTop:10] layout];
}

- (void) setLayoutGuidesTop:(CGFloat)top {
    topLayoutGuide = top;
}
@end
