#import <UIKit/UIKit.h>

@protocol FromLocationSelectViewControllerDelegate <NSObject>

- (void)fromLocationSelected:(NSString *)location;

@end

@interface FromLocationSelectViewController : UIViewController

@property (weak, nonatomic) id<FromLocationSelectViewControllerDelegate> delegate;

@end
