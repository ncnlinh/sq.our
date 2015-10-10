#import "Constants.h"

@implementation Constants

static NSString *const kApiUrl = @"http://172.16.2.237:4000";
+ (NSString *)apiUrl {
  return kApiUrl;
}

@end
