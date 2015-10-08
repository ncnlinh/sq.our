#import <UIKit/UIKit.h>

/**
 *  Set of UIFont helper functions. This also contain list of fonts which will be used throughout the app
 */
@interface UIFont (Helper)

#pragma mark - Custom Fonts
+ (UIFont *)lightPrimaryFontWithSize:(CGFloat)size;
+ (UIFont *)regularPrimaryFontWithSize:(CGFloat)size;
+ (UIFont *)mediumPrimaryFontWithSize:(CGFloat)size;
+ (UIFont *)boldPrimaryFontWithSize:(CGFloat)size;

+ (UIFont *)lightSecondaryFontWithSize:(CGFloat)size;
+ (UIFont *)regularSecondaryFontWithSize:(CGFloat)size;
+ (UIFont *)mediumSecondaryFontWithSize:(CGFloat)size;
+ (UIFont *)boldSecondaryFontWithSize:(CGFloat)size;

@end
