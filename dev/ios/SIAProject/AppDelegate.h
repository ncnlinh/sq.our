#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  Set the root view controller of the application
 *
 *  @param viewController The next root view controller
 */
- (void)setRootViewController:(UIViewController *)viewController;

@end

