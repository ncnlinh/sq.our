#import "RTSpinKitView.h"

@interface IndicatorView : RTSpinKitView

+ (IndicatorView *)addIndicatorForView:(UIView *)view withColor:(UIColor *)color;

- (void)stopAnimatingWithAnimation;

@end
