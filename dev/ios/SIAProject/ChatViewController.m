#import <FontAwesomeKit/FontAwesomeKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "ChatViewController.h"

#import "HttpClient.h"
#import "Constants.h"
#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "FlightUserViewController.h"
#import "FlightSearchViewController.h"
#import "UIViewController+SideBarViewController.h"
#import "FlightCell.h"

@interface ChatViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChatViewController {
  // Flight Table View
  UITableView *flightTableView;
  
  // Array of flights
  NSArray *flightList;
}

static NSString *const kFlightCellIdentifier = @"FlightCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  flightList = @[];
  [self configureGesture];
  [self configureNavigationBar];
  [self configureFlightList];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getFlightList];
}

- (void)getFlightList {
  NSString *url = [NSString stringWithFormat:@"%@/api/user/flights", [Constants apiUrl]];
  [HttpClient postWithUrl:url body:@{
                                     @"facebookId": [FBSDKAccessToken currentAccessToken].userID
                                     }]
  .then(^(NSArray *flights) {
    flightList = flights;
    [flightTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureGesture {
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(panGestureRecognized:)];
  [self.view addGestureRecognizer:panGesture];
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"FLIGHTS";
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
  
  // Configure search button on the right of nav bar
  FAKIcon *addIcon = [FAKIonIcons paperAirplaneIconWithSize:28];
  [addIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  UIImage *addIconImage = [addIcon imageWithSize:CGSizeMake(28, 28)];
  UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
  [addButton setAdjustsImageWhenHighlighted:FALSE];
  [addButton setImage:addIconImage forState:UIControlStateNormal];
  [addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithCustomView:addButton];
  
  UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                  target:nil action:nil];
  rightSpacer.width = -10;
  
  
  [self.navigationItem setRightBarButtonItems:@[rightSpacer, addBarButton]];
  
  // Configure menu button on the left of nav bar
  UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                 target:nil action:nil];
  leftSpacer.width = -10;
  
  FAKIcon *menuIcon = [FAKIonIcons naviconIconWithSize:30];
  [menuIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  UIImage *menuIconImage = [menuIcon imageWithSize:CGSizeMake(30, 30)];
  UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:menuIconImage
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(menuButtonPressed:)];
  [self.navigationItem setLeftBarButtonItems:@[leftSpacer,menuButton]];
}

- (void)configureFlightList {
  flightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:flightTableView];
  flightTableView.dataSource = self;
  flightTableView.delegate = self;
  
  [flightTableView registerClass:[FlightCell class]
          forCellReuseIdentifier:kFlightCellIdentifier];
  
  [flightTableView setBackgroundColor:[UIColor whiteColor]];
  flightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [flightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_left);
    make.top.mas_equalTo(self.view.mas_top);
    make.size.mas_equalTo(self.view);
  }];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return flightList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FlightCell *cell = [tableView dequeueReusableCellWithIdentifier:kFlightCellIdentifier];
  if (cell == nil) {
    cell = [[FlightCell alloc] initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:kFlightCellIdentifier];
  }
  NSDictionary *flight = flightList[indexPath.row];
  [cell setFlightNumber:flight[@"flightNumbers"]];
  [cell setStartDate:[NSDate isoDateFromString:flight[@"startDate"]]];
  [cell setStartLocation:flight[@"startLocation"]];
  [cell setEndLocation:flight[@"endLocation"]];
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
  NSDictionary *flight = flightList[indexPath.row];
  FlightUserViewController *flightUserViewController = [[FlightUserViewController alloc] init];
  flightUserViewController.flight = flight;
  [self.navigationController pushViewController:flightUserViewController animated:TRUE];
}


#pragma mark - Gesture Recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
  SideBarViewController *sideBarVc = self.sideBarViewController;
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [sideBarVc.view endEditing:YES];
  
  // Present the view controller
  [sideBarVc panGestureRecognized:sender];
}

#pragma mark - Button Handler
- (void)addButtonPressed:(UIButton *)sender {
  FlightSearchViewController *flightSearchViewController = [[FlightSearchViewController alloc] init];
  [self.navigationController pushViewController:flightSearchViewController animated:TRUE];
}

- (void)menuButtonPressed:(UIButton *)sender {
  SideBarViewController *sideBarVc = self.sideBarViewController;
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [sideBarVc.view endEditing:YES];
  
  // Present the view controller
  [sideBarVc presentMenuViewController];
}


@end
