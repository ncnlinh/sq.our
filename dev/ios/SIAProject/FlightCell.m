#import <Masonry/Masonry.h>

#import "FlightCell.h"

#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "UIFont+Helper.h"

@implementation FlightCell {
  UILabel *flightNumberLabel;
  UILabel *startDateLabel;
  UILabel *startLocationLabel;
  UILabel *endLocationLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self initializeCell];
  }
  
  return self;
}

- (void)initializeCell {
  [self setBackgroundColor:[UIColor whiteColor]];
  [self initializeFlightNumberLabel];
  [self initializeStartDateLabel];
  [self initializeStartLocationLabel];
  [self initializeEndLocationLabel];
}

- (void)initializeFlightNumberLabel {
  flightNumberLabel = [[UILabel alloc] init];
  [self addSubview:flightNumberLabel];
  
  [flightNumberLabel setFont:[UIFont mediumSecondaryFontWithSize:18]];
  [flightNumberLabel setTextColor:[UIColor blackColor]];
  
  [flightNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.mas_left).with.offset(15);
    make.centerY.mas_equalTo(self.mas_centerY);
  }];
}

- (void)initializeStartDateLabel {
  startDateLabel = [[UILabel alloc] init];
  [self addSubview:startDateLabel];
  
  [startDateLabel setFont:[UIFont mediumPrimaryFontWithSize:14]];
  [startDateLabel setTextColor:[UIColor darkGrayColor]];
  
  [startDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(flightNumberLabel.mas_right).with.offset(10);
    make.top.mas_equalTo(self.mas_top).with.offset(10);
  }];
}

- (void)initializeStartLocationLabel {
  startLocationLabel = [[UILabel alloc] init];
  [self addSubview:startLocationLabel];
  
  [startLocationLabel setFont:[UIFont mediumPrimaryFontWithSize:14]];
  [startLocationLabel setTextColor:[UIColor darkGrayColor]];
  
  [startLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.mas_right).with.offset(-10);
    make.bottom.mas_equalTo(self.mas_centerY).with.offset(-10);
  }];
}

- (void)initializeEndLocationLabel {
  endLocationLabel = [[UILabel alloc] init];
  [self addSubview:endLocationLabel];
  
  [endLocationLabel setFont:[UIFont mediumPrimaryFontWithSize:14]];
  [endLocationLabel setTextColor:[UIColor darkGrayColor]];
  
  [endLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(self.mas_right).with.offset(-10);
    make.top.mas_equalTo(self.mas_centerY).with.offset(10);
  }];
}

#pragma mark - Property Accessors
- (void)setFlightNumber:(NSString *)flightNumber {
  _flightNumber = flightNumber;
  [flightNumberLabel setText:flightNumber];
}

- (void)setStartDate:(NSDate *)startDate {
  _startDate = startDate;
  [startDateLabel setText:[startDate formattedDateWithFormat:@"dd/MM/YYYY"]];
}

- (void)setStartDateString:(NSString *)startDate {
  [startDateLabel setText:startDate];
}

- (void)setStartLocation:(NSString *)startLocation {
  _startLocation = startLocation;
  [startLocationLabel setText:startLocation];
}

- (void)setEndLocation:(NSString *)endLocation {
  _endLocation = endLocation;
  [endLocationLabel setText:endLocation];
}

@end
