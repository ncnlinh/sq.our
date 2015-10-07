#import <UIKit/UIKit.h>

/**
 *  Set of UIColor Helper functions. This also contain list of constant colors used throughout the app.
 */
@interface UIColor (Helper)

#pragma mark - Color Constants
+ (UIColor *)appPrimaryColor;
+ (UIColor *)appSecondaryColor;
+ (UIColor *)appAccentColor;
+ (UIColor *)appWarningColor;
+ (UIColor *)whiteGrayColor;
+ (UIColor *)silverColor;

#pragma mark - Color Helper Functions
/**
 *  Get the corresponding color from the given hex number
 *
 *  @param hexNum The hex number representing a color
 *
 *  @return the corresponding color
 */
+ (UIColor *)colorFromHex:(int)hexNum;

/**
 *  Convert a color into its darker color with given ratio amount
 *
 *  @param ratio The ratio of darkerness
 *
 *  @return the darker color
 */
- (UIColor *)darkerColor:(float)ratio;

/**
 *  Convert a color into it lighter color with given ratio amount
 *
 *  @param ratio The ratio of lighterness
 *
 *  @return the lighter color
 */
- (UIColor *)lighterColor:(float)ratio;

@end
