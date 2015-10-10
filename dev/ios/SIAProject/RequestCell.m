#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import "RequestCell.h"

#import "UIColor+Helper.h"
#import "ShadowUIView.h"
#import "UIView+Helper.h"
#import "UIFont+Helper.h"
#import "ShadowedUIButton.h"

@implementation RequestCell {
  ShadowUIView *cardView;
  UILabel *nameLabel;
  UILabel *amountLabel;
  UILabel *reasonLabel;
  UIButton *confirmButton;
}

static CGFloat const kConfirmButtonSize = 30.0;

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
  [self initializeAmountLabel];
  [self initializeNameLabel];
  [self initializeReasonLabel];
  [self initializeConfirmButton];
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
    make.left.mas_equalTo(self.mas_left).with.offset(20);
    make.right.mas_equalTo(self.mas_right).with.offset(-20);
    make.bottom.mas_equalTo(self.mas_bottom).with.offset(-20);
  }];
}

- (void)initializeAmountLabel {
  amountLabel = [[UILabel alloc] init];
  [cardView addSubview:amountLabel];
  
  [amountLabel setFont:[UIFont mediumPrimaryFontWithSize:25]];
  
  [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(cardView.mas_top);
    make.centerX.mas_equalTo(cardView.mas_centerX);
  }];
}

- (void)initializeNameLabel {
  nameLabel = [[UILabel alloc] init];
  [cardView addSubview:nameLabel];
  
  [nameLabel setFont:[UIFont mediumPrimaryFontWithSize:14]];
  [nameLabel setTextColor:[UIColor blackColor]];
  
  [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(cardView.mas_centerX);
    make.top.mas_equalTo(amountLabel.mas_bottom).with.offset(10);
  }];
}

- (void)initializeReasonLabel {
  reasonLabel = [[UILabel alloc] init];
  [cardView addSubview:reasonLabel];
  
  [reasonLabel setFont:[UIFont mediumPrimaryFontWithSize:14]];
  [reasonLabel setTextColor:[UIColor blackColor]];
  
  [reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(cardView.mas_centerX);
    make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(10);
  }];
}

- (void)initializeConfirmButton {
  confirmButton = [ShadowedUIButton buttonWithType:UIButtonTypeCustom];
  [self addSubview:confirmButton];
  [self bringSubviewToFront:confirmButton];
  
  // Configure appearance & behaviors
  [confirmButton setBackgroundColor:[UIColor appSecondaryColor]];
  [confirmButton setCornerRadius:kConfirmButtonSize / 2.0];
  [confirmButton configureForShadows];
  [confirmButton setShadowColor:[UIColor blackColor]];
  [confirmButton setShadowOpacity:0.4];
  [confirmButton setShadowOffset:CGSizeMake(0.0, 2.0)];
  [confirmButton setShadowRadius:3.0];
  [confirmButton addTarget:self
                 action:@selector(confirmButtonPressed:)
       forControlEvents:UIControlEventTouchUpInside];
  FAKIcon *addIcon = [FAKIonIcons cardIconWithSize:25];
  [addIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  [confirmButton setAttributedTitle:[addIcon attributedString] forState:UIControlStateNormal];
  
  // Configure layout
  [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(cardView.mas_right);
    make.centerY.mas_equalTo(cardView.mas_top);
    make.size.mas_equalTo(CGSizeMake(kConfirmButtonSize, kConfirmButtonSize));
  }];
}

- (void)setAmount:(NSString *)amount {
  _amount = amount;
  [amountLabel setText:[NSString stringWithFormat:@"$%@", _amount]];
}

- (void)setRequestName:(NSString *)requestName {
  _requestName = requestName;
  [nameLabel setText:[NSString stringWithFormat:@"requested from %@", _requestName]];
}

- (void)setReason:(NSString *)reason {
  _reason = reason;
  [reasonLabel setText:[NSString stringWithFormat:@"Reason: %@", _reason]];
}

- (void)confirmButtonPressed:(UIButton *)sender {
  [self.delegate acceptButtonPresed:self.index];
}


@end
