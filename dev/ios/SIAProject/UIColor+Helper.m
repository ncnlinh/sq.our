#import "UIColor+Helper.h"

@implementation UIColor (Helper)

#pragma mark - Color Constants
+ (UIColor *)appPrimaryColor {
  static UIColor *appPrimaryColor = nil;
  if (!appPrimaryColor) {
    appPrimaryColor = [UIColor colorFromHex:0x00D09D];
  }
  
  return appPrimaryColor;
}

+ (UIColor *)appSecondaryColor {
  static UIColor *appSecondaryColor = nil;
  if (!appSecondaryColor) {
    appSecondaryColor = [UIColor colorFromHex:0x22A7F0];
  }
  
  return appSecondaryColor;
}

+ (UIColor *)appAccentColor {
  static UIColor *appAccentColor = nil;
  if (!appAccentColor) {
    appAccentColor = [UIColor colorFromHex:0xFF9800];
  }
  
  return appAccentColor;
}

+ (UIColor *)appWarningColor {
  static UIColor *appWarningColor = nil;
  if (!appWarningColor) {
    appWarningColor = [UIColor colorFromHex:0xE74C3C];
  }
  
  return appWarningColor;
}


+ (UIColor *)whiteGrayColor {
  static UIColor *whiteGrayColor = nil;
  if (!whiteGrayColor) {
    whiteGrayColor = [UIColor colorWithWhite:0.97 alpha:1.0];
  }
  
  return whiteGrayColor;
}

+ (UIColor *)silverColor {
  static UIColor *silverColor = nil;
  if (!silverColor) {
    silverColor = [UIColor colorFromHex:0xBDC3C7];
  }
  
  return silverColor;
}

#pragma mark - Color Helper Functions
+ (UIColor *)colorFromHex:(int)hexNum {
  return [UIColor colorWithRed:((float)((hexNum & 0xFF0000) >> 16))/255.0
                         green:((float)((hexNum & 0x00FF00) >>  8))/255.0
                          blue:((float)((hexNum & 0x0000FF) >>  0))/255.0
                         alpha:1.0];
}

- (UIColor *)lighterColor:(float)ratio {
  CGFloat h, s, b, a;
  if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
    return [UIColor colorWithHue:h
                      saturation:s
                      brightness:MIN(b * (1 + ratio), 1.0)
                           alpha:a];
  return nil;
}

- (UIColor *)darkerColor:(float)ratio {
  CGFloat h, s, b, a;
  if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
    return [UIColor colorWithHue:h
                      saturation:s
                      brightness:MAX(b * (1- ratio), 0.0)
                           alpha:a];
  return nil;
}

@end
