//
//  ALSocialRegistrationViewController.h
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALSocialRegistrationViewController : UIViewController
@property (strong,nonatomic) NSString *userid;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *fullname;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *birthday;
@property (strong,nonatomic) NSString *login_mode;

-(IBAction)SlideupPopupWhileEditing:(UITextField *)sender;
-(IBAction)SlideDownPopupWhileEditing:(UITextField *)sender;
-(IBAction)ClickedOnTermsAndCondition:(UITextField *)sender;
@end
