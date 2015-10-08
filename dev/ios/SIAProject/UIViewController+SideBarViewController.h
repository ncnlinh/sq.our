#import <UIKit/UIKit.h>
#import "SideBarViewController.h"

@interface UIViewController (SideBarViewController)

@property (strong, readonly, nonatomic) SideBarViewController *sideBarViewController;

- (void)displayController:(UIViewController *)controller frame:(CGRect)frame;
- (void)hideController:(UIViewController *)controller;

@end
