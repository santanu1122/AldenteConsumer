//
//  ALUserLocation.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 25/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "ALUserLocation.h"

@implementation ALUserLocation

static ALUserLocation *sharedALUserLocation = nil;    // static instance variable

+ (ALUserLocation *)sharedCenter {
    if (sharedALUserLocation == nil) {
        sharedALUserLocation = [[super allocWithZone:NULL] init];
    }
    return sharedALUserLocation;
}

- (id)init {
    if ( (self = [super init]) ) {
    }
    return self;
}

- (void)customMethod {
    
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedCenter];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
