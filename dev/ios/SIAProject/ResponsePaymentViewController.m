#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "ResponsePaymentViewController.h"

#import "UIColor+Helper.h"
#import "ResponsePaymentConfirmViewController.h"
#import "RequestCell.h"
#import "HttpClient.h"
#import "Constants.h"

@interface ResponsePaymentViewController()<UITableViewDataSource, UITableViewDelegate, RequestCellDelegate>

@end

@implementation ResponsePaymentViewController {
  NSArray *requestList;
  UITableView *requestTableView;
}

static NSString *const kRequestCellIdentifier = @"RequestCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureNavigationBar];
  [self initializeTableView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getRequests];
}

- (void)getRequests {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/payment/view", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                             @"facebookId": [FBSDKAccessToken currentAccessToken].userID
                                             }]
  .then(^(NSArray *requests) {
    requestList = requests;
    [requestTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
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
  
  [requestTableView registerClass:[RequestCell class]
           forCellReuseIdentifier:kRequestCellIdentifier];
  
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
  RequestCell *cell = [tableView dequeueReusableCellWithIdentifier:kRequestCellIdentifier];
  if (cell == nil) {
    cell = [[RequestCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:kRequestCellIdentifier];
  }
  NSDictionary *request = requestList[indexPath.row];
  [cell setAmount:request[@"amount"]];
  [cell setRequestName:request[@"requestUser"][@"name"]];
  [cell setRequestName:request[@"reason"]];
  [cell setIndex:(int) indexPath.row];
  [cell setDelegate:self];
  
  return cell;
}

- (void)acceptButtonPresed:(int)index {
  NSDictionary *request = requestList[index];
  ResponsePaymentConfirmViewController *vc = [[ResponsePaymentConfirmViewController alloc] init];
  [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 300;
}

@end
