//
//  ALRedirectViews.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALRedirectViews.h"
#import "ALAllViewControlers.h"

@implementation ALRedirectViews

+(UIViewController *) landingViewController {
    
    ALViewController *MainViewController = [[ALViewController alloc] initWithNibName:NSStringFromClass(ALViewController.class) bundle:nil];
    
    return MainViewController;
}

+(UIViewController *)LoginViewController {
    
    ALLoginMethodsViewController *LoginMethodView = [[ALLoginMethodsViewController alloc] initWithNibName:NSStringFromClass(ALLoginMethodsViewController.class) bundle:nil];
    
    return LoginMethodView;
}

+(UIViewController *)LostpasswordViewController {
    
    ALLostPasswordViewController *LostPasswordView = [[ALLostPasswordViewController alloc] initWithNibName:NSStringFromClass(ALLostPasswordViewController.class) bundle:nil];
    
    return LostPasswordView;
}

+(UIViewController *)RegisterViewController {
    
    ALRegistrationViewController *RegisterView    = [[ALRegistrationViewController alloc] initWithNibName:NSStringFromClass(ALRegistrationViewController.class) bundle:nil];
    
    return RegisterView;
}

+(UIViewController *)SocialRegisterViewController {
    
    ALSocialRegistrationViewController *SocialRegister = [[ALSocialRegistrationViewController alloc] initWithNibName:NSStringFromClass(ALSocialRegistrationViewController.class) bundle:nil];
    
    return SocialRegister;
}

+(UIViewController *)LandingViewController {
    
    ALLandingViewController *LandingView = [[ALLandingViewController alloc] initWithNibName:NSStringFromClass(ALLandingViewController.class) bundle:nil];
    
    return LandingView;
}

@end
