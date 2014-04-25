//
//  ALGlobalViewController.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 21/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALGlobalViewController : UIViewController

-(void)AddfooterView ;
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName;
- (void)startSpin;
- (void)stopSpin;
-(NSString *)GetLoginUserId;
@end
