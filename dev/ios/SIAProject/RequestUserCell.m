#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "RequestUserCell.h"

#import "UIView+Helper.h"
#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "UIFont+Helper.h"

@interface RequestUserCell()

@end

@implementation RequestUserCell {
  UIImageView *userAvatar;
  UILabel *nameLabel;
  UILabel *purposeLabel;
}

static CGFloat const kProfilePictureSize = 60;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self initializeCell];
  }
  
  return self;
}

- (void)initializeCell {
  [self setBackgroundColor:[UIColor whiteColor]];
  [self initializeUserAvatar];
  [self initializeNameLabel];
}

- (void)initializeUserAvatar {
  userAvatar = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:userAvatar];
  
  userAvatar.contentMode = UIViewContentModeScaleAspectFill;
  [userAvatar setCornerRadius:kProfilePictureSize / 2.0];
  userAvatar.clipsToBounds = TRUE;
  
  [userAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.mas_left).with.offset(10);
    make.centerY.mas_equalTo(self.mas_centerY);
    make.size.mas_equalTo(CGSizeMake(kProfilePictureSize, kProfilePictureSize));
  }];
}

- (void)initializeNameLabel {
  nameLabel = [[UILabel alloc] init];
  [self addSubview:nameLabel];
  
  [nameLabel setFont:[UIFont mediumPrimaryFontWithSize:18]];
  [nameLabel setTextColor:[UIColor blackColor]];
  
  [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(userAvatar.mas_right).with.offset(10);
    make.centerY.mas_equalTo(self.mas_centerY);
  }];
}

#pragma mark - Property Accessors
- (void)setUserId:(NSString *)userId {
  _userId = userId;
  NSString *avatarUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=%td",
                         userId, (long) kProfilePictureSize];
  [userAvatar sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                placeholderImage:nil];
}

- (void)setName:(NSString *)name {
  _name = name;
  [nameLabel setText:_name];
}

@end
