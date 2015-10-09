#import <Masonry/Masonry.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <PromiseKit/PromiseKit.h>
#import <ZLSwipeableView/ZLSwipeableView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#include <stdlib.h>

#import "FlightInspireViewController.h"

#import "UIColor+Helper.h"
#import "ShadowedUIButton.h"
#import "ShadowUIView.h"
#import "UIView+Helper.h"
#import "Constants.h"
#import "HttpClient.h"

@interface FlightInspireViewController ()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (strong, nonatomic) ZLSwipeableView *swipeView;

@end

@implementation FlightInspireViewController {
  NSArray *places;
  NSMutableArray *likePlaces;
  NSMutableArray *unlikePlaces;
  
  int index, currentIndex;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  index = -1;
  currentIndex = 0;
  self.view.backgroundColor = [UIColor whiteGrayColor];
  places = @[];
  likePlaces = [NSMutableArray array];
  unlikePlaces = [NSMutableArray array];
  [self configureNavigationBar];
  [self initializeSwipeView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getData];
}

- (void)getData {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/locationSearch", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"term": @"",
                                            @"offset": [NSString stringWithFormat:@"%d", arc4random_uniform(50)],
                                            @"location": self.flight[@"endLocationName"]
                                            }]
  .then(^(NSArray *arr) {
    places = arr;
    if (places.count > 0) {
      currentIndex = 0;
      index = -1;
    }
    [self.swipeView loadNextSwipeableViewsIfNeeded];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"INSPIRE ME";
  self.navigationController.navigationBar.barTintColor = [UIColor appPrimaryColor];
  self.navigationController.navigationBar.translucent = FALSE;
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.extendedLayoutIncludesOpaqueBars = FALSE;
  self.automaticallyAdjustsScrollViewInsets = FALSE;
  
  // Configure back button for subsequent views
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:nil];
}

- (void)initializeSwipeView {
  CGRect swipeViewBounds = self.view.bounds;
  swipeViewBounds.origin = CGPointMake(25, 50);
  swipeViewBounds.size = CGSizeMake(self.view.bounds.size.width - 50, self.view.bounds.size.height / 1.3);
  
  self.swipeView = [[ZLSwipeableView alloc] initWithFrame:swipeViewBounds];
  self.swipeView.dataSource = self;
  self.swipeView.delegate = self;
  
  [self.view addSubview:self.swipeView];
}

#pragma mark - SwipableViewDelegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
  if (direction == ZLSwipeableViewDirectionLeft) {
    [unlikePlaces addObject:places[currentIndex]];
  } else if (direction == ZLSwipeableViewDirectionRight) {
    [likePlaces addObject:places[currentIndex]];
    NSString *requestUrl1 = [NSString stringWithFormat:@"%@/api/place/queryAndCreate", [Constants apiUrl]];
    NSString *requestUrl2 = [NSString stringWithFormat:@"%@/api/user/likePlace", [Constants apiUrl]];
    [HttpClient postWithUrl:requestUrl1 body:places[currentIndex]]
    .then(^(NSDictionary *place) {
      return [HttpClient postWithUrl:requestUrl2 body:@{
                                                 @"facebookId": [FBSDKAccessToken currentAccessToken].userID,
                                                 @"flightId": self.flight[@"_id"],
                                                 @"placeId": place[@"yelpId"]
                                                 }];
    })
    .catch(^(NSError *error) {
      NSLog(@"%@", [error localizedDescription]);
    });
    
  }
  currentIndex++;
  if (currentIndex >= places.count) {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
  
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
  [imageView sd_setImageWithURL:currentPlace[@"imageUrl"]
                       placeholderImage:nil];
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(cardView);
  }];
  
  UILabel *nameLabel = [[UILabel alloc] init];
  [cardView addSubview:nameLabel];
  
  [nameLabel setText:currentPlace[@"name"]];
  [nameLabel setBackgroundColor:[UIColor whiteColor]];
  [nameLabel setTextAlignment:NSTextAlignmentCenter];
  [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(cardView.mas_centerX);
    make.width.mas_equalTo(cardView.mas_width);
    make.bottom.mas_equalTo(imageView.mas_bottom);
  }];
  
  return cardView;
}

@end
