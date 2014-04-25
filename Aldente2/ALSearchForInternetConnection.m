//
//  ALSearchForInternetConnection.m
//  Aldente2
//
//  Created by Iphone_2 on 02/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALSearchForInternetConnection.h"
#import "ALConstants.h"

@implementation ALSearchForInternetConnection

@synthesize delegate        = _delegate;

-(void)SearchForINternetConnection {
    
    RepeatTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(SearchAgainForInternetConnection) userInfo:nil repeats:YES];
}
-(void)SearchAgainForInternetConnection {
    
    if (ALConstants.IsConnectedToInternet) {
        
        [RepeatTimer invalidate];
        
    }
}
@end
