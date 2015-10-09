#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "FromLocationSelectViewController.h"

#import "Constants.h"
#import "LocationCell.h"
#import "HttpClient.h"

@interface FromLocationSelectViewController() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FromLocationSelectViewController {
  UITableView *locationTableView;
  NSArray *locationList;
  NSDictionary *locationMap;
  NSArray *initialArr;
}

static NSString *const kLocationCellIdentifier = @"LocationCellIdentifier";

- (void)viewDidLoad {
  [super viewDidLoad];
  locationList = @[];
  locationMap = @{};
  initialArr = @[];
  [self configureTableView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self getLocations];
}

- (void) getLocations {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/cities", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{}]
  .then(^(NSDictionary *res) {
    locationList = res[@"airports"];
    locationMap = res[@"airportMap"];
    initialArr = res[@"initialArr"];
    [locationTableView reloadData];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

- (void)configureTableView {
  locationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
  return initialArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return ((NSArray *)locationMap[[(NSString *)initialArr[section] lowercaseString]]).count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return initialArr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationCellIdentifier];
  if (cell == nil) {
    cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:kLocationCellIdentifier];
  }
  NSDictionary *row = locationMap[[(NSString *)initialArr[indexPath.section] lowercaseString]][indexPath.row];
  [cell setTitle:[NSString stringWithFormat:@"%@ - %@", (NSString *)row[@"cityName"], (NSString *)row[@"airportName"]]];
  
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return initialArr[section];
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *row = locationMap[[(NSString *)initialArr[indexPath.section] lowercaseString]][indexPath.row];
  [self.delegate fromLocationSelected:row];
  [self.navigationController popViewControllerAnimated:TRUE];
}


@end
