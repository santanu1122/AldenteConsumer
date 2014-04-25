//
//  ALGlobalAccess.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 07/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALGlobalAccess.h"
#import "ALAppServices.h"
#import "ALCreateObject.h"


@implementation ALGlobalAccess

-(void)RegisterDeviceForRemoteNotification {
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

-(UITextField *)GenerateTextFieldForAcess :(int)TextfieldTagValue Delegate:(id)Delegate TextFiledtextColor:(UIColor *)TextFiledtextColor TextFieldsetFontSize:(float)TextFieldsetFontSize TextFieldFont:(NSString *)TextFieldFont GlobalView:(UIView *)GlobalView PlaceholderText:(NSString *)PlaceholderText {
    
    UITextField *GlobalTextField                    = (UITextField *)[GlobalView viewWithTag:TextfieldTagValue];
    UIView *paddingView                             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    GlobalTextField.textColor                       = [UIColor whiteColor];
    GlobalTextField.leftView                        = paddingView;
    GlobalTextField.leftViewMode                    = UITextFieldViewModeAlways;
    GlobalTextField.attributedPlaceholder           = [[NSAttributedString alloc] initWithString:PlaceholderText attributes:@{NSForegroundColorAttributeName: TextFiledtextColor}];
    [GlobalTextField setFont:[UIFont fontWithName:TextFieldFont size:TextFieldsetFontSize]];
    [GlobalTextField setDelegate:Delegate];
    
    return GlobalTextField;
}

-(void)GenerateUIlabelForAcess :(int)UilabelTagValue Delegate:(id)Delegate UilabeltextColor:(UIColor *)UilabeltextColor UilabelsetFontSize:(float)UilabelsetFontSize UilabelFont:(NSString *)UilabelFont GlobalView:(UIView *)GlobalView UilabelText:(NSString *)UilabelText UilabelTextAlignment:(NSTextAlignment *)UilabelTextAlignment {
    
    UILabel *GlobalLabel                            = (UILabel *)[GlobalView viewWithTag:UilabelTagValue];
    [GlobalLabel setText:UilabelText];
    [GlobalLabel setFont:[UIFont fontWithName:UilabelFont size:UilabelsetFontSize]];
    [GlobalLabel setTextColor:UilabeltextColor];
}
-(UIScrollView *)GenerateUIScrollForAcess :(int)UiscrollviewTagVal GlobalView:(UIView *)GlobalView Delegate:(id)Delegate ScrollEnabled:(BOOL)ScrollEnabled userInteractionEnabled:(BOOL)userInteractionEnabled showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator SCrollBackgroundColor:(UIColor *)SCrollBackgroundColor ScrollviewExtraWidth:(float)ScrollviewExtraWidth ScrollViewExtraHeight:(float)ScrollViewExtraHeight {
    
    UIScrollView *UiscrollViewMain                  = (UIScrollView *)[GlobalView viewWithTag:UiscrollviewTagVal];
    [UiscrollViewMain setDelegate:Delegate];
    [UiscrollViewMain setScrollEnabled:ScrollEnabled];
    UiscrollViewMain.userInteractionEnabled         = userInteractionEnabled;
    UiscrollViewMain.showsVerticalScrollIndicator   = showsVerticalScrollIndicator;
    UiscrollViewMain.scrollEnabled                  = ScrollEnabled;
    UiscrollViewMain.backgroundColor                = SCrollBackgroundColor;
    UiscrollViewMain.contentSize                    = CGSizeMake(UiscrollViewMain.frame.size.width+ScrollviewExtraWidth, UiscrollViewMain.frame.size.height+ScrollViewExtraHeight);
    [UiscrollViewMain setContentOffset:CGPointMake(0, 0) animated:YES];
    return UiscrollViewMain;
}

-(void)SetUserDeviceToken :(NSString *)ALLogedInUserdevicetoken
{
    NSUserDefaults *GlobalUserDefault               = [NSUserDefaults standardUserDefaults];
    [GlobalUserDefault setObject:ALLogedInUserdevicetoken forKey:ALAppServices.ALLogedInUserdevicetoken];
    [GlobalUserDefault synchronize];
}

-(void)SetLogedinUserData :(id)LogedinUserDataObject {

    ALCreateObjectForData  *LogedinUserData   = LogedinUserDataObject;
    
    NSUserDefaults *GlobalUserDefault               = [NSUserDefaults standardUserDefaults];
    
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserId forKey:ALAppServices.ALLogedInUserId];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserName forKey:ALAppServices.ALLogedInUserName];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserEmail forKey:ALAppServices.ALLogedInUserEmail];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserPhone forKey:ALAppServices.ALLogedInUserPhone];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserPassword forKey:ALAppServices.ALLogedInUserPassword];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserfbconnectId forKey:ALAppServices.ALLogedInUserfbconnectId];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUsertwitterId forKey:ALAppServices.ALLogedInUsertwitterId];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserregister_date forKey:ALAppServices.ALLogedInUserregister_date];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserlastlogin_date forKey:ALAppServices.ALLogedInUserlastlogin_date];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserdevicetoken forKey:ALAppServices.ALLogedInUserdevicetoken];
    [GlobalUserDefault setObject:LogedinUserData.ALLogedInUserstatus forKey:ALAppServices.ALLogedInUserstatus];
    [GlobalUserDefault setBool:LogedinUserData.ALUserIsLogedIn forKey:ALAppServices.UserIslogedIn];
    [GlobalUserDefault synchronize];
    
}

