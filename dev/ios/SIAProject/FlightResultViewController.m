#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>

#import "FlightResultViewController.h"

#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "UIViewController+SideBarViewController.h"
#import "FlightCell.h"

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
  [self stubFlightList];
  [self configureNavigationBar];
  [self configureFlightList];
}

- (void)stubFlightList {
  flightList = @[
                 @{
                   @"flightNumbers": @"A123",
                   @"startDate": [[NSDate new] isoDateString],
                   @"startLocation": @"Singapore",
                   @"endLocation": @"San Francisco"
                   },
                 @{
                   @"flightNumbers": @"B238",
                   @"startDate": [[NSDate new] isoDateString],
                   @"startLocation": @"Viet Nam",
                   @"endLocation": @"Los Angeles"
                   }
                 ];
}


- (void)configureNavigationBar {
  //  [QuickDeskHelper removeNavigationBarOutline:self];
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
//  [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
//  FlightUserViewController *flightUserViewController = [[FlightUserViewController alloc] init];
//  [self.navigationController pushViewController:flightUserViewController animated:TRUE];
  // Select Flight
}

@end
