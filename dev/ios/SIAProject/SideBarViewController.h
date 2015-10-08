/*
 This is referenced with modifications from Github Project:
 https://github.com/romaonthego/REFrostedViewController
 */

#import <UIKit/UIKit.h>

@class SideBarViewController;

@protocol SideBarViewControllerDelegate <NSObject>

@optional
- (void)sideBarViewController:(SideBarViewController *)frostedViewController
willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                     duration:(NSTimeInterval)duration;

- (void)sideBarViewController:(SideBarViewController *)frostedViewController
       didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer;

- (void)sideBarViewController:(SideBarViewController *)frostedViewController
   willShowMenuViewController:(UIViewController *)menuViewController;

- (void)sideBarViewController:(SideBarViewController *)frostedViewController
    didShowMenuViewController:(UIViewController *)menuViewController;

- (void)sideBarViewController:(SideBarViewController *)frostedViewController
   willHideMenuViewController:(UIViewController *)menuViewController;

- (void)sideBarViewController:(SideBarViewController *)frostedViewController
    didHideMenuViewController:(UIViewController *)menuViewController;

@end

@interface SideBarViewController : UIViewController

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) BOOL panGestureEnabled;
@property (assign, nonatomic) CGFloat backgroundFadeAmount;
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) BOOL limitMenuViewSize;
@property (assign, readwrite, nonatomic) CGSize menuViewSize;

@property (weak, nonatomic) id<SideBarViewControllerDelegate> delegate;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic) UIViewController *menuViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController
                 menuViewController:(UIViewController *)menuViewController;
- (void)presentMenuViewController;
- (void)hideMenuViewController;
- (void)resizeMenuViewControllerToSize:(CGSize)size;
- (void)hideMenuViewControllerWithCompletionHandler:(void(^)(void))completionHandler;
- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer;

@end
