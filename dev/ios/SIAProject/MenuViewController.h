#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

- (void)mainMenuItemSelected:(NSInteger)row;
- (void)otherMenuItemSelected:(NSInteger)row;

@end

@interface MenuViewController : UIViewController

@property (weak, nonatomic) id<MenuViewControllerDelegate> delegate;

@end