-(void)RemoveAlluserDataAfterLogout {
    
     NSUserDefaults *GlobalUserDefault               = [NSUserDefaults standardUserDefaults];
    
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserId];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserName];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserEmail];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserPhone];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserPassword];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserfbconnectId];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUsertwitterId];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserregister_date];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserlastlogin_date];
    [GlobalUserDefault removeObjectForKey:ALAppServices.ALLogedInUserstatus];
    [GlobalUserDefault setBool:NO forKey:ALAppServices.UserIslogedIn];
    [GlobalUserDefault synchronize];
}


@end

@implementation HelperViewController

#pragma footerview

-(void)AddfooterView {
    
    UIView *FooterView = (UIView *)[self.view viewWithTag:654];
    UIView *FooterPanel=[[[NSBundle mainBundle] loadNibNamed:@"ExtendedDesign" owner:self options:Nil] objectAtIndex:0];
    
    NSLog(@"FooterPanel --- %@",FooterPanel);
    [FooterView addSubview:FooterPanel];
    
    UIView *AllAirportListView      = (UIView *)[FooterPanel viewWithTag:233];
    UIView *AllWaitListView         = (UIView *)[FooterPanel viewWithTag:234];
    UIView *AllReservationListView  = (UIView *)[FooterPanel viewWithTag:235];
    UIView *AllCouponsListView      = (UIView *)[FooterPanel viewWithTag:236];
    UIView *AllMoreListView         = (UIView *)[FooterPanel viewWithTag:237];
    //
    //    UIImageView *touchedImageView = (UIImageView *)[AllMoreListView viewWithTag:11];
    //    [touchedImageView setImage:[UIImage imageNamed:@"icon5ON.png"]];
    
    UITapGestureRecognizer *tapGesture0      =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture0 setNumberOfTapsRequired:1];
    [AllAirportListView addGestureRecognizer:tapGesture0];
    
    UITapGestureRecognizer *tapGesture1     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture1 setNumberOfTapsRequired:1];
    [AllWaitListView addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture2 setNumberOfTapsRequired:1];
    [AllReservationListView addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture3 setNumberOfTapsRequired:1];
    [AllCouponsListView addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4     =   [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegan:)];
    [tapGesture4 setNumberOfTapsRequired:1];
    [AllMoreListView addGestureRecognizer:tapGesture4];
}

-(void)touchBegan :(UITapGestureRecognizer *)Recognizer
{
    IMFAPPPRINTMETHOD();
    
    UIView *touchedView=(UIView *)[[Recognizer self] view];
    UIViewController *nextViewController;
//    
//    switch([touchedView tag])
//    {
//        case 233: nextViewController            =   [[ALAllRestaurantListViewController alloc] init];
//            break;
//        case 234: nextViewController            =   [[ALWaitlistViewController alloc] init];
//            break;
//        case 235: nextViewController            =   [[ALReservationsViewController alloc] init];
//            break;
//        case 236: nextViewController            =   [[ALCouponsViewController alloc] init];
//            break;
//        case 237: nextViewController            =   [[ALMoreViewController alloc] init];
//            break;
//            
//    }
    
    if(nextViewController)[self GotoDifferentViewWithAnimation:nextViewController];
}

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}

@end
