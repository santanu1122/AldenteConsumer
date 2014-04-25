//
//  ALAppDelegate.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class ALViewController;

@interface ALAppDelegate : UIResponder <UIApplicationDelegate>


-(void)SEtuptabbarFornotlogedinuser;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FBSession *session;
@property (nonatomic,retain) UINavigationController *NavigationController;


@end
