//
//  ALStrings.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALStrings : NSObject

/* Screen Titles */

+(NSString * const) TitleLoginScreen;
+(NSString * const) TitleRegistrationScreen;
+(NSString * const) TitleSocialLoginMediatorScreen;
+(NSString * const) TitleuserAccountScreen;
+(NSString * const) TitleChangePasswordScrren;
+(NSString * const) TitleChangeUserDetails;
+(NSString * const) TitleRestaurantListingScreen;
+(NSString * const) TitleRestaurantDetailsScreen;

/*
 All Global Texts
 */

+(NSString * const) GlobalSearchTermsText;

/*
    All Static Texts
*/

+(NSString * const) LandingScreenGetStartedTitle;
+(NSString * const) LandingScreenGetStartedCaption;
+(NSString * const) LandingScreenSigninTitle;
+(NSString * const) LandingScreenSigninCaption;
+(NSString * const) SignInScreenAgreeTermsandCondition;

+(NSString * const) LoginScreenRememberMe;
+(NSString * const) LoginScreenForgotPassword;


/*
    TextFiled Placeholder Texts
 */

// Login Screen

+(NSString * const) LoginScreenEmailFiledPlaceholder;
+(NSString * const) LoginScreenPasswordFiledPlaceholder;

// Registration view Placehgolder texts

+(NSString * const) RegistrationScreenNameFiledPlaceholder;
+(NSString * const) RegistrationScreenEmailFiledPlaceholder;
+(NSString * const) RegistrationScreenPahoneFiledPlaceholder;
+(NSString * const) RegistrationScreenBirthdayFiledPlaceholder;
+(NSString * const) RegistrationScreenPasswordFiledPlaceholder;

/*
 TextFiled Validation Texts
 */
+(NSString * const) VaidationErrorAlertviewTitle;
+(NSString * const) VaidationErrorAlertviewCancelButtonTitle;

+(NSString * const) ErrorRegistrationScreenNameFiledBlank;
+(NSString * const) ErrorRegistrationScreenEmailFiledBlank;
+(NSString * const) ErrorRegistrationScreenEmailFiledValidate;
+(NSString * const) ErrorRegistrationScreenPhoneFiledBlank;
+(NSString * const) ErrorRegistrationScreenPhoneFiledValidate;
+(NSString * const) ErrorRegistrationScreenBirthdayFiledBlank;
+(NSString * const) ErrorRegistrationScreenPasswordFiledBlank;
+(NSString * const) ErrorRegistrationScreenPasswordValidate;
+(NSString * const) ErrorRegistrationScreenTermsNotSelected;
@end
