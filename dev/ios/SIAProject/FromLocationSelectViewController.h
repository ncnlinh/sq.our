#import <UIKit/UIKit.h>

@protocol FromLocationSelectViewControllerDelegate <NSObject>

- (void)fromLocationSelected:(NSDictionary *)location;

@end

@interface FromLocationSelectViewController : UIViewController

@property (weak, nonatomic) id<FromLocationSelectViewControllerDelegate> delegate;

@end
