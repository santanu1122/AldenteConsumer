//
//  URLRetrieveData.m
//  AlDenteConsumer
//
//  Created by Iphone_2 on 29/04/14.
//  Copyright (c) 2014 com.esolz.AlDenteConsumer. All rights reserved.
//

#import "URLRetrieveData.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import "AFNetworking.h"

NSString * fhs_url_remove_params(NSURL *url) {
    if (url.absoluteString.length == 0) {
        return nil;
    }
    
    NSArray *parts = [url.absoluteString componentsSeparatedByString:@"?"];
    return (parts.count == 0)?nil:parts[0];
}

id removeNull(id rootObject) {
    if ([rootObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:rootObject];
        [rootObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedDictionary setObject:@"" forKey:key];
            } else {
                [sanitizedDictionary setObject:sanitized forKey:key];
            }
        }];
        return [NSMutableDictionary dictionaryWithDictionary:sanitizedDictionary];
    }
    
    if ([rootObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:rootObject];
        [rootObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:@""];
            } else {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:sanitized];
            }
        }];
        return [NSMutableArray arrayWithArray:sanitizedArray];
    }
    
    if ([rootObject isKindOfClass:[NSNull class]]) {
        return (id)nil;
    } else {
        return rootObject;
    }
}

@interface URLRetrieveData () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) NSString *HTTPMethod;
@property (nonatomic, assign) float timeout;

@end

@implementation URLRetrieveData

+ (URLRetrieveData *)streamWithURL:(NSString *)url httpMethod:(NSString *)httpMethod parameters:(NSDictionary *)params timeout:(float)timeout block:(StreamBlock)block {
    return [[[self class]alloc]initWithURL:url httpMethod:httpMethod parameters:params timeout:timeout block:block];
}

- (instancetype)initWithURL:(NSString *)url httpMethod:(NSString *)httpMethod parameters:(NSDictionary *)params timeout:(float)timeout block:(StreamBlock)block {
    self = [super init];
    if (self) {
        self.timeout = timeout;
        self.URL = url;
        self.HTTPMethod = httpMethod;
        self.params = params.mutableCopy;
        _params[@"delimited"] = @"length";
        _params[@"stall_warnings"] = @"true";
        self.block = block;
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    BOOL stop = NO;
    _block(error, &stop);
    
    if (stop) {
        [self stop];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    int bytesExpected = 0;
    NSMutableString *message = nil;
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    for (NSString *part in [response componentsSeparatedByString:@"\r\n"]) {
        int length = [part intValue];
        
        if (length > 0) {
            message = [NSMutableString string];
            bytesExpected = length;
        } else if (bytesExpected > 0 && message) {
            if (message.length < bytesExpected) {
                [message appendString:part];
                
                if (message.length < bytesExpected) {
                    [message appendString:@"\r\n"];
                }
                
                if (message.length == bytesExpected) {
                    NSError *jsonError = nil;
                    id json = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
                    
                    BOOL stop = NO;
                    
                    if (!jsonError) {
                        _block(json, &stop);
                        [self keepAlive];
                    } else {
                        NSError *error = [NSError errorWithDomain:@"mainDomain" code:406 userInfo:@{ NSUnderlyingErrorKey: jsonError, NSLocalizedDescriptionKey: @"Invalid JSON was returned from Twitter", @"json": json }];
                        _block(error, &stop);
                    }
                    
                    if (stop) {
                        [self stop];
                    }
                    
                    message = nil;
                    bytesExpected = 0;
                }
            }
        } else {
            [self keepAlive];
        }
    }
}

- (void)keepAlive {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stop) object:nil];
}

- (void)stop {
    [_connection cancel];
    [_connection unscheduleFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.connection = nil;
}

- (void)start {
    
    id req = [self streamingRequestForURL:[NSURL URLWithString:_URL] HTTPMethod:_HTTPMethod parameters:_params];
    
    if (![req isKindOfClass:[NSURLRequest class]]) {
        if (_block) {
            _block(req, NULL);
        }
    } else {
        self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
    }
    [self performSelector:@selector(stop) withObject:nil afterDelay:_timeout];
}

- (NSString *)fhs_UUID {
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 6.0f) {
        return [[NSUUID UUID]UUIDString];
    } else {
        CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef string = CFUUIDCreateString(kCFAllocatorDefault, theUUID);
        CFRelease(theUUID);
        NSString *uuid = [NSString stringWithString:(__bridge NSString *)string];
        CFRelease(string);
        return uuid;
    }
}

- (NSData *)POSTBodyWithParams:(NSDictionary *)params boundary:(NSString *)boundary {
    NSMutableData *body = [NSMutableData dataWithLength:0];
    
    for (NSString *key in params.allKeys) {
        id obj = params[key];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *data = nil;
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([obj isKindOfClass:[NSData class]]) {
            [body appendData:[@"Content-Type: application/octet-stream\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            data = (NSData *)obj;
        } else if ([obj isKindOfClass:[NSString class]]) {
            data = [[NSString stringWithFormat:@"%@",(NSString *)obj]dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return body;
}

- (NSString *)fhs_URLEncode {
    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
	return (__bridge NSString *)url;
}

- (id)streamingRequestForURL:(NSURL *)url HTTPMethod:(NSString *)method parameters:(NSDictionary *)params {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:cachePolicy timeoutInterval:MAXFLOAT];
    [request setHTTPMethod:method];
    [request setHTTPShouldHandleCookies:NO];
    
    // Only POST and GET are relevant to the Twitter API
    
    if ([method isEqualToString:@"POST"]) {
        NSString *boundary = [self fhs_UUID];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSData *body = [self POSTBodyWithParams:params boundary:boundary];
        [request setValue:@(body.length).stringValue forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = body;
    } else if ([method isEqualToString:@"GET"]) {
        if (params.count > 0) {
            NSMutableArray *paramPairs = [NSMutableArray arrayWithCapacity:params.count];
            
            for (NSString *key in params) {
                NSString *paramPair = [NSString stringWithFormat:@"%@=%@",[self fhs_URLEncode],[params[key] fhs_URLEncode]];
                [paramPairs addObject:paramPair];
            }
            
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",fhs_url_remove_params(url), [paramPairs componentsJoinedByString:@"&"]]];
        }
    } else {
        return [NSError errorWithDomain:@"mainDomain" code:-400 userInfo:@{}];
    }
    return request;
}

@end
