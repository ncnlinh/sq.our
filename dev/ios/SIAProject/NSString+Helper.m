#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)

+ (NSString *)extractInitialAlphabet:(NSString *)str {
  if (str == nil || [str trim].length == 0) {
    return @"#";
  }
  NSString *firstChar = [[[str trim] substringToIndex:1] uppercaseString];
  return [firstChar isLetterString] ? firstChar : @"#";
}

- (NSString *)trim {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)MD5hash {
  const char * pointer = [self UTF8String];
  unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
  
  CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
  
  NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [string appendFormat:@"%02x",md5Buffer[i]];
  
  return string;
}

- (BOOL)isLetterString {
  NSCharacterSet *letterSet = [NSCharacterSet letterCharacterSet];
  return [[self stringByTrimmingCharactersInSet:letterSet] isEqualToString:@""];
}


@end
