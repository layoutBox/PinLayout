
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

    logo.pinObjc.top().left().width(100).marginTHB(topLayoutGuide + 10, 10, 10).layout();
    separatorView.pinObjc.belowOfAligned(logo, HorizontalAlignLeft).height(1).marginTop(10).layout();
}

@end
