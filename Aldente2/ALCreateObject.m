//
//  ALCreateObject.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 07/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALCreateObject.h"

@implementation ALCreateObjectForData

@synthesize ALLogedInUserId,ALLogedInUserName,ALLogedInUserEmail,ALLogedInUserPhone,ALLogedInUserPassword,ALLogedInUserfbconnectId,ALLogedInUsertwitterId,ALLogedInUserregister_date,ALLogedInUserlastlogin_date,ALLogedInUserdevicetoken,ALLogedInUserstatus,ALUserIsLogedIn;

@synthesize ResturantId,ResturantAddress,ResturantCity,ResturantEmail,ResturantLogo,ResturantName,ResturantPhoneNo,ResturantState,ResturantZip,ResturantDistance,ResturantAverageWaitTime;

@synthesize ReservationId,PartySize,RestaurantownerId,Quotedtime,Notedata,AheadOfMe;

-(id)initWithLogedinUserId:(NSString *)ParamLogedinUserId LogedInUserName:(NSString *)ParamLogedInUserName LogedInUserEmail:(NSString *)ParamLogedInUserEmail LogedInUserPhone:(NSString *)ParamLogedInUserPhone LogedInUserPassword:(NSString *)ParamLogedInUserPassword LogedInUserfbconnectId:(NSString *)ParamLogedInUserfbconnectId LogedInUsertwitterId:(NSString *)ParamLogedInUsertwitterId LogedInUserregister_date:(NSString *)ParamLogedInUserregister_date LogedInUserlastlogin_date:(NSString *)ParamLogedInUserlastlogin_date LogedInUserdevicetoken:(NSString *)ParamLogedInUserdevicetoken LogedInUserstatus:(NSString *)ParamLogedInUserstatus ALUserIsLogedIn:(BOOL)ParamALUserIsLogedIn
{
    self = [super init];
    if (self) {
        
        [self setALLogedInUserId:ParamLogedinUserId];
        [self setALLogedInUserName:ParamLogedinUserId];
        [self setALLogedInUserEmail:ParamLogedinUserId];
        [self setALLogedInUserPhone:ParamLogedinUserId];
        [self setALLogedInUserPassword:ParamLogedinUserId];
        [self setALLogedInUserfbconnectId:ParamLogedinUserId];
        [self setALLogedInUsertwitterId:ParamLogedinUserId];
        [self setALLogedInUserregister_date:ParamLogedinUserId];
        [self setALLogedInUserlastlogin_date:ParamLogedinUserId];
        [self setALLogedInUserdevicetoken:ParamLogedinUserId];
        [self setALLogedInUserstatus:ParamLogedinUserId];
        [self setALUserIsLogedIn:ParamALUserIsLogedIn];
        
    }
    return self;
}

-(id)initWithResturantId:(NSString *)ParamResturantId ResturantAddress:(NSString *)ParamResturantAddress ResturantCity:(NSString *)ParamResturantCity ResturantEmail:(NSString *)ParamResturantEmail ResturantLogo:(NSString *)ParamResturantLogo ResturantName:(NSString *)ParamResturantName ResturantPhoneNo:(NSString *)ParamResturantPhoneNo ResturantState:(NSString *)ParamResturantState ResturantZip:(NSString *)ParamResturantZip ResturantDistance:(NSString *)ParamResturantDistance ResturantAverageWaitTime:(NSString *)ParamResturantAverageWaitTime
{
    self = [super init];
    if (self) {
        
        [self setResturantId:ParamResturantId];
        [self setResturantAddress:ParamResturantAddress];
        [self setResturantCity:ParamResturantCity];
        [self setResturantEmail:ParamResturantEmail];
        [self setResturantLogo:ParamResturantLogo];
        [self setResturantName:ParamResturantName];
        [self setResturantPhoneNo:ParamResturantPhoneNo];
        [self setResturantState:ParamResturantState];
        [self setResturantZip:ParamResturantZip];
        [self setResturantDistance:ParamResturantDistance];
        [self setResturantAverageWaitTime:ParamResturantAverageWaitTime];
    }
    return self;
}

-(id)initWithReservationId:(NSString *)ParamReservationId PartySize:(NSString *)ParamPartySize RestaurantownerId:(NSString *)ParamRestaurantownerId Quotedtime:(NSString *)ParamQuotedtime Notedata:(NSString *)ParamNotedata AheadOfMe:(NSString *)ParamAheadOfMe {
    
    
    self = [super init];
    if (self) {
        
        [self setReservationId:ParamReservationId];
        [self setPartySize:ParamPartySize];
        [self setRestaurantownerId:ParamRestaurantownerId];
        [self setQuotedtime:ParamQuotedtime];
        [self setNotedata:ParamNotedata];
        [self setAheadOfMe:ParamAheadOfMe];
    }
    return self;
}

@end
