#import <UIKit/UIKit.h>

@protocol DateModalViewControllerDelegate <NSObject>

- (void)dateSelected:(NSDate *)date;
- (void)emptySelected;

@end

@interface DateModalViewController : UIViewController

@property (strong, nonatomic) UIColor *primaryColor;
@property (strong, nonatomic) NSDate *dateSelected;
@property (weak, nonatomic) id<DateModalViewControllerDelegate> delegate;

@end
