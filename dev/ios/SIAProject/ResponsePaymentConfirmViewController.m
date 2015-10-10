#import <Masonry/Masonry.h>
#import <PromiseKit/PromiseKit.h>

#import "ResponsePaymentConfirmViewController.h"

#import "UIColor+Helper.h"
#import "HttpClient.h"
#import "Constants.h"

@implementation ResponsePaymentConfirmViewController {
  UITextField *bankAccountNumberTextField;
  UIButton *confirmButton;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self configureNavigationBar];
  [self configureTextField];
  [self configureButton];
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
}

- (void)configureTextField {
  bankAccountNumberTextField = [[UITextField alloc] init];
  [self.view addSubview:bankAccountNumberTextField];
  
  bankAccountNumberTextField.placeholder = @"Card Number";
  
  [bankAccountNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.view.mas_top).with.offset(20);
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
    make.top.mas_equalTo(bankAccountNumberTextField.mas_bottom).with.offset(20);
  }];
}

- (void)confirmButtonPressed:(UIButton *)sender {
  NSString *requestUrl = [NSString stringWithFormat:@"%@/api/payment/pay", [Constants apiUrl]];
  [HttpClient postWithUrl:requestUrl body:@{
                                            @"_id": self.paymentRequest[@"_id"],
                                            @"sendingAccountNumber": bankAccountNumberTextField.text
                                            }]
  .then(^(NSDictionary *dict) {
    [self.navigationController popToRootViewControllerAnimated:TRUE];
  })
  .catch(^(NSError *error) {
    NSLog(@"%@", [error localizedDescription]);
  });
}

@end
