#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "FlightSummaryViewController.h"

#import "UIColor+Helper.h"
#import "FlightSummaryCell.h"
#import "ChatGroupViewController.h"
#import "HttpClient.h"
#import "Constants.h"

@interface FlightSummaryViewController()<UITableViewDataSource, UITableViewDelegate, FlightSummaryCellDelegate>

@end

@implementation FlightSummaryViewController {
  NSArray *places;
  
  UITableView *placesTableView;
}

static NSString *const kPlaceCellIdentifier = @"PlaceIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  places = @[];
  [self configureNavigationBar];
  [self initializeTableView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getPlaces];
}

- (void)getPlaces {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/places", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"facebookId": self.facebookId,
                                            @"flightId": self.flight[@"_id"]
                                            }]
  .then(^(NSArray *placeList) {
    places = placeList;
    [placesTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"INITIEARY";
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

- (void)initializeTableView {
  placesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:placesTableView];
  placesTableView.dataSource = self;
  placesTableView.delegate = self;
  
  [placesTableView registerClass:[FlightSummaryCell class]
        forCellReuseIdentifier:kPlaceCellIdentifier];
  
  [placesTableView setBackgroundColor:[UIColor whiteColor]];
  placesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [placesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
  return places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FlightSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlaceCellIdentifier];
  if (cell == nil) {
    cell = [[FlightSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:kPlaceCellIdentifier];
  }
  NSDictionary *place = places[indexPath.row];
  [cell setImageUrl:place[@"imageUrl"]];
  [cell setName:place[@"name"]];
  [cell setAddress:place[@"address"]];
  [cell setSnippet:place[@"description"]];
  [cell setIndex:(int) indexPath.row];
  [cell setIsUser:[self.facebookId isEqual:[FBSDKAccessToken currentAccessToken].userID]];
  cell.delegate = self;
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 400;
}

#pragma mark - FlightSummaryCellDelegate
- (void)chatButtonPressed:(int)index {
  ChatGroupViewController *chatGroupViewController = [[ChatGroupViewController alloc] init];
  chatGroupViewController.flight = self.flight;
  chatGroupViewController.place = places[index];
  [self.navigationController pushViewController:chatGroupViewController animated:YES];
}

@end
