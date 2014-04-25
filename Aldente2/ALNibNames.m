//
//  ALNibNames.m
//  Aldente2
//
//  Created by Iphone_2 on 04/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALNibNames.h"
#import "ALConstants.h"

// Screen after app launch

NSString * const MainScreenIphoneFive                      = @"ALViewController";
NSString * const MainScreenIphoneFour                      = @"ALViewController_small";

// Login Screen

NSString * const LoginScreenIphoneFive                     = @"ALLoginMethodsViewController";
NSString * const LoginScreenIphoneFour                     = @"ALLoginMethodsViewController_small";

// Lost password screen

NSString * const LostPasswordScreenIphoneFive              = @"ALLostPasswordViewController";
NSString * const LostPasswordScreenIphoneFour              = @"ALLostPasswordViewController_small";

// Registration screen

NSString * const RegistrationScreenIphoneFive              = @"ALRegistrationViewController";
NSString * const RegistrationScreenIphoneFour              = @"ALRegistrationViewController_small";

// Social Registration Middle screen

NSString * const SocialRegistrationMiddleScreenIphoneFive  = @"ALSocialRegistrationViewController";
NSString * const SocialRegistrationMiddleScreenIphoneFour  = @"ALSocialRegistrationViewController_small";

// Landing screen

NSString * const LandingScreenIphoneFive                    = @"ALLandingViewController";
NSString * const LandingScreenIphoneFour                    = @"ALLandingViewController_small";

// Restaurant Listing Screen

NSString * const RestaurantListingFive                      = @"ALAllRestaurantListViewController";
NSString * const RestaurantListingFour                      = @"ALAllRestaurantListViewController_small";

// Rastaurant Deatils Screen

NSString * const RestaurantDetailsFive                      = @"ALRestaurantDetailsViewController";
NSString * const RestaurantDetailsFour                      = @"ALRestaurantDetailsViewController_small";


@implementation ALNibNames

+(NSString *)MainViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?MainScreenIphoneFive:MainScreenIphoneFour;
}

+(NSString *)LoginViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?LoginScreenIphoneFive:LoginScreenIphoneFour;
}

+(NSString *)LostPasswordViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?LostPasswordScreenIphoneFive:LostPasswordScreenIphoneFour;
}

+(NSString *)RegistrationViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?RegistrationScreenIphoneFive:RegistrationScreenIphoneFour;
}

+(NSString *)SocialRegistrationMiddleViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?SocialRegistrationMiddleScreenIphoneFive:SocialRegistrationMiddleScreenIphoneFour;
}

+(NSString *)landingViewScreen {
    
    return (ALConstants.DeviceIsIphoneFive)?LandingScreenIphoneFive:LandingScreenIphoneFour;
}
@end
