#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "FlightResultViewController.h"

#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "UIViewController+SideBarViewController.h"
#import "FlightCell.h"
#import "HttpClient.h"
#import "Constants.h"

@interface FlightResultViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FlightResultViewController {
  // Flight Table View
  UITableView *flightTableView;
  
  // Array of flights
  NSArray *flightList;
}

static NSString *const kFlightCellIdentifier = @"FlightCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  flightList = @[];
  [self configureNavigationBar];
  [self configureFlightList];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getFlights];
}

- (void)getFlights {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/flightsearch", [Constants apiUrl]];
  NSLog(@"%@", [self.date formattedDateWithFormat:@"YYYY-MM-dd"]);
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"startDate": [self.date formattedDateWithFormat:@"YYYY-MM-dd"],
                                            @"startLocation": self.startLocation,
                                            @"endLocation": self.endLocation,
                                            @"marketingAirlines": @"SQ",
                                            @"currency": @"SGD"
                                            }]
  .then(^(NSArray *flights) {
    flightList = flights;
    [flightTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"RESULTS";
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
  [cell setStartLocation:flight[@"startLocation"]];
  [cell setEndLocation:flight[@"endLocation"]];
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *flight = flightList[indexPath.row];
  NSString *requestUrl1 = [NSString stringWithFormat:@"%@/api/flight/queryAndCreate", [Constants apiUrl]];
  NSString *requestUrl2 = [NSString stringWithFormat:@"%@/api/flight/addUser", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl1 body:@{
                                             @"flightNumbers": flight[@"flightNumbers"],
                                             @"startLocation": flight[@"startLocation"],
                                             @"endLocation": flight[@"endLocation"],
                                             @"startDate": flight[@"startDate"],
                                             @"endLocationName": self.endLocationName
                                            }]
  .then(^(NSDictionary *resultFlight) {
    return [HttpClient postWithUrl:requestUrl2 body:@{
                                               @"_id": resultFlight[@"_id"],
                                               @"user": @{
                                                   @"facebookId": [FBSDKAccessToken currentAccessToken].userID,
                                                   @"purpose": @"Hi guys, let's have a blast"
                                                 }
                                               }];
  })
  .then(^{
    [self.navigationController popToRootViewControllerAnimated:TRUE];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

@end
