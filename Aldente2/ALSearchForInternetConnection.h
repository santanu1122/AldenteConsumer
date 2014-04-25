//
//  ALSearchForInternetConnection.h
//  Aldente2
//
//  Created by Iphone_2 on 02/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALSearchForInternetConnection;

@protocol ALSearchForInternetConnectionDelegate <NSObject>

@required

-(void)SearchForInternetConnectionMethod;

@end

@interface ALSearchForInternetConnection : NSObject {
    __weak id <ALSearchForInternetConnectionDelegate> _delegate;
    NSTimer *RepeatTimer;
}
@property (nonatomic,weak) id <ALSearchForInternetConnectionDelegate> delegate;

-(void)SearchForINternetConnection;

@end
