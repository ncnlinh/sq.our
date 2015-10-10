#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "RequestPaymentConfirmViewController.h"

#import "UIColor+Helper.h"
#import "HttpClient.h"
#import "Constants.h"

@implementation RequestPaymentConfirmViewController {
  UITextField *bankAccountNumberTextField;
  UITextField *amountTextField;
  UITextField *reasoNTextField;
  UIButton *confirmButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureNavigationBar];
  [self configureTextFields];
  [self configureButton];
}

- (void)configureNavigationBar {
  self.navigationItem.title = @"REQUEST CONFIRMATION";
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
}


- (void)configureTextFields {
  bankAccountNumberTextField = [[UITextField alloc] init];
  [self.view addSubview:bankAccountNumberTextField];
  
  bankAccountNumberTextField.placeholder = @"Card Number";
  
  [bankAccountNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.view.mas_top).with.offset(20);
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-40);
  }];
  
  amountTextField = [[UITextField alloc] init];
  [self.view addSubview:amountTextField];
  
  amountTextField.placeholder = @"Amount";
  
  [amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(bankAccountNumberTextField.mas_bottom).with.offset(20);
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-40);
  }];
  
  reasoNTextField = [[UITextField alloc] init];
  [self.view addSubview:reasoNTextField];
  
  reasoNTextField.placeholder = @"Reason";
  
  [reasoNTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(amountTextField.mas_bottom).with.offset(20);
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.width.mas_equalTo(self.view.mas_width).with.offset(-40);
  }];
}

- (void)configureButton {
  confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.view addSubview:confirmButton];
  
  [confirmButton setTitle:@"SEND REQUEST" forState:UIControlStateNormal];
  [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(reasoNTextField.mas_bottom).with.offset(20);
  }];
}

- (void)confirmButtonPressed:(UIButton *)sendButton {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/payment/ask", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"requestUser": [FBSDKAccessToken currentAccessToken].userID,
                                            @"receivingAccountNumber": bankAccountNumberTextField.text,
                                            @"receivedUser": self.requestedUser[@"facebookId"],
                                            @"amount": amountTextField.text,
                                            @"reason": reasoNTextField.text
                                            }]
  .then(^{
    [self.navigationController popToRootViewControllerAnimated:TRUE];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

@end
