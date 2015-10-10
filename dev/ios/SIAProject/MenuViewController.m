#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "MenuViewController.h"

#import "SidebarMenuItemCell.h"
#import "UIColor+Helper.h"
#import "UIFont+Helper.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"
#import "Constants.h"

@interface MenuViewController()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIView *profileContainerView;
@property (strong, nonatomic) UITableView *mainMenuTableView;
@property (strong, nonatomic) UITableView *otherMenuTableView;
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@end

static CGFloat const kProfilePictureSize = 130;
static CGFloat const kCellHeight = 60;

static NSInteger const kMainMenuCellCount = 2;
static NSInteger const kFlightCellIndex = 0;
static NSInteger const kPaymentCellIndex = 1;

static NSInteger const kOtherMenuCellCount = 1;
static NSInteger const kLogOutCellIndex = 0;

static NSString *const kSidebarMenuItemCellIdentifier = @"SidebarMenuItemCellIdentifier";

@implementation MenuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view setBackgroundColor:[UIColor whiteGrayColor]];
  [self.view setClipsToBounds:FALSE];
  [self.view configureForShadows];
  [self.view setShadowColor:[UIColor blackColor]];
  [self.view setShadowOpacity:0.2];
  [self.view setShadowOffset:CGSizeMake(2.0, 0.0)];
  [self.view setShadowRadius:2.0];
  
  [self configureProfile];
  [self configureOtherMenu];
  [self configureMainMenu];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self.view setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                                       cornerRadius:self.view.layer.cornerRadius]
                            CGPath]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (self.nameLabel.text == nil || [self.nameLabel.text trim].length == 0) {
    self.nameLabel.text = [FBSDKProfile currentProfile].name;
    NSInteger width = self.view.frame.size.width;
    NSString *avatarUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=%td",
                             [FBSDKProfile currentProfile].userID, width];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                                placeholderImage:nil];
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                         placeholderImage:nil];
  }
}


- (void)configureProfile {
  NSInteger width = self.view.frame.size.width;
  NSString *avatarUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=%td",
                         [FBSDKProfile currentProfile].userID, width];
  self.profileContainerView = [[UIView alloc] init];
  [self.view addSubview:self.profileContainerView];
  
  [self.profileContainerView setBackgroundColor:[UIColor appPrimaryColor]];
  [self.profileContainerView setClipsToBounds:TRUE];
  
  [self.profileContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.view.mas_top);
    make.left.mas_equalTo(self.view.mas_left);
    make.width.mas_equalTo(self.view.mas_width);
    make.height.mas_equalTo(200);
  }];
  
  self.backgroundImageView = [[UIImageView alloc] init];
  [self.profileContainerView addSubview:self.backgroundImageView];
  
  self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                              placeholderImage:nil];
  
  [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.profileContainerView);
  }];
  
  UIView *overlayView = [[UIView alloc] init];
  [self.profileContainerView addSubview:overlayView];
  
  overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
  
  [overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.profileContainerView);
  }];
  
  _profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self.profileContainerView addSubview:_profileImageView];
  
  _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
  [_profileImageView setCornerRadius:kProfilePictureSize / 2.0];
  _profileImageView.clipsToBounds = TRUE;
  [_profileImageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl]
                       placeholderImage:nil];
  
  [_profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.profileContainerView.mas_centerX);
    make.top.mas_equalTo(self.profileContainerView.mas_top).with.offset(10);
    make.size.mas_equalTo(CGSizeMake(kProfilePictureSize, kProfilePictureSize));
  }];
  
  self.nameLabel = [[UILabel alloc] init];
  [self.profileContainerView addSubview:self.nameLabel];
  
  [self.nameLabel setFont:[UIFont mediumSecondaryFontWithSize:18.0]];
  [self.nameLabel setTextColor:[UIColor whiteColor]];
  [self.nameLabel setText:[FBSDKProfile currentProfile].name];
  [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
  
  [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(_profileImageView.mas_bottom).with.offset(10);
    make.centerX.mas_equalTo(self.profileContainerView.mas_centerX);
    make.width.mas_equalTo(self.profileContainerView.mas_width).with.offset(-10);
  }];
}

- (void)configureOtherMenu {
  self.otherMenuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:self.otherMenuTableView];
  self.otherMenuTableView.delegate = self;
  self.otherMenuTableView.dataSource = self;
  
  [self.otherMenuTableView registerClass:[SidebarMenuItemCell class]
                  forCellReuseIdentifier:kSidebarMenuItemCellIdentifier];
  
  [self.otherMenuTableView setBounces:FALSE];
  [self.otherMenuTableView setBackgroundColor:[UIColor whiteGrayColor]];
  [self.otherMenuTableView setAllowsSelection:TRUE];
  [self.otherMenuTableView setAllowsMultipleSelection:FALSE];
  
  [self.otherMenuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.mas_equalTo(self.view.mas_bottom);
    make.left.mas_equalTo(self.view.mas_left);
    make.width.mas_equalTo(self.view.mas_width);
    CGFloat tableHeight = kCellHeight * kOtherMenuCellCount;
    make.height.mas_equalTo(tableHeight);
  }];
}

- (void)configureMainMenu {
  self.mainMenuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  [self.view addSubview:self.mainMenuTableView];
  self.mainMenuTableView.delegate = self;
  self.mainMenuTableView.dataSource = self;
  
  [self.mainMenuTableView registerClass:[SidebarMenuItemCell class]
                 forCellReuseIdentifier:kSidebarMenuItemCellIdentifier];
  
  self.mainMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.mainMenuTableView setBackgroundColor:[UIColor whiteGrayColor]];
  [self.mainMenuTableView setBounces:FALSE];
  
  [self.mainMenuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.profileContainerView.mas_bottom);
    make.left.mas_equalTo(self.view.mas_left);
    make.width.mas_equalTo(self.view.mas_width);
    make.bottom.mas_equalTo(self.otherMenuTableView.mas_top);
  }];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView == self.mainMenuTableView) {
    return kMainMenuCellCount;
  } else if (tableView == self.otherMenuTableView) {
    return kOtherMenuCellCount;
  }
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSInteger row = indexPath.row;
  SidebarMenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:
                               kSidebarMenuItemCellIdentifier];
  if (cell == nil) {
    cell = [[SidebarMenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kSidebarMenuItemCellIdentifier];
  }
  
  if (tableView == self.mainMenuTableView) {
    if (row == kFlightCellIndex) {
      [cell setMenuItemType:kSideBarMenuItemFlights];
    } else if (row == kPaymentCellIndex) {
      [cell setMenuItemType:kSideBarMenuItemPayment];
    }
  } else if (tableView == self.otherMenuTableView) {
    if (row ==  kLogOutCellIndex) {
      [cell setMenuItemType:kSideBarMenuItemLogOut];
    }
  }
  
  return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
  if (tableView == self.mainMenuTableView) {
    [self.delegate mainMenuItemSelected:indexPath.row];
  } else if (tableView == self.otherMenuTableView) {
    [self.delegate otherMenuItemSelected:indexPath.row];
  }
}

@end
