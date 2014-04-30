//
//  URLRetrieveData.h
//  AlDenteConsumer
//
//  Created by Iphone_2 on 29/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StreamBlock)(id result, BOOL *stop);

static NSURLRequestCachePolicy const cachePolicy = NSURLRequestReloadRevalidatingCacheData;

@class URLRetrieveData;

@protocol URLRetrieveDataDelegate <NSObject>

@required

- (void)HnadleNsUrlConnection:(URLRetrieveData *)myObj json:(NSDictionary *)json;
- (void)HnadleNsUrlConnectionErr:(URLRetrieveData *)myObj Errdata:(NSError *)Errdata;

@end

@interface URLRetrieveData : NSObject {
    
    __weak id <URLRetrieveDataDelegate> _delegate;
}
@property (nonatomic, copy) StreamBlock block;
@property (nonatomic, weak) id <URLRetrieveDataDelegate> delegate;

+ (URLRetrieveData *)streamWithURL:(NSString *)url httpMethod:(NSString *)httpMethod parameters:(NSDictionary *)params timeout:(float)timeout block:(StreamBlock)block;

- (void)stop;
- (void)start;

@end
