//
//  NSString+RangeOf.h
//  Cocoanut
//
//  Created by Jerry Yu on 2015-03-06.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RangeOf)

// Searches and returns the range of `aString`, while ignoring the specified chars in this string if those
// chars are not found in `aString`.
//      Eg. [@"1-2-3" rangeOfString:@"123" ignoringChars:{'-'} numChars:1] => {0, 5}
//      Eg. [@"1-2-3" rangeOfString:@"1-2-3" ignoringChars:{'-'} numChars:1] => {0, 5}
// If no match is found, length will be 0
//      Eg. [@"1-2-3" rangeOfString:@"321" ignoringChars:{'-'} numChars:1] => {x, 0}
// Will not match and leading or trailing ignoredChars
//      Eg. [@"-1-2-3=" rangeOfString:@"123" ignoringChars:{'-', '='} numChars:2] => {1, 5}
- (NSRange)rangeOfString:(NSString *)aString ignoringChars:(char [])chars numChars:(int)n;

// Same as above, with additional option to ignore case
//      Eg. [@"Apple Canada" rangeOfString:@"appleCanada" ignoringChars:NULL numChars:0 ignoreCase:YES] => {x, 12}
- (NSRange)rangeOfString:(NSString *)aString ignoringChars:(char [])chars numChars:(int)n ignoreCase:(BOOL)flag;

@end
