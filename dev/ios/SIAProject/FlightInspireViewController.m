#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>
#import <ZLSwipeableView/ZLSwipeableView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import "FlightInspireViewController.h"

#import "UIColor+Helper.h"
#import "ShadowedUIButton.h"
#import "ShadowUIView.h"
#import "UIView+Helper.h"
#import "Constants.h"
#import "HttpClient.h"

@interface FlightInspireViewController ()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (strong, nonatomic) ZLSwipeableView *swipeView;
@property (strong, nonatomic) UIButton *rejectButton;
@property (strong, nonatomic) UIButton *acceptButton;

@end

@implementation FlightInspireViewController {
  NSArray *places;
  
  int index;
}

static NSInteger const kFAButtonSize = 50;

- (void)viewDidLoad {
  [super viewDidLoad];
  index = -1;
  self.view.backgroundColor = [UIColor whiteGrayColor];
  places = @[];
  [self stubData];
  [self initializeSwipeView];
  [self initializeButtons];
}

- (void)getData {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/locationSearch", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"term": @""
                                            }]
  .then(^(NSArray *arr) {
    places = arr;
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)stubData {
  places = @[
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               },
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               },
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               },
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               },
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               },
             @{
               @"image": @"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"
               }
             ];
}

- (void)initializeSwipeView {
  CGRect swipeViewBounds = self.view.bounds;
  swipeViewBounds.origin = CGPointMake(25, 50);
  swipeViewBounds.size = CGSizeMake(self.view.bounds.size.width - 50, self.view.bounds.size.height / 2.0);
  
  self.swipeView = [[ZLSwipeableView alloc] initWithFrame:swipeViewBounds];
  self.swipeView.dataSource = self;
  self.swipeView.delegate = self;
  
  [self.view addSubview:self.swipeView];
}

- (void)initializeButtons {
  // Initialize button as the front-most UIControl
  self.rejectButton = [ShadowedUIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:self.rejectButton];
  [self.view bringSubviewToFront:self.rejectButton];
  
  // Configure appearance & behaviors
  [self.rejectButton setBackgroundColor:[UIColor redColor]];
  [self.rejectButton setCornerRadius:kFAButtonSize / 2.0];
  [self.rejectButton configureForShadows];
  [self.rejectButton setShadowColor:[UIColor blackColor]];
  [self.rejectButton setShadowOpacity:0.4];
  [self.rejectButton setShadowOffset:CGSizeMake(0.0, 2.0)];
  [self.rejectButton setShadowRadius:3.0];
  [self.rejectButton addTarget:self
                           action:@selector(rejectButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
  FAKIcon *addIcon = [FAKIonIcons plusRoundIconWithSize:25];
  [addIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  [self.rejectButton setAttributedTitle:[addIcon attributedString] forState:UIControlStateNormal];
  
  // Configure layout
  [self.rejectButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.view.mas_centerX).with.offset(-50);
    make.top.mas_equalTo(self.swipeView.mas_bottom).with.offset(20);
    make.size.mas_equalTo(CGSizeMake(kFAButtonSize, kFAButtonSize));
  }];
  
  // Initialize button as the front-most UIControl
  self.acceptButton = [ShadowedUIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:self.acceptButton];
  [self.view bringSubviewToFront:self.acceptButton];
  
  // Configure appearance & behaviors
  [self.acceptButton setBackgroundColor:[UIColor greenColor]];
  [self.acceptButton setCornerRadius:kFAButtonSize / 2.0];
  [self.acceptButton configureForShadows];
  [self.acceptButton setShadowColor:[UIColor blackColor]];
  [self.acceptButton setShadowOpacity:0.4];
  [self.acceptButton setShadowOffset:CGSizeMake(0.0, 2.0)];
  [self.acceptButton setShadowRadius:3.0];
  [self.acceptButton addTarget:self
                        action:@selector(acceptButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
  FAKIcon *acceptIcon = [FAKIonIcons plusRoundIconWithSize:25];
  [acceptIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  [self.acceptButton setAttributedTitle:[acceptIcon attributedString] forState:UIControlStateNormal];
  
  // Configure layout
  [self.acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_centerX).with.offset(50);
    make.top.mas_equalTo(self.swipeView.mas_bottom).with.offset(20);
    make.size.mas_equalTo(CGSizeMake(kFAButtonSize, kFAButtonSize));
  }];

}

#pragma mark - SwipableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
  if (direction == ZLSwipeableViewDirectionLeft) {
    
  } else if (direction == ZLSwipeableViewDirectionRight) {
    
  }
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
  
}

#pragma mark - Reject Button Pressed
- (void)rejectButtonPressed:(UIButton *)rejectButton {
  [self.swipeView swipeTopViewToLeft];
}

- (void)acceptButtonPressed:(UIButton *)acceptButton {
  [self.swipeView swipeTopViewToRight];
}


#pragma mark - SwipableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
  index++;
  if (index >= places.count) {
    return nil;
  }
  NSDictionary *currentPlace = places[index];
  
  ShadowUIView *cardView = [[ShadowUIView alloc] initWithFrame:swipeableView.bounds];
  cardView.backgroundColor = [UIColor lightGrayColor];
  [cardView configureForShadows];
  [cardView setShadowColor:[UIColor blackColor]];
  [cardView setShadowOpacity:0.33];
  [cardView setShadowOffset:CGSizeMake(0, 1.5)];
  [cardView setShadowRadius:4.0];
  
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [cardView addSubview:imageView];
  
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.clipsToBounds = TRUE;
  [imageView sd_setImageWithURL:currentPlace[@"image"]
                       placeholderImage:nil];
  
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(cardView);
  }];
  
  return cardView;
}

@end
