#import "Constants.h"

@implementation Constants

static NSString *const kApiUrl = @"http://10.0.3.252:4000";
+ (NSString *)apiUrl {
  return kApiUrl;
}

@end
