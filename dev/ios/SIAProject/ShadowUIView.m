#import "ShadowUIView.h"
#import "UIView+Helper.h"

@implementation ShadowUIView

#pragma mark - Auto Layout Handler
- (void)layoutSubviews {
  [super layoutSubviews];
  [self setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  cornerRadius:self.layer.cornerRadius] CGPath]];
}

@end
