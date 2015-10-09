#import <JTCalendar/JTCalendar.h>
#import <Masonry/Masonry.h>

#import "DateModalViewController.h"
#import "ShadowUIView.h"
#import "UIColor+Helper.h"
#import "UIView+Helper.h"
#import "UIFont+Helper.h"
#import "NSDate+Helper.h"

@interface DateModalViewController()<JTCalendarDelegate>

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIButton *backgroundButton;

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

@implementation DateModalViewController

#pragma mark - View Controller Setup
- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (!self.primaryColor) {
    self.primaryColor = [UIColor appPrimaryColor];
  }
  [self configureBackgroundButton];
  [self configureModalView];
  [self configureCalendarMenuView];
  [self configureCalendarContentView];
  [self configureCalendarBehavior];
}

- (void)configureBackgroundButton {
  self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:self.backgroundButton];
  
  [self.backgroundButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.95]];
  [self.backgroundButton addTarget:self
                            action:@selector(backgroundButtonPressed:)
                  forControlEvents:UIControlEventTouchUpInside];
  
  [self.backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.view.mas_top);
    make.left.mas_equalTo(self.view.mas_left);
    make.size.mas_equalTo(self.view);
  }];
}

- (void)configureModalView {
  ShadowUIView *modalView = [[ShadowUIView alloc] init];
  [self.view addSubview:modalView];
  
  [modalView setBackgroundColor:[UIColor whiteColor]];
  [modalView setCornerRadius:5.0];
  [modalView configureForShadows];
  [modalView setShadowColor:[UIColor blackColor]];
  [modalView setShadowOpacity:0.4];
  [modalView setShadowOffset:CGSizeMake(0, 2.0)];
  [modalView setShadowRadius:3.0];
  
  [modalView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.mas_equalTo(self.view);
    make.width.mas_equalTo(300);
    make.height.mas_equalTo(400);
  }];
  
  self.containerView = [[UIView alloc] init];
  [modalView addSubview:self.containerView];
  
  [self.containerView setCornerRadius:modalView.layer.cornerRadius];
  [self.containerView setBackgroundColor:[UIColor whiteColor]];
  [self.containerView setClipsToBounds:TRUE];
  
  [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(modalView);
  }];
}

- (void)configureCalendarMenuView {
  self.calendarMenuView = [[JTCalendarMenuView alloc] init];
  [self.containerView addSubview:self.calendarMenuView];
  
  [self.calendarMenuView setBackgroundColor:_primaryColor];
  
  [self.calendarMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.containerView.mas_top);
    make.left.mas_equalTo(self.containerView.mas_left);
    make.width.mas_equalTo(self.containerView.mas_width);
    make.height.mas_equalTo(60);
  }];
}

- (void)configureCalendarContentView {
  self.calendarContentView = [[JTHorizontalCalendarView alloc] init];
  [self.containerView addSubview:self.calendarContentView];
  
  [self.calendarContentView setBackgroundColor:[UIColor whiteColor]];
  
  [self.calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.calendarMenuView.mas_bottom);
    make.left.mas_equalTo(self.containerView.mas_left);
    make.width.mas_equalTo(self.containerView.mas_width);
    make.bottom.mas_equalTo(self.containerView.mas_bottom);
  }];
}

- (void)configureCalendarBehavior {
  self.calendarManager = [JTCalendarManager new];
  [self.calendarManager setDelegate:self];
  [self.calendarManager setMenuView:self.calendarMenuView];
  [self.calendarManager setContentView:self.calendarContentView];
  [self.calendarManager setDate:[NSDate date]];
}

#pragma mark - JTCalendar Delegate
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {
  // Today
  if ([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]) {
    dayView.circleView.hidden = NO;
    dayView.circleView.backgroundColor = [UIColor appWarningColor];
    dayView.textLabel.textColor = [UIColor whiteColor];
  }
  // Selected date
  else if (_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]) {
    dayView.circleView.hidden = NO;
    dayView.circleView.backgroundColor = self.primaryColor;
    dayView.textLabel.textColor = [UIColor whiteColor];
  }
  // Other month
  else if (![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]) {
    dayView.circleView.hidden = YES;
    dayView.textLabel.textColor = [UIColor lightGrayColor];
  }
  // Another day of the current month
  else {
    dayView.circleView.hidden = YES;
    dayView.textLabel.textColor = [UIColor blackColor];
  }
  dayView.dotView.hidden = TRUE;
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {
  _dateSelected = dayView.date;
  
  // Animation for the circleView
  dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
  [UIView transitionWithView:dayView
                    duration:.3
                     options:0
                  animations:^{
                    dayView.circleView.transform = CGAffineTransformIdentity;
                    [_calendarManager reload];
                  } completion:nil];
  
  
  [self.delegate dateSelected:_dateSelected];
  [self dismissViewControllerAnimated:FALSE completion:nil];
}

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar {
  UILabel *label = [UILabel new];
  
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont mediumPrimaryFontWithSize:20];
  label.textColor = [UIColor whiteColor];
  
  return label;
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView
            date:(NSDate *)date {
  menuItemView.text = [[date formattedDateWithFormat:@"MMM yyyy"] uppercaseString];
}

#pragma mark - Button Handler
- (void)backgroundButtonPressed:(UIButton *)backgroundButton {
  [self.delegate emptySelected];
  [self dismissViewControllerAnimated:FALSE completion:nil];
}

@end
