#import <QuartzCore/QuartzCore.h>

#import "UIView+Helper.h"

@implementation UIView (Helper)

#pragma mark - Corner Radius
- (void)setCornerRadius:(float)radius {
  self.layer.cornerRadius = radius;
}

#pragma mark - Border
- (void)setBorderWidth:(float)width {
  self.layer.borderWidth = width;
}

- (void)setBorderColor:(UIColor *)color {
  self.layer.borderColor = [color CGColor];
}

#pragma mark - Shadow
- (void)configureForShadows {
  self.layer.masksToBounds = FALSE;
  self.layer.shouldRasterize = TRUE;
  self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setShadowColor:(UIColor *)color {
  [self.layer setShadowColor:[color CGColor]];
}

- (void)setShadowOpacity:(float)opacity {
  [self.layer setShadowOpacity:opacity];
}

- (void)setShadowRadius:(float)radius {
  [self.layer setShadowRadius:radius];
}

- (void)setShadowOffset:(CGSize)offset {
  [self.layer setShadowOffset:offset];
}

- (void)setShadowPath:(CGPathRef)path {
  [self.layer setShadowPath:path];
}

@end
