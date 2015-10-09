#import "Constants.h"

@implementation Constants

static NSString *const kApiUrl = @"http://172.25.99.40:4000";
+ (NSString *)apiUrl {
  return kApiUrl;
}

@end
