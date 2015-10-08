#import <Foundation/Foundation.h>

/**
 *  Set of NSString helper functions
 */
@interface NSString (Helper)

/**
 *  Extract the initial alphabet from a given string.
 *
 *  @param str The given string
 *
 *  @return The initial alphabet. If the string is nil, the intial alphabet will be `#`
 */
+ (NSString *)extractInitialAlphabet:(NSString *)str;

/**
 *  Return the trimmed version of the string
 *
 *  @return The trimmed string
 */
- (NSString *)trim;

/**
 *  Return the MD5 hash of the string
 *
 *  @return The hashed string
 */
- (NSString *)MD5hash;

/**
 *  Check if the string only comprises letters
 *
 *  @return True if there are only letters in the string
 */
- (BOOL)isLetterString;

@end
