#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import "FlightSummaryCell.h"

#import "ShadowUIView.h"
#import "UIView+Helper.h"
#import "UIFont+Helper.h"
#import "UIColor+Helper.h"
#import "ShadowedUIButton.h"

@implementation FlightSummaryCell {
  ShadowUIView *cardView;
  UIImageView *imageView;
  UILabel *nameLabel;
  UILabel *addressLabel;
  UILabel *descriptionLabel;
  UIButton *chatButton;
}

static CGFloat const kChatButtonSize = 45.0;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self initializeCell];
  }
  
  return self;
}

- (void)initializeCell {
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
  [self setBackgroundColor:[UIColor whiteColor]];
  [self initializeCardView];
  [self initializeUserAvatar];
  [self initializeNameLabel];
  [self initializeAddressLabel];
  [self initializeDescriptionLabel];
  [self initializeChatButton];
}

- (void)initializeCardView {
  cardView = [[ShadowUIView alloc] init];
  [self addSubview:cardView];
  
  cardView.backgroundColor = [UIColor whiteColor];
  [cardView configureForShadows];
  [cardView setShadowColor:[UIColor blackColor]];
  [cardView setShadowOpacity:0.33];
  [cardView setShadowOffset:CGSizeMake(0, 1.5)];
  [cardView setShadowRadius:4.0];
  
  [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.mas_top).with.offset(20);
    make.left.mas_equalTo(self.mas_left).with.offset(30);
    make.right.mas_equalTo(self.mas_right).with.offset(-30);
    make.bottom.mas_equalTo(self.mas_bottom).with.offset(-20);
  }];
}

- (void)initializeUserAvatar {
  imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [cardView addSubview:imageView];
  
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.clipsToBounds = TRUE;
  
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(cardView.mas_left);
    make.top.mas_equalTo(cardView.mas_top);
    make.right.mas_equalTo(cardView.mas_right);
    make.height.mas_equalTo(@250);
  }];
}

- (void)initializeNameLabel {
  nameLabel = [[UILabel alloc] init];
  [cardView addSubview:nameLabel];
  
  [nameLabel setFont:[UIFont mediumPrimaryFontWithSize:18]];
  [nameLabel setTextColor:[UIColor blackColor]];
  
  [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(cardView.mas_left).with.offset(15);
    make.right.mas_equalTo(cardView.mas_right).with.offset(-10);
    make.top.mas_equalTo(imageView.mas_bottom).with.offset(10);
  }];
}

- (void)initializeAddressLabel {
  addressLabel = [[UILabel alloc] init];
  [cardView addSubview:addressLabel];
  
  [addressLabel setFont:[UIFont mediumPrimaryFontWithSize:18]];
  [addressLabel setTextColor:[UIColor blackColor]];
  
  [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(cardView.mas_left).with.offset(15);
    make.right.mas_equalTo(cardView.mas_right).with.offset(-10);
    make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(10);
  }];
}

- (void)initializeDescriptionLabel {
  descriptionLabel = [[UILabel alloc] init];
  [cardView addSubview:descriptionLabel];
  
  [descriptionLabel setFont:[UIFont mediumPrimaryFontWithSize:18]];
  [descriptionLabel setTextColor:[UIColor blackColor]];
  
  [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(cardView.mas_left).with.offset(15);
    make.right.mas_equalTo(cardView.mas_right).with.offset(-10);
    make.top.mas_equalTo(addressLabel.mas_bottom).with.offset(10);
  }];
}

- (void)initializeChatButton {
  chatButton = [ShadowedUIButton buttonWithType:UIButtonTypeCustom];
  [self addSubview:chatButton];
  [self bringSubviewToFront:chatButton];
  
  // Configure appearance & behaviors
  [chatButton setBackgroundColor:[UIColor appSecondaryColor]];
  [chatButton setCornerRadius:kChatButtonSize / 2.0];
  [chatButton configureForShadows];
  [chatButton setShadowColor:[UIColor blackColor]];
  [chatButton setShadowOpacity:0.4];
  [chatButton setShadowOffset:CGSizeMake(0.0, 2.0)];
  [chatButton setShadowRadius:3.0];
  [chatButton addTarget:self
                          action:@selector(chatButtonPressed:)
                 forControlEvents:UIControlEventTouchUpInside];
  FAKIcon *addIcon = [FAKIonIcons chatboxesIconWithSize:28];
  [addIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  [chatButton setAttributedTitle:[addIcon attributedString] forState:UIControlStateNormal];
  
  // Configure layout
  [chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(cardView.mas_right);
    make.centerY.mas_equalTo(cardView.mas_top);
    make.size.mas_equalTo(CGSizeMake(kChatButtonSize, kChatButtonSize));
  }];

}

- (void)setImageUrl:(NSString *)imageUrl {
  _imageUrl = imageUrl;
  [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                placeholderImage:nil];
}

- (void)setName:(NSString *)name {
  _name = name;
  [nameLabel setText:_name];
}

- (void)setAddress:(NSString *)address {
  _address = address;
  [addressLabel setText:_address];
}

- (void)setSnippet:(NSString *)snippet {
  _snippet = snippet;
  [descriptionLabel setText:_snippet];
}

- (void)setIsUser:(BOOL)isUser {
  _isUser = isUser;
  [chatButton setHidden:!isUser];
}

- (void)chatButtonPressed:(UIButton *)button {
  [self.delegate chatButtonPressed:self.index];
}

@end
