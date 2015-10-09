#import "ShadowedUIButton.h"

#import "UIView+Helper.h"

@implementation ShadowedUIButton

#pragma mark - Auto Layout Handler
- (void)layoutSubviews {
  [super layoutSubviews];
  [self setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  cornerRadius:self.layer.cornerRadius] CGPath]];
}

@end
