#import <Masonry/Masonry.h>

#import "LocationCell.h"

#import "UIColor+Helper.h"
#import "NSDate+Helper.h"
#import "UIFont+Helper.h"

@implementation LocationCell {
  UILabel *titleLabel;
}

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
  [self intializeTitleLabel];
}

- (void)intializeTitleLabel {
  titleLabel = [[UILabel alloc] init];
  [self addSubview:titleLabel];
  
  [titleLabel setFont:[UIFont mediumSecondaryFontWithSize:18]];
  [titleLabel setTextColor:[UIColor blackColor]];
  
  [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.mas_left).with.offset(15);
    make.centerY.mas_equalTo(self.mas_centerY);
  }];
}

#pragma mark - Property Accessors
- (void)setTitle:(NSString *)title {
  _title = title;
  [titleLabel setText:_title];
}

@end
