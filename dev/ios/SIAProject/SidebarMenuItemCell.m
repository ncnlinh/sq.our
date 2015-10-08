#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>

#import "SidebarMenuItemCell.h"

#import "UIColor+Helper.h"
#import "UIFont+Helper.h"

@interface SidebarMenuItemCell()

@property (strong, nonatomic) UILabel *iconLabel;
@property (strong, nonatomic) UILabel *titleLabel;

@end

static NSInteger const kIconLabelIconSize = 24;
static NSInteger const kTitleLabelIconSize = 16;

@implementation SidebarMenuItemCell

#pragma mark - Initializers
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor whiteGrayColor]];
    [self initializeCell];
  }
  
  return self;
}

- (void)initializeCell {
  [self initializeIconLabel];
  [self initializeTitleLabel];
}

- (void)initializeIconLabel {
  self.iconLabel = [[UILabel alloc] init];
  [self addSubview:self.iconLabel];
  
  [self.iconLabel setTextAlignment:NSTextAlignmentCenter];
  
  [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.mas_centerY);
    make.left.mas_equalTo(self.mas_left);
    make.width.mas_equalTo(kIconLabelIconSize + 10);
  }];
}

- (void)initializeTitleLabel {
  self.titleLabel = [[UILabel alloc] init];
  [self addSubview:self.titleLabel];
  
  [self.titleLabel setTextColor:[UIColor grayColor]];
  [self.titleLabel setFont:[UIFont mediumPrimaryFontWithSize:kTitleLabelIconSize]];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.mas_centerY);
    make.left.mas_equalTo(self.iconLabel.mas_right).with.offset(10);
  }];
}

#pragma mark - Property Accessors
- (void)setMenuItemType:(SideBarMenuItemType)menuItemType {
  _menuItemType = menuItemType;
  NSString *title;
  FAKIcon *icon;
  switch (_menuItemType) {
    case kSideBarMenuItemFlights:
      title = @"Flights";
      icon = [FAKFontAwesome usersIconWithSize:kIconLabelIconSize];
      break;
    case kSideBarMenuItemChats:
      title = @"Chats";
      icon = [FAKFontAwesome calendarOIconWithSize:kIconLabelIconSize];
      break;
    case kSideBarMenuItemPayment:
      title = @"Payment";
      icon = [FAKFontAwesome tasksIconWithSize:kIconLabelIconSize];
      break;
    case kSideBarMenuItemLogOut:
      icon = [FAKIonIcons loopIconWithSize:kIconLabelIconSize];
      title = @"Log Out";
      break;
    default:
      NSAssert(false, @"Invalid menu item type");
      break;
  }
  [self.titleLabel setText:[title uppercaseString]];
  [icon addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor]];
  [self.iconLabel setAttributedText:[icon attributedString]];
}

@end
