//
//  ALAppDelegate.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALAppDelegate.h"
#import "ALViewController.h"
#import "ALRedirectViews.h"
#import "ALAllImages.h"
#import "ALGlobalAccess.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ALAllRestaurantListViewController.h"
#import "ALMoreViewController.h"
#import "ALWaitlistViewController.h"
#import "ALReservationsViewController.h"
#import "ALCouponsViewController.h"
#import "ALVerifyPhoneViewController.h"

@implementation ALAppDelegate

@synthesize NavigationController     = _NavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window                     = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ALAllImages.APPBackgroundImage]]];
    
    ALGlobalAccess *GlobalAccess    = [[ALGlobalAccess alloc] init];
    
    [GlobalAccess RegisterDeviceForRemoteNotification];
    
    _NavigationController           = [[UINavigationController alloc] initWithRootViewController:ALRedirectViews.landingViewController];
    
    [_NavigationController setNavigationBarHidden:YES];
    
    self.window.rootViewController  = _NavigationController;
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"userid --- %@",[UserDefaults objectForKey:@"USERID"]);
    
    // souvik
    
    if ([[UserDefaults objectForKey:@"USERID"] intValue] > 0) {
        
        ALAllRestaurantListViewController *AllRestaurantListViewController = [[ALAllRestaurantListViewController alloc] init];
        [self.NavigationController pushViewController:AllRestaurantListViewController animated:NO];
        
    } else {
        [self SEtuptabbarFornotlogedinuser];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}
-(void)SEtuptabbarFornotlogedinuser {
    
    _NavigationController           = [[UINavigationController alloc] initWithRootViewController:ALRedirectViews.landingViewController];
    [_NavigationController setNavigationBarHidden:YES];
    self.window.rootViewController  = _NavigationController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [FBSession.activeSession handleOpenURL:url];
}

@end
