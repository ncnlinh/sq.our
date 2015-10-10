#import <UIKit/UIKit.h>

@protocol RequestCellDelegate <NSObject>

- (void)acceptButtonPresed:(int)index;

@end

@interface RequestCell : UITableViewCell

@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *requestName;
@property (strong, nonatomic) NSString *reason;
@property (nonatomic) int index;

@property (weak, nonatomic) id<RequestCellDelegate> delegate;

@end
