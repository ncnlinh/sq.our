#import "SideBarContainerViewController.h"

#import "SideBarViewController.h"
#import "UIViewController+SideBarViewController.h"

@interface SideBarContainerViewController ()

@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;
@property (strong, readwrite, nonatomic) NSMutableArray *backgroundViews;
@property (strong, readwrite, nonatomic) UIView *containerView;
@property (assign, readwrite, nonatomic) CGPoint containerOrigin;

@end

@interface SideBarViewController ()

@property (assign, readwrite, nonatomic) BOOL visible;
@property (assign, readwrite, nonatomic) CGSize calculatedMenuViewSize;

@end

@implementation SideBarContainerViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.backgroundViews = [NSMutableArray array];
  for (NSInteger i = 0; i < 4; i++) {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.0f;
    [self.view addSubview:backgroundView];
    [self.backgroundViews addObject:backgroundView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(tapGestureRecognized:)];
    [backgroundView addGestureRecognizer:tapRecognizer];
  }
  
  self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height)];
  [self.view addSubview:self.containerView];
  
  if (self.sideBarViewController.menuViewController) {
    [self addChildViewController:self.sideBarViewController.menuViewController];
    self.sideBarViewController.menuViewController.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.sideBarViewController.menuViewController.view];
    [self.sideBarViewController.menuViewController didMoveToParentViewController:self];
  }
  
  [self.view addGestureRecognizer:self.sideBarViewController.panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if(!self.sideBarViewController.visible) {
    self.backgroundImageView.image = self.screenshotImage;
    self.backgroundImageView.frame = self.view.bounds;
    self.sideBarViewController.menuViewController.view.frame = self.containerView.bounds;
    
    [self setContainerFrame:CGRectMake(- self.sideBarViewController.calculatedMenuViewSize.width,
                                       0,
                                       self.sideBarViewController.calculatedMenuViewSize.width,
                                       self.sideBarViewController.calculatedMenuViewSize.height)];
    
    if (self.animateApperance)
      [self show];
  }
}

- (void)setContainerFrame:(CGRect)frame {
  UIView *leftBackgroundView = self.backgroundViews[0];
  UIView *topBackgroundView = self.backgroundViews[1];
  UIView *bottomBackgroundView = self.backgroundViews[2];
  UIView *rightBackgroundView = self.backgroundViews[3];
  
  leftBackgroundView.frame = CGRectMake(0, 0, frame.origin.x, self.view.frame.size.height);
  rightBackgroundView.frame = CGRectMake(frame.size.width + frame.origin.x,
                                         0,
                                         self.view.frame.size.width - frame.size.width - frame.origin.x,
                                         self.view.frame.size.height);
  
  topBackgroundView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.origin.y);
  bottomBackgroundView.frame = CGRectMake(frame.origin.x,
                                          frame.size.height + frame.origin.y,
                                          frame.size.width,
                                          self.view.frame.size.height);
  
  self.containerView.frame = frame;
  self.backgroundImageView.frame = CGRectMake(- frame.origin.x,
                                              - frame.origin.y,
                                              self.view.bounds.size.width,
                                              self.view.bounds.size.height);
}

- (void)setBackgroundViewsAlpha:(CGFloat)alpha {
  for (UIView *view in self.backgroundViews) {
    view.alpha = alpha;
  }
}

- (void)resizeToSize:(CGSize)size {
  [UIView animateWithDuration:self.sideBarViewController.animationDuration animations:^{
    [self setContainerFrame:CGRectMake(0, 0, size.width, size.height)];
    [self setBackgroundViewsAlpha:self.sideBarViewController.backgroundFadeAmount];
  } completion:nil];
}

