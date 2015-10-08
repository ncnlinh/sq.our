#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SideBarMenuItemType) {
  kSideBarMenuItemFlights,
  kSideBarMenuItemChats,
  kSideBarMenuItemPayment,
  kSideBarMenuItemLogOut
};

@interface SidebarMenuItemCell : UITableViewCell

@property (nonatomic) SideBarMenuItemType menuItemType;

@end
