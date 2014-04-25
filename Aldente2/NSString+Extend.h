//
//  NSString+Extend.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

+ (BOOL)isNilOrEmpty:(NSString *)input;
- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (BOOL)isDigit;
- (BOOL)isNumeric;
- (BOOL)isAlphanumeric;
- (BOOL)hasBothCases;
- (BOOL)isUrl;
- (BOOL)isMinLength:(NSUInteger)length;
- (BOOL)isMaxLength:(NSUInteger)length;
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
- (BOOL)isEmpty;

@end
