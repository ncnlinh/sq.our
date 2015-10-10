#import <Masonry/Masonry.h>

#import "RequestPaymentViewController.h"

#import "RequestPaymentConfirmViewController.h"
#import "UIColor+Helper.h"
#import "RequestUserCell.h"
#import "HttpClient.h"
#import "Constants.h"

@interface RequestPaymentViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RequestPaymentViewController {
  NSArray *requestList;
  UITableView *requestTableView;
}

static NSString *const kUserCellIdentifier = @"UserCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  requestList = @[];
  [self configureNavigationBar];
  [self initializeTableView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"PAYMENT";
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
  requestTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:requestTableView];
  requestTableView.dataSource = self;
  requestTableView.delegate = self;
  
  [requestTableView registerClass:[RequestUserCell class]
        forCellReuseIdentifier:kUserCellIdentifier];
  
  [requestTableView setBackgroundColor:[UIColor whiteColor]];
  requestTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [requestTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_left);
    make.top.mas_equalTo(self.view.mas_top);
    make.size.mas_equalTo(self.view);
  }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return requestList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RequestUserCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCellIdentifier];
  if (cell == nil) {
    cell = [[RequestUserCell alloc] initWithStyle:UITableViewCellStyleDefault
                           reuseIdentifier:kUserCellIdentifier];
  }
  NSDictionary *user = requestList[indexPath.row];
  [cell setUserId:user[@"facebookId"]];
  [cell setName:user[@"name"]];
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
  NSDictionary *user = requestList[indexPath.row];
  RequestPaymentConfirmViewController *vc = [[RequestPaymentConfirmViewController alloc] init];
  vc.requestedUser = user;
  [self.navigationController pushViewController:vc animated:TRUE];
}

@end
