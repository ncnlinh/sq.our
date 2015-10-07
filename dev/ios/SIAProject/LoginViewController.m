#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "LoginViewController.h"
#import "InspiredViewController.h"

#import "AppDelegate.h"
#import "UIColor+Helper.h"

@interface LoginViewController()<FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  // Add FB Login Button
  FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
  loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
  loginButton.center = self.view.center;
  loginButton.delegate = self;
  [self.view addSubview:loginButton];
}

#pragma mark - FBSDK Login Button Delegate
- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
               error:(NSError *)error {
  if (result.token != NULL) {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    InspiredViewController *mainViewController = [[InspiredViewController alloc] init];
    [appDelegate setRootViewController:mainViewController];
  }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    // No need to handle
}


@end
