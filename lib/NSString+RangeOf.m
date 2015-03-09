//
//  NSString+RangeOf.m
//  Cocoanut
//
//  Created by Jerry Yu on 2015-03-06.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "NSString+RangeOf.h"

@implementation NSString (RangeOf)


- (NSRange)rangeOfString:(NSString *)aString ignoringChars:(char [])chars numChars:(int)n {
    return [self rangeOfString:aString ignoringChars:chars numChars:n ignoreCase:NO];
}

- (NSRange)rangeOfString:(NSString *)aString ignoringChars:(char [])chars numChars:(int)n ignoreCase:(BOOL)flag {
    NSRange match = NSMakeRange(0, 0);
    NSInteger left = 0, test = 0;
    NSInteger origLen = self.length;
    NSInteger targetLen = aString.length;

    BOOL map[256] = {0};
    for (int i = 0; i < n; i ++) {
        map[ chars[i] ] = YES;
    }

    // Get array of unichars for better performance
    unichar *origStr = malloc(sizeof(unichar) * origLen);
    [self getCharacters:origStr range:NSMakeRange(0, origLen)];
    unichar *targetStr = malloc(sizeof(unichar) * targetLen);
    [aString getCharacters:targetStr range:NSMakeRange(0, targetLen)];

#define sameLetter(x, y) ((x >= 'a' && y <= 'z' && x-'a'+'A' == y) || (x >= 'A' && x <= 'Z' && x-'A'+'a' == y))

    while (left < origLen && test < targetLen) {
        unichar oc = origStr[left];

        if (oc == targetStr[test] || (flag && sameLetter(oc, targetStr[test]))) {
            match.length++;
            test++;
        }
        else if (oc < 256 && map[oc] && match.length > 0) {
            match.length++;
        }
        else {
            // Reset
            match.location = left+1;
            match.length = 0;
            test = 0;
        }

        left++;
    }

    // Ensure there was a match by checking the length
    match.length = match.length>=targetLen? match.length:0;
    return match;
}


@end