- (void)show {
  void (^completionHandler)(BOOL finished) = ^(BOOL finished) {
    if ([self.sideBarViewController.delegate
         conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
        && [self.sideBarViewController.delegate
            respondsToSelector:@selector(sideBarViewController:didShowMenuViewController:)]) {
          [self.sideBarViewController.delegate sideBarViewController:self.sideBarViewController didShowMenuViewController:self.sideBarViewController.menuViewController];
        }
  };
  
  [UIView animateWithDuration:self.sideBarViewController.animationDuration animations:^{
    [self setContainerFrame:CGRectMake(0,
                                       0,
                                       self.sideBarViewController.calculatedMenuViewSize.width,
                                       self.sideBarViewController.calculatedMenuViewSize.height)];
    [self setBackgroundViewsAlpha:self.sideBarViewController.backgroundFadeAmount];
  } completion:completionHandler];
}


- (void)hide {
  [self hideWithCompletionHandler:nil];
}

- (void)hideWithCompletionHandler:(void(^)(void))completionHandler {
  void (^completionHandlerBlock)(void) = ^{
    if ([self.sideBarViewController.delegate
         conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
        && [self.sideBarViewController.delegate
            respondsToSelector:@selector(sideBarViewController:didHideMenuViewController:)]) {
          [self.sideBarViewController.delegate sideBarViewController:self.sideBarViewController
                                           didHideMenuViewController:self.sideBarViewController.menuViewController];
        }
    if (completionHandler)
      completionHandler();
  };
  
  if ([self.sideBarViewController.delegate
       conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
      && [self.sideBarViewController.delegate
          respondsToSelector:@selector(sideBarViewController:willHideMenuViewController:)]) {
        [self.sideBarViewController.delegate sideBarViewController:self.sideBarViewController
                                        willHideMenuViewController:self.sideBarViewController.menuViewController];
      }
  
  [UIView animateWithDuration:self.sideBarViewController.animationDuration animations:^{
    [self setContainerFrame:CGRectMake(- self.sideBarViewController.calculatedMenuViewSize.width,
                                       0,
                                       self.sideBarViewController.calculatedMenuViewSize.width,
                                       self.sideBarViewController.calculatedMenuViewSize.height)];
    [self setBackgroundViewsAlpha:0];
  } completion:^(BOOL finished) {
    self.sideBarViewController.visible = NO;
    [self.sideBarViewController hideController:self];
    completionHandlerBlock();
  }];
}

- (void)refreshBackgroundImage {
  self.backgroundImageView.image = self.screenshotImage;
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer {
  [self hide];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
  if ([self.sideBarViewController.delegate
       conformsToProtocol:@protocol(SideBarViewControllerDelegate)]
      && [self.sideBarViewController.delegate
          respondsToSelector:@selector(sideBarViewController:didRecognizePanGesture:)])
    [self.sideBarViewController.delegate sideBarViewController:self.sideBarViewController
                                        didRecognizePanGesture:recognizer];
  
  if (!self.sideBarViewController.panGestureEnabled)
    return;
  
  CGPoint point = [recognizer translationInView:self.view];
  
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    self.containerOrigin = self.containerView.frame.origin;
  }
  
  if (recognizer.state == UIGestureRecognizerStateChanged) {
    CGRect frame = self.containerView.frame;
    
    frame.origin.x = self.containerOrigin.x + point.x;
    if (frame.origin.x > 0) {
      frame.origin.x = 0;
      
      if (!self.sideBarViewController.limitMenuViewSize) {
        frame.size.width = self.sideBarViewController.calculatedMenuViewSize.width
        + self.containerOrigin.x + point.x;
        if (frame.size.width > self.view.frame.size.width)
          frame.size.width = self.view.frame.size.width;
      }
    }
    
    [self setContainerFrame:frame];
  }
  
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    if ([recognizer velocityInView:self.view].x < 0) {
      [self hide];
    } else {
      [self show];
    }
  }
}

- (void)fixLayoutWithDuration:(NSTimeInterval)duration {
  
  [self setContainerFrame:CGRectMake(0,
                                     0,
                                     self.sideBarViewController.calculatedMenuViewSize.width,
                                     self.sideBarViewController.calculatedMenuViewSize.height)];
  [self setBackgroundViewsAlpha:self.sideBarViewController.backgroundFadeAmount];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self fixLayoutWithDuration:duration];
}

@end
