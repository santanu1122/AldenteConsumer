//
//  ALUserLocation.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 25/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUserLocation : NSObject

+ (ALUserLocation *)sharedCenter;   // class method to return the singleton object

- (void)customMethod; // add optional methods to customize the singleton class

@end
