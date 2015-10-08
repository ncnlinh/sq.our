#import "MainViewController.h"

#import "QuickCloud.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ContactsViewController.h"
#import "AppointmentViewController.h"
#import "TaskViewController.h"
#import "SettingsViewController.h"
#import "SyncContactsViewController.h"
#import "MenuViewController.h"
#import "RootNavigationController.h"
#import "QuickDeskHelper.h"

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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[UIApplication sharedApplication] setStatusBarHidden:FALSE withAnimation:UIStatusBarAnimationSlide];
}

- (void)initializeContent {
  // Main View Controllers
  ContactsViewController *contactsViewController = [[ContactsViewController alloc] init];
  AppointmentViewController *calendarViewController = [[AppointmentViewController alloc] init];
  TaskViewController *taskViewController = [[TaskViewController alloc] init];
  self.mainViewControllers = @[contactsViewController, calendarViewController, taskViewController];
  
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
  _selectedSection = kOtherSectionIndex;
  _selectedIndex = row;
  
  UIViewController *viewController;
  if (_selectedIndex == 0) {
    viewController = [[SyncContactsViewController alloc] init];
  } else {
    viewController = [[SettingsViewController alloc] init];
  }
  RootNavigationController *modalNavController = [[RootNavigationController alloc]
                                                  initWithRootViewController:viewController];
  modalNavController.modalPresentationStyle = UIModalPresentationOverFullScreen;
  modalNavController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  [self.rootNavigationController presentViewController:modalNavController
                                              animated:TRUE
                                            completion:^{
                                              [self hideMenuViewController];
                                            }];
}

@end
