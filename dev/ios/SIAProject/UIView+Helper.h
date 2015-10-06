#import <UIKit/UIKit.h>

/**
 *  Set of UIView helper functions
 */
@interface UIView (Helper)

#pragma mark - Corner Radius
/**
 *  Set the corner radius of the layer of the UIView object
 *
 *  @param radius The radius of the corner
 */
- (void)setCornerRadius:(float)radius;

#pragma mark - Border
/**
 *  Set border width of the layer of the UIView object
 *
 *  @param width The width of the border
 */
- (void)setBorderWidth:(float)width;

/**
 *  Set border color of the layer of the UIView object
 *
 *  @param color The color of the border
 */
- (void)setBorderColor:(UIColor *)color;

#pragma mark - Shadow
/**
 *  Do configuration for optimized shadow of the layer of the UIView object
 */
- (void)configureForShadows;

/**
 *  Set the shadow color of the layer of the UIView object
 *
 *  @param color The color of the shadow
 */
- (void)setShadowColor:(UIColor *)color;

/**
 *  Set the shadow opacity of the layer of the UIView object
 *
 *  @param opacity The opacity of the shadow
 */
- (void)setShadowOpacity:(float)opacity;

/**
 *  Set the shadow radius of the layer of the UIView object
 *
 *  @param radius The radius of the shadow
 */
- (void)setShadowRadius:(float)radius;

/**
 *  Set the shadow offset of the layer of the UIView object
 *
 *  @param offset The offset of the shadow
 */
- (void)setShadowOffset:(CGSize)offset;

/**
 *  Set the shadow path of the layer of the UIView object
 *
 *  @param path The path of the shadow
 */
- (void)setShadowPath:(CGPathRef)path;

@end
