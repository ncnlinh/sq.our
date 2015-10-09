#import <UIKit/UIKit.h>

@protocol FlightSummaryCellDelegate <NSObject>

- (void)chatButtonPressed:(int)index;

@end

@interface FlightSummaryCell : UITableViewCell

@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *snippet;
@property (nonatomic) int index;
@property (nonatomic) BOOL isUser;

@property (weak, nonatomic) id<FlightSummaryCellDelegate> delegate;

@end
