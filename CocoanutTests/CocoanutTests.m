//
//  CocoanutTests.m
//  CocoanutTests
//
//  Created by Jerry Yu on 2015-03-06.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "NSString+RangeOf.h"

@interface CocoanutTests : XCTestCase

@end

@implementation CocoanutTests


- (void)testDocs {
    char ignore[1] = {'-'};
    NSRange expect, result;

    expect = NSMakeRange(0, 5);
    result = [@"1-2-3" rangeOfString:@"123" ignoringChars:ignore numChars:1];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");

    expect = NSMakeRange(0, 5);
    result = [@"1-2-3" rangeOfString:@"1-2-3" ignoringChars:ignore numChars:1];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");

    // Should not be found
    result = [@"1-2-3" rangeOfString:@"321" ignoringChars:ignore numChars:1];
    XCTAssert(result.length == 0, @"Pass");

    // Test does not ignore leading & trailing ignoreChars
    char ignore2[2] = {'-', '='};
    expect = NSMakeRange(1, 5);
    result = [@"-1-2-3=" rangeOfString:@"1-2-3" ignoringChars:ignore2 numChars:2];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");
}


- (void)testNoMatch {
    char ignore[4] = {'-', '+', '#', ' '};
    NSRange result = [@"+1 416-123-4567 #000" rangeOfString:@"@" ignoringChars:ignore numChars:4];
    XCTAssert(result.length == 0, @"Pass");

    result = [@"+1 416-123-4567 #000" rangeOfString:@"416321" ignoringChars:ignore numChars:4];
    XCTAssert(result.length == 0, @"Pass");
}

- (void)testIgnoreOneChar {
    char ignore[1] = {'-'};
    NSRange expect = NSMakeRange(0, 12);
    NSRange result = [@"416-123-4567" rangeOfString:@"4161234567" ignoringChars:ignore numChars:1];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");

    expect = NSMakeRange(0, 10);
    result = [@"4161234567" rangeOfString:@"4161234567" ignoringChars:ignore numChars:1];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");
}

- (void)testIgnoreMultipleChars {
    char ignore[4] = {'-', '+', '#', ' '};
    NSRange expect = NSMakeRange(1, 19);
    NSRange result = [@"+1 416-123-4567 #000" rangeOfString:@"14161234567000" ignoringChars:ignore numChars:4];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");

    expect = NSMakeRange(0, 20);
    result = [@"+1 416-123-4567 #000" rangeOfString:@"+1 416-123-4567 #000" ignoringChars:ignore numChars:4];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");

    expect = NSMakeRange(3, 12);
    result = [@"+1 416-123-4567 #000" rangeOfString:@"4161234567" ignoringChars:ignore numChars:4];
    XCTAssert(NSEqualRanges(expect, result), @"Pass");
}

@end
