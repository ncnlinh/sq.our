#import <Masonry/Masonry.h>
#import <ZLSwipeableView/ZLSwipeableView.h>

#import "InspiredViewController.h"

#import "ShadowUIView.h"
#import "UIView+Helper.h"

@interface InspiredViewController ()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (strong, nonatomic) ZLSwipeableView *swipeView;

@end

@implementation InspiredViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  CGRect swipeViewBounds = self.view.bounds;
  swipeViewBounds.origin = CGPointMake(25, 50);
  swipeViewBounds.size = CGSizeMake(self.view.bounds.size.width - 50, self.view.bounds.size.height / 2.0);
  
  self.swipeView = [[ZLSwipeableView alloc] initWithFrame:swipeViewBounds];
  self.swipeView.dataSource = self;
  self.swipeView.delegate = self;
  
  [self.view addSubview:self.swipeView];
}

#pragma mark - SwipableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
  
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
  
}

#pragma mark - SwipableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
  ShadowUIView *cardView = [[ShadowUIView alloc] initWithFrame:swipeableView.bounds];
  cardView.backgroundColor = [UIColor lightGrayColor];
  [cardView configureForShadows];
  [cardView setShadowColor:[UIColor blackColor]];
  [cardView setShadowOpacity:0.33];
  [cardView setShadowOffset:CGSizeMake(0, 1.5)];
  [cardView setShadowRadius:4.0];
  
  return cardView;
}

@end
