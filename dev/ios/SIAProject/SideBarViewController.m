#import "SideBarViewController.h"

#import "SideBarContainerViewController.h"
#import "UIViewController+SideBarViewController.h"

@interface SideBarViewController ()

@property (assign, nonatomic) CGFloat imageViewWidth;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) BOOL visible;
@property (strong, nonatomic) SideBarContainerViewController *containerViewController;
@property (assign, nonatomic) BOOL automaticSize;
@property (assign, nonatomic) CGSize calculatedMenuViewSize;

@end

@implementation SideBarViewController

- (id)init {
  self = [super init];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super initWithCoder:decoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  self.wantsFullScreenLayout = YES;
#pragma clang diagnostic pop
  _panGestureEnabled = YES;
  _animationDuration = 0.35f;
  _backgroundFadeAmount = 0.3f;
  _containerViewController = [[SideBarContainerViewController alloc] init];
  _containerViewController.sideBarViewController = self;
  _limitMenuViewSize = TRUE;
  _menuViewSize = CGSizeZero;
  _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:_containerViewController
                                                                  action:@selector(panGestureRecognized:)];
  _automaticSize = YES;
}

- (id)initWithContentViewController:(UIViewController *)contentViewController
                 menuViewController:(UIViewController *)menuViewController {
  self = [self init];
  if (self) {
    _contentViewController = contentViewController;
    _menuViewController = menuViewController;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self displayController:self.contentViewController frame:self.view.bounds];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.contentViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
  return self.contentViewController;
}

#pragma mark -
#pragma mark Setters

- (void)setContentViewController:(UIViewController *)contentViewController {
  if (!_contentViewController) {
    _contentViewController = contentViewController;
    return;
  }
  
  [_contentViewController removeFromParentViewController];
  [_contentViewController.view removeFromSuperview];
  
  if (contentViewController) {
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = self.containerViewController.view.frame;
    [self.view insertSubview:contentViewController.view atIndex:0];
    [contentViewController didMoveToParentViewController:self];
  }
  _contentViewController = contentViewController;
  
  if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
  }
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
  if (_menuViewController) {
    [_menuViewController.view removeFromSuperview];
    [_menuViewController removeFromParentViewController];
  }
  
  _menuViewController = menuViewController;
  
  CGRect frame = _menuViewController.view.frame;
  [_menuViewController willMoveToParentViewController:nil];
  [_menuViewController removeFromParentViewController];
  [_menuViewController.view removeFromSuperview];
  _menuViewController = menuViewController;
  if (!_menuViewController)
    return;
  
  [self.containerViewController addChildViewController:menuViewController];
  menuViewController.view.frame = frame;
  [self.containerViewController.containerView addSubview:menuViewController.view];
  [menuViewController didMoveToParentViewController:self];
}

- (void)setMenuViewSize:(CGSize)menuViewSize {
  _menuViewSize = menuViewSize;
  self.automaticSize = NO;
}

#pragma mark - View Controller Handler

- (void)presentMenuViewController {
  [self presentMenuViewControllerWithAnimatedApperance:YES];
}

- (void)presentMenuViewControllerWithAnimatedApperance:(BOOL)animateApperance {
  if ([self.delegate conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
      && [self.delegate respondsToSelector:@selector(sideBarViewController:willShowMenuViewController:)]) {
    [self.delegate sideBarViewController:self willShowMenuViewController:self.menuViewController];
  }
  
  self.containerViewController.animateApperance = animateApperance;
  if (self.automaticSize) {
    self.calculatedMenuViewSize = CGSizeMake(275.0f,
                                             self.contentViewController.view.frame.size.height);
  } else {
    CGFloat width = _menuViewSize.width > 0 ? _menuViewSize.width
    : self.contentViewController.view.frame.size.width;
    CGFloat height = _menuViewSize.height > 0 ? _menuViewSize.height
    : self.contentViewController.view.frame.size.height;
    self.calculatedMenuViewSize = CGSizeMake(width, height);
  }
  
  [self displayController:self.containerViewController frame:self.contentViewController.view.frame];
  self.visible = YES;
}

- (void)hideMenuViewControllerWithCompletionHandler:(void(^)(void))completionHandler {
  if (!self.visible) {
    return;
  }
  [self.containerViewController hideWithCompletionHandler:completionHandler];
}

- (void)resizeMenuViewControllerToSize:(CGSize)size {
  [self.containerViewController resizeToSize:size];
}

- (void)hideMenuViewController {
  [self hideMenuViewControllerWithCompletionHandler:nil];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
  if ([self.delegate conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
      && [self.delegate respondsToSelector:@selector(sideBarViewController:didRecognizePanGesture:)])
    [self.delegate sideBarViewController:self didRecognizePanGesture:recognizer];
  
  if (!self.panGestureEnabled)
    return;
  
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    [self presentMenuViewControllerWithAnimatedApperance:NO];
  }
  
  [self.containerViewController panGestureRecognized:recognizer];
}

#pragma mark - Rotation handler

- (BOOL)shouldAutorotate {
  return self.contentViewController.shouldAutorotate;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  if ([self.delegate conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
      && [self.delegate respondsToSelector:
          @selector(sideBarViewController:willAnimateRotationToInterfaceOrientation:duration:)])
    [self.delegate sideBarViewController:self
willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                duration:duration];
  
  if (self.visible) {
    if (self.automaticSize) {
      self.calculatedMenuViewSize = CGSizeMake(275.0f,
                                               self.view.bounds.size.height);
    } else {
      CGFloat width = _menuViewSize.width > 0 ? _menuViewSize.width : self.view.bounds.size.width;
      CGFloat height = _menuViewSize.height > 0 ? _menuViewSize.height : self.view.bounds.size.height;
      self.calculatedMenuViewSize = CGSizeMake(width, height);
    }
  }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
  if (!self.visible) {
    self.calculatedMenuViewSize = CGSizeZero;
  }
}

@end

