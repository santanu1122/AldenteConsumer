//
//  ALAppServices.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAppServices : NSObject

+ (NSString *) FaceBookApplicationId;
+ (NSString *) AFApiUrl;
+ (NSString *) AFApiDateFormat;
+ (NSString *) AFFontSemibold;
+ (NSString *) AFFontRegular;
+ (NSString *) AFFontLight;
+ (NSString *) AFFontSecondRegular;
+ (NSString *) AFFontSecondSemiBold;

#pragma mark NsuserDefault (Private)

+ (NSString *)ALLogedInUserId;
+ (NSString *)ALLogedInUserName;
+ (NSString *)ALLogedInUserEmail;
+ (NSString *)ALLogedInUserPhone;
+ (NSString *)ALLogedInUserPassword;
+ (NSString *)ALLogedInUserfbconnectId;
+ (NSString *)ALLogedInUsertwitterId;
+ (NSString *)ALLogedInUserregister_date;
+ (NSString *)ALLogedInUserlastlogin_date;
+ (NSString *)ALLogedInUserdevicetoken;
+ (NSString *)ALLogedInUserstatus;
+ (NSString *)UserSelectedLogedInType;
+ (NSString *)UserIslogedIn;

+ (float) ALGetStartedTitleFontSize;
+ (float) ALGetStartedTaglineFontSize;
+ (float) ALSigninTitleFontSize;
+ (float) ALSigninTaglineFontSize;
+ (float) ALTermsAndServicesFontSize;

// all global constants

+ (float) ALGetGlobalSearchTermsTextFontSize;
+ (UIColor *) AlTextFiledTextColor;
@end
