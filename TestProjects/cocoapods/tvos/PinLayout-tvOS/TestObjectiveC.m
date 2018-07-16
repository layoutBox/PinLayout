
#import <Foundation/Foundation.h>

@import UIKit;
@import PinLayout;

@interface IntroObjectiveCView: UIView {
}
@end

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
    [[[[[[textLabel.pinObjc belowOf:segmented aligned:HorizontalAlignLeft] widthOf:segmented] pinEdges] marginTop:10] sizeToFit:FitWidth] layout];
    [[[[[separatorView.pinObjc belowOfViews:@[logo, textLabel] aligned:HorizontalAlignLeft] rightTo:segmented.edge.right] height:1] marginTop:10] layout];
}

@end
