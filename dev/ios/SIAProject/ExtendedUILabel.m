#import "ExtendedUILabel.h"

@implementation ExtendedUILabel

#pragma mark - Initializers
- (instancetype)init {
  self = [super init];
  if (self) {
    self.edgeInsets = UIEdgeInsetsZero;
  }
  
  return self;
}

- (instancetype)initWithEdgeInsets:(UIEdgeInsets)edgeInsets {
  self = [super init];
  if (self) {
    self.edgeInsets = edgeInsets;
  }
  
  return self;
}

#pragma mark - Override Methods
- (void)drawTextInRect:(CGRect)rect {
  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

// For auto-layout to be correct
- (CGSize)intrinsicContentSize {
  CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize] ;
  intrinsicSuperViewContentSize.height += self.edgeInsets.top + self.edgeInsets.bottom;
  intrinsicSuperViewContentSize.width += self.edgeInsets.left + self.edgeInsets.right;
  return intrinsicSuperViewContentSize;
}

@end
