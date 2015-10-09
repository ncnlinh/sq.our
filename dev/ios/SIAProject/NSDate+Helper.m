#import <Mantle/Mantle.h>

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

- (NSDate *)dateWithoutTime {
  return [[NSDate dayFormatter] dateFromString:[[NSDate dayFormatter] stringFromDate:self]];
}

- (NSString *)weekdayNotation {
  NSInteger weekday = [self weekday];
  switch (weekday) {
    case 1:
      return @"SUN";
      break;
    case 2:
      return @"MON";
      break;
    case 3:
      return @"TUE";
      break;
    case 4:
      return @"WED";
      break;
    case 5:
      return @"THU";
      break;
    case 6:
      return @"FRI";
      break;
    case 7:
      return @"SAT";
    default:
      NSAssert(false, @"Invalid weekday");
      return nil;
      break;
  }
}

- (NSDate *)endDay {
  return [NSDate dateWithYear:self.year month:self.month day:self.day hour:23 minute:59 second:59];
}

- (NSString *)isoDateString {
  return [[NSDate isoDateFormatter] stringFromDate:self];
}

+ (NSDate *)isoDateFromString:(NSString *)dateString {
  return [[NSDate isoDateFormatter] dateFromString:dateString];
}

#pragma mark - Date Helper
+ (NSValueTransformer *)dateTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:
          ^(NSString *str, BOOL *success, NSError *__autoreleasing *error) {
            return [[NSDate isoDateFormatter] dateFromString:str];
          }
                                              reverseBlock:
          ^(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            return [[NSDate isoDateFormatter] stringFromDate:date];
          }
          ];
  
}

+ (NSDateFormatter *)isoDateFormatter {
  static NSDateFormatter *dateFormatter = nil;
  if (dateFormatter == nil) {
    dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
  }
  
  return dateFormatter;
}

+ (NSDateFormatter *)dayFormatter {
  static NSDateFormatter *dayFormatter = nil;
  if (dayFormatter == nil) {
    dayFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dayFormatter setLocale:enUSPOSIXLocale];
    [dayFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dayFormatter setDateFormat:@"yyyy-MM-dd"];
  }
  
  return dayFormatter;
}

+ (NSArray *)getTimeList {
  NSMutableArray *arr = [NSMutableArray new];
  for (NSInteger i = 0; i < 24; i++) {
    for (NSInteger j = 0; j < 60; j += 15) {
      [arr addObject:[NSString stringWithFormat:@"%02td:%02td", i, j]];
    }
  }
  
  return [arr copy];
}

@end
