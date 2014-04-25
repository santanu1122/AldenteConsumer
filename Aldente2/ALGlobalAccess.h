//
//  ALGlobalAccess.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 07/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALGlobalAccess : NSObject

-(void)RegisterDeviceForRemoteNotification;

-(void)SetUserDeviceToken :(NSString *)ALLogedInUserdevicetoken;

-(UITextField *)GenerateTextFieldForAcess :(int)TextfieldTagValue Delegate:(id)Delegate TextFiledtextColor:(UIColor *)TextFiledtextColor TextFieldsetFontSize:(float)TextFieldsetFontSize TextFieldFont:(NSString *)TextFieldFont GlobalView:(UIView *)GlobalView PlaceholderText:(NSString *)PlaceholderText;

-(void)GenerateUIlabelForAcess :(int)UilabelTagValue Delegate:(id)Delegate UilabeltextColor:(UIColor *)UilabeltextColor UilabelsetFontSize:(float)UilabelsetFontSize UilabelFont:(NSString *)UilabelFont GlobalView:(UIView *)GlobalView UilabelText:(NSString *)UilabelText UilabelTextAlignment:(NSTextAlignment *)UilabelTextAlignment;

-(UIScrollView *)GenerateUIScrollForAcess :(int)UiscrollviewTagVal GlobalView:(UIView *)GlobalView Delegate:(id)Delegate ScrollEnabled:(BOOL)ScrollEnabled userInteractionEnabled:(BOOL)userInteractionEnabled showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator SCrollBackgroundColor:(UIColor *)SCrollBackgroundColor ScrollviewExtraWidth:(float)ScrollviewExtraWidth ScrollViewExtraHeight:(float)ScrollViewExtraHeight;

@end


@interface HelperViewController : UIViewController

-(void)AddfooterView;
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName;

@end