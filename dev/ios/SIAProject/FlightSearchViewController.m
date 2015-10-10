#import <Masonry/Masonry.h>

#import "UIView+Helper.h"
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
  NSString *toLocationName;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  flightDate = [NSDate date];
  fromLocation = nil;
  toLocation = nil;
  toLocationName = nil;
  
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
  [flightDateButton setBackgroundColor:[UIColor clearColor]];
  [flightDateButton setTitleColor:[UIColor appPrimaryColor] forState:UIControlStateNormal];
  [flightDateButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [flightDateButton setBorderColor:[UIColor appPrimaryColor]];
  [flightDateButton setBorderWidth:1.0];
  [flightDateButton setCornerRadius:4.0];
  [flightDateButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];
  [flightDateButton addTarget:self action:@selector(flightDateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [flightDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(self.view.mas_top).with.offset(20);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
  }];
}

- (void)configureFromLocationButton {
  fromLocationButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:fromLocationButton];
  
  [fromLocationButton setTitle:@"Flight Start Location" forState:UIControlStateNormal];
  [fromLocationButton setBackgroundColor:[UIColor clearColor]];
  [fromLocationButton setTitleColor:[UIColor appPrimaryColor] forState:UIControlStateNormal];
  [fromLocationButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [fromLocationButton setBorderColor:[UIColor appPrimaryColor]];
  [fromLocationButton setBorderWidth:1.0];
  [fromLocationButton setCornerRadius:4.0];
  [fromLocationButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];
  [fromLocationButton addTarget:self
                         action:@selector(fromLocationButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
  
  [fromLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(flightDateButton.mas_bottom).with.offset(20);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
  }];
}

- (void)configureToLocationButton {
  toLocationButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:toLocationButton];
  
  [toLocationButton setTitle:@"Flight To Location" forState:UIControlStateNormal];
  [toLocationButton setBackgroundColor:[UIColor clearColor]];
  [toLocationButton setTitleColor:[UIColor appPrimaryColor] forState:UIControlStateNormal];
  [toLocationButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [toLocationButton setBorderColor:[UIColor appPrimaryColor]];
  [toLocationButton setBorderWidth:1.0];
  [toLocationButton setCornerRadius:4.0];
  [toLocationButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];

  [toLocationButton addTarget:self
                       action:@selector(toLocationButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
  
  [toLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(fromLocationButton.mas_bottom).with.offset(20);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
  }];
}

- (void)configureSearchButton {
  searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:searchButton];
  
  [searchButton setTitle:@"Search Flights" forState:UIControlStateNormal];
  [searchButton setBackgroundColor:[UIColor appPrimaryColor]];
  [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [searchButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [searchButton setCornerRadius:4.0];
  [searchButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];

  [searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(toLocationButton.mas_bottom).with.offset(20);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
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
  vc.date = flightDate;
  vc.startLocation = fromLocation;
  vc.endLocation = toLocation;
  vc.endLocationName = toLocationName;
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
  toLocationName = location[@"cityName"];
  [toLocationButton setTitle:location[@"cityName"] forState:UIControlStateNormal];
}

#pragma mark - From Location Selection View Controller Delegate
- (void)fromLocationSelected:(NSDictionary *)location {
  fromLocation = location[@"airportCode"];
  [fromLocationButton setTitle:location[@"cityName"] forState:UIControlStateNormal];
}

@end
