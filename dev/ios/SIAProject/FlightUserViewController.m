#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "FlightUserViewController.h"

#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "FlightInspireViewController.h"
#import "UserCell.h"
#import "HttpClient.h"
#import "Constants.h"

@interface FlightUserViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FlightUserViewController {
  // Flight Table View
  UITableView *userTableView;
  
  // Array of flights
  NSArray *userList;
}

static NSString *const kUserCellIdentifier = @"UserCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  userList = @[];
  [self configureNavigationBar];
  [self configureFlightList];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getUserList];
}

- (void)getUserList {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/flight/users", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"_id": self.flight[@"_id"]
                                            }]
  .then(^(NSArray *users) {
    userList = users;
    [userTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureNavigationBar {
  //  [QuickDeskHelper removeNavigationBarOutline:self];
  self.navigationItem.title = @"PASSENGERS";
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
  FAKIcon *addIcon = [FAKIonIcons iosColorWandIconWithSize:28];
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
}

- (void)configureFlightList {
  userTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:userTableView];
  userTableView.dataSource = self;
  userTableView.delegate = self;
  
  [userTableView registerClass:[UserCell class]
          forCellReuseIdentifier:kUserCellIdentifier];
  
  [userTableView setBackgroundColor:[UIColor whiteColor]];
  userTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
  return userList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UserCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCellIdentifier];
  if (cell == nil) {
    cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:kUserCellIdentifier];
  }
  NSDictionary *user = userList[indexPath.row];
  [cell setUserId:user[@"facebookId"]];
  [cell setName:user[@"name"]];
  [cell setPurpose:self.flight[@"users"][indexPath.row][@"purpose"]];
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

#pragma mark - Button Handler
- (void)addButtonPressed:(UIButton *)sender {
  FlightInspireViewController *flightInspireViewController = [[FlightInspireViewController alloc] init];
  flightInspireViewController.flight = self.flight;
  [self.navigationController pushViewController:flightInspireViewController animated:YES];
}

@end
