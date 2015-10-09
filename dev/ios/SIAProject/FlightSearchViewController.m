#import <Masonry/Masonry.h>

#import "FlightSearchViewController.h"
#import "FromLocationSelectViewController.h"
#import "ToLocationSelectViewController.h"
#import "DateModalViewController.h"

@interface FlightSearchViewController()<DateModalViewControllerDelegate>

@end

@implementation FlightSearchViewController {
  UIButton *flightDateButton;
  UIButton *fromLocationButton;
  UIButton *toLocationButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  [self configureFlightDateButton];
  [self configureFromLocationButton];
  [self configureToLocationButton];
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

#pragma mark - Button Pressed
- (void)fromLocationButtonPressed:(UIButton *)sender {
  FromLocationSelectViewController *selectViewController = [[FromLocationSelectViewController alloc] init];
  [self.navigationController pushViewController:selectViewController animated:YES];
}

- (void)toLocationButtonPressed:(UIButton *)sender {
  ToLocationSelectViewController *selectViewController = [[ToLocationSelectViewController alloc] init];
  [self.navigationController pushViewController:selectViewController animated:YES];
}

- (void)flightDateButtonPressed:(UIButton *)sender {
  DateModalViewController *dateModalVc = [[DateModalViewController alloc] init];
  dateModalVc.delegate = self;
  dateModalVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  dateModalVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self presentViewController:dateModalVc animated:TRUE completion:nil];
}

#pragma mark - Date Modal View Controller
- (void)dateSelected:(NSDate *)date {
  
}

- (void)emptySelected {
  
}

@end
