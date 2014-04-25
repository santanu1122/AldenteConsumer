//
//  ALStrings.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALStrings.h"

@implementation ALStrings

/* Screen Titles */

+(NSString * const) TitleLoginScreen { return NSLocalizedString(@"TitleLogin", @"Login Screen Title"); }
+(NSString * const) TitleRegistrationScreen { return NSLocalizedString(@"TitleRegistration", @"Registration Screen Title"); }
+(NSString * const) TitleSocialLoginMediatorScreen { return NSLocalizedString(@"TitleSocialLoginMediator", @"Social Login Mediator Screen Title"); }
+(NSString * const) TitleuserAccountScreen { return NSLocalizedString(@"TitleuserAccount", @"User account Screen Title"); }
+(NSString * const) TitleChangePasswordScrren { return NSLocalizedString(@"TitleChangePassword", @"Change User Password Screen Title"); }
+(NSString * const) TitleChangeUserDetails { return NSLocalizedString(@"TitleChangeUser", @"User Details Change Screen Title"); }
+(NSString * const) TitleRestaurantListingScreen { return NSLocalizedString(@"TitleRestaurantListing", @"Restaurant Listing Screen Title"); }
+(NSString * const) TitleRestaurantDetailsScreen { return NSLocalizedString(@"TitleRestaurantDetails", @"Restaurant Details Screen Title"); }

/* Global Texts */

+(NSString * const) GlobalSearchTermsText { return NSLocalizedString(@"TitleRestaurantDetails", @"Restaurant Details Screen Title"); }

/* landing layout Text */
+(NSString * const) LandingScreenGetStartedTitle { return @"Get Started"; }
+(NSString * const) LandingScreenGetStartedCaption { return @"Create AlDente Account"; }
+(NSString * const) LandingScreenSigninTitle { return @"Sign In"; }
+(NSString * const) LandingScreenSigninCaption { return @"Existing AlDente Account"; }

/* Registration layout Text */
+(NSString * const) SignInScreenAgreeTermsandCondition { return @"I agree to the terms & conditions"; }

/* Login layout Text */
+(NSString * const) LoginScreenRememberMe { return  @"Remember me"; }
+(NSString * const) LoginScreenForgotPassword { return  @"Forgot Password ?"; }

/*
 TextFiled Placeholder Texts
 */

// Login Screen

+(NSString * const) LoginScreenEmailFiledPlaceholder { return @"Email"; }
+(NSString * const) LoginScreenPasswordFiledPlaceholder { return @"Password"; }

+(NSString * const) RegistrationScreenNameFiledPlaceholder { return @"Name"; }
+(NSString * const) RegistrationScreenEmailFiledPlaceholder { return @"Email"; }
+(NSString * const) RegistrationScreenPahoneFiledPlaceholder { return @"Phone"; }
+(NSString * const) RegistrationScreenBirthdayFiledPlaceholder { return @"Birthday"; }
+(NSString * const) RegistrationScreenPasswordFiledPlaceholder { return @"Password"; }

/*
 TextFiled Validation Texts
 */

+(NSString * const) VaidationErrorAlertviewTitle { return @"Validation Error"; }
+(NSString * const) VaidationErrorAlertviewCancelButtonTitle { return @"Ok"; }

+(NSString * const) ErrorRegistrationScreenNameFiledBlank { return @"Name can't be blank"; }
+(NSString * const) ErrorRegistrationScreenEmailFiledBlank { return @"Email can't be blank"; }
+(NSString * const) ErrorRegistrationScreenEmailFiledValidate { return @"Not an valied Email"; }
+(NSString * const) ErrorRegistrationScreenPhoneFiledBlank { return @"Phone can't be blank"; }
+(NSString * const) ErrorRegistrationScreenPhoneFiledValidate { return @"Not an valied Phone Number"; }
+(NSString * const) ErrorRegistrationScreenBirthdayFiledBlank { return @"Birthday can't be blank"; }
+(NSString * const) ErrorRegistrationScreenPasswordFiledBlank { return @"Password can't be blank"; }
+(NSString * const) ErrorRegistrationScreenPasswordValidate { return @"Minimum character for Password is 6"; }
+(NSString * const) ErrorRegistrationScreenTermsNotSelected { return @"You have to agree our terms and condition"; }
@end
