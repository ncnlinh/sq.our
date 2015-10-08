#import "UIViewController+SideBarViewController.h"

@implementation UIViewController (SideBarViewController)

- (void)displayController:(UIViewController *)controller frame:(CGRect)frame {
  [self addChildViewController:controller];
  controller.view.frame = frame;
  [self.view addSubview:controller.view];
  [controller didMoveToParentViewController:self];
}

- (void)hideController:(UIViewController *)controller {
  [controller willMoveToParentViewController:nil];
  [controller.view removeFromSuperview];
  [controller removeFromParentViewController];
}

- (SideBarViewController *)sideBarViewController {
  UIViewController *iter = self.parentViewController;
  while (iter) {
    if ([iter isKindOfClass:[SideBarViewController class]]) {
      return (SideBarViewController *)iter;
    } else if (iter.parentViewController && iter.parentViewController != iter) {
      iter = iter.parentViewController;
    } else {
      iter = nil;
    }
  }
  
  return nil;
}

@end
