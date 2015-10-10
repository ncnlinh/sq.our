#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <PromiseKit/PromiseKit.h>
#import <Masonry/Masonry.h>

#import "LoginViewController.h"

#import "MainViewController.h"
#import "Constants.h"
#import "HttpClient.h"
#import "AppDelegate.h"
#import "UIColor+Helper.h"

@interface LoginViewController()<FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"App Logo"]];
  [self.view addSubview:logo];
  [logo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(@250);
    make.width.mas_equalTo(@250);
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(self.view.mas_top).with.offset(100);
  }];
  
  // Add FB Login Button
  FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
  loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
  loginButton.center = self.view.center;
  loginButton.delegate = self;
  [self.view addSubview:loginButton];
  
  [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(self.view.mas_centerX);
    make.top.mas_equalTo(logo.mas_bottom).with.offset(20);
  }];
}

#pragma mark - FBSDK Login Button Delegate
- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
               error:(NSError *)error {
  if ([FBSDKAccessToken currentAccessToken]) {
    NSString *url = [NSString stringWithFormat:@"%@/api/login", [Constants apiUrl]];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:[NSString stringWithFormat:@"/%@", [FBSDKAccessToken currentAccessToken].userID]
                                  parameters: @{}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
      [HttpClient postWithUrl:url body:@{@"facebookId": [FBSDKAccessToken currentAccessToken].userID, @"name": result[@"name"]}]
      .then(^{
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        MainViewController *mainViewController = [[MainViewController alloc] init];
        [appDelegate setRootViewController:mainViewController];
      })
      .catch(^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
      });
    }];
  }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // No need to handle
}


@end
