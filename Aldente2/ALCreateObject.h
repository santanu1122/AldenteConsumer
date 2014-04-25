//
//  ALCreateObject.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 07/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCreateObjectForData : NSObject

@property (nonatomic,retain) NSString *ALLogedInUserId;
@property (nonatomic,retain) NSString *ALLogedInUserName;
@property (nonatomic,retain) NSString *ALLogedInUserEmail;
@property (nonatomic,retain) NSString *ALLogedInUserPhone;
@property (nonatomic,retain) NSString *ALLogedInUserPassword;
@property (nonatomic,retain) NSString *ALLogedInUserfbconnectId;
@property (nonatomic,retain) NSString *ALLogedInUsertwitterId;
@property (nonatomic,retain) NSString *ALLogedInUserregister_date;
@property (nonatomic,retain) NSString *ALLogedInUserlastlogin_date;
@property (nonatomic,retain) NSString *ALLogedInUserdevicetoken;
@property (nonatomic,retain) NSString *ALLogedInUserstatus;
@property (assign) bool ALUserIsLogedIn;


// Restaurant Listing

@property (nonatomic,retain) NSString *ResturantId;
@property (nonatomic,retain) NSString *ResturantName;
@property (nonatomic,retain) NSString *ResturantLogo;
@property (nonatomic,retain) NSString *ResturantEmail;
@property (nonatomic,retain) NSString *ResturantPhoneNo;
@property (nonatomic,retain) NSString *ResturantState;
@property (nonatomic,retain) NSString *ResturantCity;
@property (nonatomic,retain) NSString *ResturantZip;
@property (nonatomic,retain) NSString *ResturantAddress;
@property (nonatomic,retain) NSString *ResturantDistance;
@property (nonatomic,retain) NSString *ResturantAverageWaitTime;

-(id)initWithLogedinUserId:(NSString *)ParamLogedinUserId LogedInUserName:(NSString *)ParamLogedInUserName LogedInUserEmail:(NSString *)ParamLogedInUserEmail LogedInUserPhone:(NSString *)ParamLogedInUserPhone LogedInUserPassword:(NSString *)ParamLogedInUserPassword LogedInUserfbconnectId:(NSString *)ParamLogedInUserfbconnectId LogedInUsertwitterId:(NSString *)ParamLogedInUsertwitterId LogedInUserregister_date:(NSString *)ParamLogedInUserregister_date LogedInUserlastlogin_date:(NSString *)ParamLogedInUserlastlogin_date LogedInUserdevicetoken:(NSString *)ParamLogedInUserdevicetoken LogedInUserstatus:(NSString *)ParamLogedInUserstatus ALUserIsLogedIn:(BOOL)ParamALUserIsLogedIn;


-(id)initWithResturantId:(NSString *)ParamResturantId ResturantAddress:(NSString *)ParamResturantAddress ResturantCity:(NSString *)ParamResturantCity ResturantEmail:(NSString *)ParamResturantEmail ResturantLogo:(NSString *)ParamResturantLogo ResturantName:(NSString *)ParamResturantName ResturantPhoneNo:(NSString *)ParamResturantPhoneNo ResturantState:(NSString *)ParamResturantState ResturantZip:(NSString *)ParamResturantZip ResturantDistance:(NSString *)ParamResturantDistance ResturantAverageWaitTime:(NSString *)ParamResturantAverageWaitTime;

@end
