#import <UIKit/UIKit.h>

@interface ExtendedUILabel : UILabel

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (instancetype)initWithEdgeInsets:(UIEdgeInsets)edgeInsets;

@end
