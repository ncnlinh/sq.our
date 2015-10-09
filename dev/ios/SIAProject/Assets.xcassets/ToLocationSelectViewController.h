#import <UIKit/UIKit.h>

@protocol ToLocationSelectViewControllerDelegate <NSObject>

- (void)toLocationSelected:(NSString *)location;

@end

@interface ToLocationSelectViewController : UIViewController

@property (weak, nonatomic) id<ToLocationSelectViewControllerDelegate> delegate;

@end
