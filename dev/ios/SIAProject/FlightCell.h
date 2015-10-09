#import <UIKit/UIKit.h>

@interface FlightCell : UITableViewCell

#pragma mark - Appearance Properties
@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSString *startLocation;
@property (strong, nonatomic) NSString *endLocation;

@end
