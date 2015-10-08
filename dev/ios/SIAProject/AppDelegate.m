#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Setup FB SDK
  [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];
  
  // Initialize window
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  LoginViewController *loginViewController = [[LoginViewController alloc] init];
  [self.window setRootViewController:loginViewController];  [self.window makeKeyAndVisible];
  
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  // Setup FB SDK
  return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                        openURL:url
                                              sourceApplication:sourceApplication
                                                     annotation:annotation];
}

- (void)setRootViewController:(UIViewController *)viewController {
  [self.window setRootViewController:viewController];
}

@end
