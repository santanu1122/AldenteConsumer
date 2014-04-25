//
//  ALConstants.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALConstants : NSObject

+ (BOOL) ScreenOfPlatform4m;
+ (BOOL) ScreenOfPlatform5e;
+ (BOOL) DeviceIsIphoneFive;
+ (BOOL) IsConnectedToInternet;
+ (BOOL) ShowLastExecutedMethod;

+ (NSString*) FacebookApplicationId;
+ (NSString*) LastExecutedMethod;
+ (NSString*) AppApiUrl;

-(NSString *)CleanTextField:(NSString *)TextfieldName;
-(BOOL)ValidateEmail:(NSString *)EmailValue;
-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue;
-(BOOL)validatePhone:(NSString*)phone;
-(NSDictionary *)executeFetch:(NSString *)query;
-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType;
- (NSString *) stripTags:(NSString *)s;
-(BOOL)ValidateTextField:(NSString *)TextFieldValue;
-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray;

@end
