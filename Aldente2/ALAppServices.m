//
//  ALAppServices.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALAppServices.h"

typedef enum {
    UserSelectedLogedInTypeFacebook = 1,
    UserSelectedLogedInTypeTwitter,
    UserSelectedLogedInTypeNormal

} UserSelectedLogedInType;

NSString * const AFFontSemibold          = @"MyriadPro-Semibold";
NSString * const AFFontRegular           = @"MyriadPro-Regular";
NSString * const AFFontLight             = @"MyriadPro-Light";
NSString * const AFFontSecondRegular     = @"SegoeUI-Regular";
NSString * const AFFontSecondSemiBold    = @"SegoeUI-SemiBold";

@implementation ALAppServices

+ (NSString *) FaceBookApplicationId { return @"543728999077872"; }
+ (NSString *) AFApiUrl { return @"www.yahoo.com"; }
+ (NSString *) AFApiDateFormat { return @"MM-dd-yyyy"; }
+ (NSString *) AFFontSemibold { return AFFontSemibold; }
+ (NSString *) AFFontRegular { return AFFontRegular; }
+ (NSString *) AFFontLight { return AFFontLight; }
+(NSString *)AFFontSecondRegular { return AFFontSecondRegular; }
+(NSString *)AFFontSecondSemiBold { return AFFontSecondSemiBold; }

// all global constants

+ (float) ALGetStartedTitleFontSize { return 14.0; }

// All fonts Decleration

+ (float) ALGetGlobalSearchTermsTextFontSize { return 15.0; }
+ (float) ALGetStartedTaglineFontSize { return 10.0; }
+ (float) ALSigninTitleFontSize { return 14.0; }
+ (float) ALSigninTaglineFontSize { return 10.0; }
+ (float) ALTermsAndServicesFontSize { return 14.0; }

// All color Decleration

+ (UIColor *) AlTextFiledTextColor { return [UIColor whiteColor]; }

#pragma user data

+ (NSString *)ALLogedInUserId { return @"ALLogedInUserId"; }
+ (NSString *)ALLogedInUserName { return @"ALLogedInUserName"; }
+ (NSString *)ALLogedInUserEmail { return @"ALLogedInUserEmail"; }
+ (NSString *)ALLogedInUserPhone { return @"ALLogedInUserPhone"; }
+ (NSString *)ALLogedInUserPassword { return @"ALLogedInUserPassword"; }
+ (NSString *)ALLogedInUserfbconnectId { return @"ALLogedInUserfbconnectId"; }
+ (NSString *)ALLogedInUsertwitterId { return @"ALLogedInUsertwitterId"; }
+ (NSString *)ALLogedInUserregister_date { return @"ALLogedInUserregister_date"; }
+ (NSString *)ALLogedInUserlastlogin_date { return @"ALLogedInUserlastlogin_date"; }
+ (NSString *)ALLogedInUserdevicetoken { return @"ALLogedInUserdevicetoken"; }
+ (NSString *)ALLogedInUserstatus { return @"ALLogedInUserstatus"; }
+ (NSString *)UserSelectedLogedInType { return @"UserSelectedLogedInType"; }
+ (NSString *)UserIslogedIn { return @"UserIslogedIn"; }

// waitlist

+ (float) ALWaitListViewTitleFontSize { return 22.0; }
@end
