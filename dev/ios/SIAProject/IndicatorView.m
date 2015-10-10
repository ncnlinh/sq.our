#import <Masonry/Masonry.h>
#import <pop/POP.h>

#import "IndicatorView.h"

@interface IndicatorView()<POPAnimationDelegate>

@end

static NSString *const kFadeAnimation = @"FadeAnimation";
static NSString *const kScaleAnimation = @"ScaleAnimation";

@implementation IndicatorView

+ (IndicatorView *)addIndicatorForView:(UIView *)view withColor:(UIColor *)color {
  IndicatorView *indicator = [[IndicatorView alloc] initWithStyle:RTSpinKitViewStyle9CubeGrid
                                                           color:color];
  [view addSubview:indicator];
  
  [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(view);
  }];
  
  return indicator;
}

- (void)stopAnimatingWithAnimation {
  // Fade Animation
  POPBasicAnimation *fadeAnimation = [POPBasicAnimation easeInAnimation];
  fadeAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
  
  fadeAnimation.toValue = @(0.0);
  fadeAnimation.duration = 0.6;
  fadeAnimation.name = kFadeAnimation;
  fadeAnimation.delegate = self;
  [self pop_addAnimation:fadeAnimation forKey:kFadeAnimation];
  
  // Scale Animation
  POPBasicAnimation *scaleAnimation = [POPBasicAnimation easeInAnimation];
  scaleAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
  
  scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
  scaleAnimation.duration = 0.35;
  scaleAnimation.name = kScaleAnimation;
  scaleAnimation.delegate = self;
  [self  pop_addAnimation:scaleAnimation forKey:kScaleAnimation];
}

- (void)stopAnimating {
  [super stopAnimating];
  [self removeFromSuperview];
}

#pragma mark - Pop Animation Delegate
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
  if ([anim.name isEqualToString:kFadeAnimation]) {
    [self stopAnimating];
  }
}

@end
