#import "UIFont+Helper.h"

@implementation UIFont (Helper)

#pragma mark - Custom Fonts
+ (UIFont *)lightPrimaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"OpenSans-Light" size:size];
}

+ (UIFont *)regularPrimaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"OpenSans" size:size];
}

+ (UIFont *)mediumPrimaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"OpenSans-Semibold" size:size];
}

+ (UIFont *)boldPrimaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}

+ (UIFont *)lightSecondaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"Lato-Light" size:size];
}

+ (UIFont *)regularSecondaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"Lato-Regular" size:size];
}

+ (UIFont *)mediumSecondaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)boldSecondaryFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"Lato-Black" size:size];
}

@end
