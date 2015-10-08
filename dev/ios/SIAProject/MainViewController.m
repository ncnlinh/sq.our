#import "MainViewController.h"

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FlightViewController.h"
#import "ChatViewController.h"
#import "PaymentViewController.h"
#import "MenuViewController.h"
#import "RootNavigationController.h"

@interface MainViewController()<MenuViewControllerDelegate>

@property (strong, nonatomic) RootNavigationController *rootNavigationController;
@property (strong, nonatomic) NSArray *mainViewControllers;
@property (nonatomic) NSInteger selectedSection;
@property (nonatomic) NSInteger selectedIndex;

@end

static NSInteger const kMainSectionIndex = 0;
static NSInteger const kOtherSectionIndex = 1;

@implementation MainViewController

#pragma mark - View Controller Setup
- (instancetype)init {
  self = [super init];
  if (self) {
    [self initializeContent];
    [self initializeMenu];
  }
  
  return self;
}

- (void)initializeContent {
  // Main View Controllers
  FlightViewController *flightViewController = [[FlightViewController alloc] init];
  ChatViewController *chatViewController = [[ChatViewController alloc] init];
  PaymentViewController *paymentViewController = [[PaymentViewController alloc] init];
  self.mainViewControllers = @[flightViewController, chatViewController, paymentViewController];
  
  self.selectedSection = kMainSectionIndex;
  self.selectedIndex = 0;
  self.rootNavigationController = [[RootNavigationController alloc]
                                   initWithRootViewController:
                                   self.mainViewControllers[_selectedIndex]];
  self.contentViewController = self.rootNavigationController;
}

- (void)initializeMenu {
  MenuViewController *menuVc = [[MenuViewController alloc] init];
  menuVc.delegate = self;
  self.menuViewController = menuVc;
}

#pragma mark - Menu View Controller Delegate
- (void)mainMenuItemSelected:(NSInteger)row {
  if (_selectedSection != kMainSectionIndex || _selectedIndex != row) {
    _selectedSection = kMainSectionIndex;
    _selectedIndex = row;
    [self.rootNavigationController setViewControllers:@[self.mainViewControllers[_selectedIndex]]
                                             animated:FALSE];
  }
  [self hideMenuViewController];
}

- (void)otherMenuItemSelected:(NSInteger)row {
  NSLog(@"Log Out");
}

@end
