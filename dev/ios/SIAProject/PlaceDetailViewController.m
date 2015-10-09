#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "PlaceDetailViewController.h"

@implementation PlaceDetailViewController {
  UIImageView *profileImage;
  UILabel *titleLabel;
  UILabel *addressLabel;
  UILabel *descriptionLabel;
  UITableView *chatListView;
  UIButton *leftTab;
  UIButton *rightTab;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configurePicture];
  [self configureTitle];
  [self configureTabBar];
  
}

- (void)configurePicture {
  profileImage = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:profileImage];
  
  profileImage.contentMode = UIViewContentModeScaleAspectFill;
  profileImage.clipsToBounds = TRUE;
  [profileImage sd_setImageWithURL:
   [NSURL URLWithString:@"http://www.jimcoda.com/data/photos/887_1_04p0198_golden_gate_bridge_fort_baker.jpg"]
                       placeholderImage:nil];
  
  [profileImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_left);
    make.top.mas_equalTo(self.view.mas_top);
    make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, self.view.frame.size.width));
  }];
}

- (void)configureTitle {
  titleLabel = [[UILabel alloc] init];
  [self.view addSubview:titleLabel];
  
  [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(profileImage.mas_bottom).with.offset(20);
  }];
}

- (void)configureTabBar {
  leftTab = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:leftTab];
  
  [leftTab setTitle:@"DETAILS" forState:UIControlStateNormal];
  [leftTab addTarget:self 
              action:@selector(leftTabButtonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
  
  [leftTab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_left);
    make.right.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(20);
  }];
  
  rightTab = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:rightTab];
  
  [rightTab setTitle:@"GROUPS" forState:UIControlStateNormal];
  [rightTab addTarget:self
               action:@selector(rightTabButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
  [rightTab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.view.mas_centerX);
    make.right.mas_equalTo(self.view.mas_right);
    make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(20);
  }];
}

- (void)configureScrollView {
  
}

- (void)configureChatList {
  
}

#pragma mark - Tab Bar Button Pressed
- (void)leftTabButtonPressed:(UIButton *)leftTab {
  
}

- (void)rightTabButtonPressed:(UIButton *)rightTab {
  
}

@end
