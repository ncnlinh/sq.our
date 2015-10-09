#import <NSDate+DateTools.h>

/**
 *  Set of NSDate helper functions
 */
@interface NSDate (Helper)

#pragma mark - Date Helpers
/**
 *  Retrieve the date without consideration of time from the called date
 *
 *  @return The date without information of time of the givend ate
 */
- (NSDate *)dateWithoutTime;

/**
 *  Get the weekday notation of the called date
 *
 *  @return The weekdaty notation string
 */
- (NSString *)weekdayNotation;

/**
 *  Get the ISO format of the called date
 *
 *  @return The ISO formatted string
 */
- (NSString *)isoDateString;

+ (NSDate *)isoDateFromString:(NSString *)dateString;

/**
 *  Retrieve the date with time as the end of that day of the called date
 *
 *  @return The date with time as the end of the day
 */
- (NSDate *)endDay;

#pragma mark - Date Transformer and Formatter
/**
 *  Get the date transformer with ISO format
 *
 *  @return The date transformer with ISO date format
 */
+ (NSValueTransformer *)dateTransformer;

/**
 *  Get ISO date formatter
 *
 *  @return The defined formatter
 */
+ (NSDateFormatter *)isoDateFormatter;

/**
 *  get Day formatter which will ignore the time
 *
 *  @return The defined formatter
 */
+ (NSDateFormatter *)dayFormatter;

/**
 *  Get list of time with each elements away from the previous one of 15 minutes
 *
 *  @return the array of times
 */
+ (NSArray *)getTimeList;

@end
