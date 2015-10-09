#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "ToLocationSelectViewController.h"
#import "LocationCell.h"
#import "HttpClient.h"
#import "Constants.h"

@interface ToLocationSelectViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ToLocationSelectViewController {
  UITableView *locationTableView;
  NSArray *locationList;
}

static NSString *const kLocationCellIdentifier = @"LocationCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  locationList = @[];
  [self configureTableView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getLocations];
}

- (void) getLocations {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/cities", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{}]
  .then(^(NSArray *cities) {
    locationList = cities;
    [locationTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureTableView {
  locationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  locationTableView.dataSource = self;
  locationTableView.delegate = self;
  [self.view addSubview:locationTableView];
  
  [locationTableView registerClass:[LocationCell class]
            forCellReuseIdentifier:kLocationCellIdentifier];
  
  [locationTableView setBackgroundColor:[UIColor whiteColor]];
  locationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
  [locationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
  return locationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationCellIdentifier];
  if (cell == nil) {
    cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:kLocationCellIdentifier];
  }
  [cell setTitle:locationList[indexPath.row][@"cityName"]];
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *selectedLocation = locationList[indexPath.row];
  [self.delegate toLocationSelected:selectedLocation];
  [self.navigationController popViewControllerAnimated:TRUE];
}

@end
