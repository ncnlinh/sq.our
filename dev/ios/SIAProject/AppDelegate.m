#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import "AppDelegate.h"

#import "RootNavigationController.h"
#import "UIFont+Helper.h"
#import "UIColor+Helper.h"
#import "LoginViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Setup FB SDK
  [[FBSDKApplicationDelegate sharedInstance] application:application
                           didFinishLaunchingWithOptions:launchOptions];
  [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
  
  [self configureAppearances];
  
  // Initialize window
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
//  if([FBSDKAccessToken currentAccessToken]){
//    MainViewController *mainViewController = [[MainViewController alloc] init];
//    [self.window setRootViewController:mainViewController];
//  } else {
//    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    [self.window setRootViewController:loginViewController];
//  }
  LoginViewController *loginViewController = [[LoginViewController alloc] init];
  [self.window setRootViewController:loginViewController];
  [self.window makeKeyAndVisible];

  
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

- (void)configureAppearances {
  [self configureNavigationBarAppearance];
}

- (void)configureNavigationBarAppearance {
  NSDictionary *attrs = @{
                          NSFontAttributeName: [UIFont mediumPrimaryFontWithSize:18],
                          NSForegroundColorAttributeName: [UIColor whiteColor]
                          };
  [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[RootNavigationController class]]]
   setTitleTextAttributes:attrs];
  [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[RootNavigationController class]]]
   setBarTintColor:[UIColor appPrimaryColor]];
  [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[RootNavigationController class]]]
   setTintColor:[UIColor whiteColor]];
}

- (void)loadLocationInfo {
  
}

@end
