#import <Masonry/Masonry.h>

#import "FlightSearchViewController.h"
#import "FromLocationSelectViewController.h"
#import "ToLocationSelectViewController.h"
#import "UIColor+Helper.h"
#import "DateModalViewController.h"
#import "FlightResultViewController.h"
#import "NSDate+Helper.h"

@interface FlightSearchViewController()<DateModalViewControllerDelegate,
ToLocationSelectViewControllerDelegate,
FromLocationSelectViewControllerDelegate>

@end

@implementation FlightSearchViewController {
  UIButton *flightDateButton;
  UIButton *fromLocationButton;
  UIButton *toLocationButton;
  UIButton *searchButton;
  
  NSDate *flightDate;
  NSString *fromLocation;
  NSString *toLocation;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  flightDate = [NSDate date];
  fromLocation = nil;
  toLocation = nil;
  
  [self configureNavigationBar];
  [self configureFlightDateButton];
  [self configureFromLocationButton];
  [self configureToLocationButton];
  [self configureSearchButton];
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"SEARCH FLIGHTS";
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

- (void)configureFlightDateButton {
  flightDateButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:flightDateButton];
  
  [flightDateButton setTitle:@"Flight Date" forState:UIControlStateNormal];
  [flightDateButton setBackgroundColor:[UIColor redColor]];
  [flightDateButton addTarget:self action:@selector(flightDateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [flightDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(self.view.mas_top).with.offset(20);
  }];
}

- (void)configureFromLocationButton {
  fromLocationButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:fromLocationButton];
  
  [fromLocationButton setTitle:@"Flight Start Location" forState:UIControlStateNormal];
  [fromLocationButton setBackgroundColor:[UIColor redColor]];
  [fromLocationButton addTarget:self
                         action:@selector(fromLocationButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
  
  [fromLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(flightDateButton.mas_bottom).with.offset(20);
  }];
}

- (void)configureToLocationButton {
  toLocationButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:toLocationButton];
  
  [toLocationButton setTitle:@"Flight To Location" forState:UIControlStateNormal];
  [toLocationButton setBackgroundColor:[UIColor redColor]];
  [toLocationButton addTarget:self
                       action:@selector(toLocationButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
  
  [toLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(fromLocationButton.mas_bottom).with.offset(20);
  }];
}

- (void)configureSearchButton {
  searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:searchButton];
  
  [searchButton setTitle:@"Search" forState:UIControlStateNormal];
  [searchButton setBackgroundColor:[UIColor redColor]];
  [searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(toLocationButton.mas_bottom).with.offset(20);
  }];
}

#pragma mark - Button Pressed
- (void)fromLocationButtonPressed:(UIButton *)sender {
  FromLocationSelectViewController *selectViewController = [[FromLocationSelectViewController alloc] init];
  selectViewController.delegate = self;
  [self.navigationController pushViewController:selectViewController animated:YES];
}

- (void)toLocationButtonPressed:(UIButton *)sender {
  ToLocationSelectViewController *selectViewController = [[ToLocationSelectViewController alloc] init];
  selectViewController.delegate = self;
  [self.navigationController pushViewController:selectViewController animated:YES];
}

- (void)flightDateButtonPressed:(UIButton *)sender {
  DateModalViewController *dateModalVc = [[DateModalViewController alloc] init];
  dateModalVc.delegate = self;
  dateModalVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  dateModalVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self presentViewController:dateModalVc animated:TRUE completion:nil];
}

- (void)searchButtonPressed:(UIButton *)sender {
  if (!fromLocation || !toLocation) {
    return;
  }
  FlightResultViewController *vc = [[FlightResultViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Date Modal View Controller
- (void)dateSelected:(NSDate *)date {
  flightDate = date;
  [flightDateButton setTitle:[date formattedDateWithFormat:@"dd/MM/YY"] forState:UIControlStateNormal];
}

- (void)emptySelected {
  // No handle
}

#pragma mark - To Location Selection View Controller Delegate
- (void)toLocationSelected:(NSDictionary *)location {
  toLocation = location[@"airportCode"];
  [toLocationButton setTitle:location[@"cityName"] forState:UIControlStateNormal];
}

#pragma mark - From Location Selection View Controller Delegate
- (void)fromLocationSelected:(NSDictionary *)location {
  fromLocation = location[@"airportCode"];
  [fromLocationButton setTitle:location[@"cityName"] forState:UIControlStateNormal];
}

@end
