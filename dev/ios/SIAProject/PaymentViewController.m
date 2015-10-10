#import <FontAwesomeKit/FontAwesomeKit.h>
#import <Masonry/Masonry.h>

#import "PaymentViewController.h"

#import "UIView+Helper.h"
#import "UIViewController+SideBarViewController.h"
#import "UIColor+Helper.h"
#import "RequestPaymentViewController.h"
#import "ResponsePaymentViewController.h"

@implementation PaymentViewController {
  UIButton *requestButton;
  UIButton *responseButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureGesture];
  [self configureNavigationBar];
  [self configureButtons];
}

- (void)configureGesture {
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(panGestureRecognized:)];
  [self.view addGestureRecognizer:panGesture];
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"PAYMENT";
  self.navigationController.navigationBar.barTintColor = [UIColor appPrimaryColor];
  self.navigationController.navigationBar.translucent = FALSE;
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.extendedLayoutIncludesOpaqueBars = FALSE;
  self.automaticallyAdjustsScrollViewInsets = FALSE;
  
  // Configure back button for subsequent views
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:nil];
  
  // Configure menu button on the left of nav bar
  UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                 target:nil action:nil];
  leftSpacer.width = -10;
  
  FAKIcon *menuIcon = [FAKIonIcons naviconIconWithSize:30];
  [menuIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
  UIImage *menuIconImage = [menuIcon imageWithSize:CGSizeMake(30, 30)];
  UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:menuIconImage
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(menuButtonPressed:)];
  [self.navigationItem setLeftBarButtonItems:@[leftSpacer,menuButton]];
}

- (void)configureButtons {
  requestButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:requestButton];
  
  [requestButton setTitle:@"Payment Request" forState:UIControlStateNormal];
  [requestButton setBackgroundColor:[UIColor appPrimaryColor]];
  [requestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [requestButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [requestButton setCornerRadius:4.0];
  [requestButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];

  [requestButton addTarget:self action:@selector(requestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [requestButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.bottom.mas_equalTo(self.view.mas_centerY).with.offset(-10);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
  }];
  
  responseButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:responseButton];
  
  [responseButton setTitle:@"Response Request" forState:UIControlStateNormal];
  [responseButton setBackgroundColor:[UIColor appPrimaryColor]];
  [responseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [responseButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:1.0]];
  [responseButton setCornerRadius:4.0];
  [responseButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 10, 5)];

  [responseButton addTarget:self action:@selector(responseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [responseButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(self.view.mas_centerY).with.offset(10);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-50);
  }];
}

- (void)requestButtonPressed:(UIButton *)sender {
  RequestPaymentViewController *vc = [[RequestPaymentViewController alloc] init];
  [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)responseButtonPressed:(UIButton *)sender {
  ResponsePaymentViewController *vc = [[ResponsePaymentViewController alloc] init];
  [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark - Gesture Recognizer
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
  SideBarViewController *sideBarVc = self.sideBarViewController;
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [sideBarVc.view endEditing:YES];
  
  // Present the view controller
  [sideBarVc panGestureRecognized:sender];
}

#pragma mark - Button Handler
- (void)menuButtonPressed:(UIButton *)sender {
  SideBarViewController *sideBarVc = self.sideBarViewController;
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [sideBarVc.view endEditing:YES];
  
  // Present the view controller
  [sideBarVc presentMenuViewController];
}


@end
