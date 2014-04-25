//
//  ALConstants.m
//  Aldente2
//
//  Created by Iphone_2 on 01/04/14.
//  Copyright (c) 2014 com.esolz.Aldente2. All rights reserved.
//

#import "ALConstants.h"
#import "ALAppServices.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>

@implementation ALConstants

static NSNumber *_ScreenOfPlatform4m;

+ (CGSize) ScreenBoundsForPlatform4m {
    
    return CGSizeMake(320, 480);
}

+ (BOOL) ScreenOfPlatform4m {
    
    return YES;
}

+ (BOOL) ScreenOfPlatform5e {
    
    return YES;
}

+(NSString*) FacebookApplicationId {
    
    return ALAppServices.FaceBookApplicationId;
}

+(NSString*) AppApiUrl {
    
    return ALAppServices.AFApiUrl;
}

+ (BOOL) DeviceIsIphoneFive {
    
    return ([[UIScreen mainScreen] bounds].size.height > 500.0f)?YES:NO;
    
}

+ (BOOL) IsConnectedToInternet {
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    
    if (reachability) {
        SCNetworkReachabilityFlags flags;
        BOOL worked = SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
        
        if (worked) {
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                return YES;
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                return YES;
            }
        }
        
    }
    return NO;
}

+(NSString*) LastExecutedMethod {
    
    return [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__];
}

+(BOOL) ShowLastExecutedMethod {
    
    return (DEBUGMODE)?YES:NO;
}

-(BOOL)ValidateTextField:(NSString *)TextFieldValue {
    return YES;
}

-(NSString *)CleanTextField:(NSString *)TextfieldName
{
    NSString *Cleanvalue = [TextfieldName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}

-(BOOL)ValidateEmail:(NSString *)EmailValue
{
    IMFAPPPRINTMETHOD();
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSString* CleanEmailValue = [self CleanTextField:EmailValue];
    return [emailTest evaluateWithObject:CleanEmailValue];
}

-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue
{
    IMFAPPPRINTMETHOD();
    
    NSCharacterSet *ALLOWEDCHARATERSET =[[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSString *Cleanvalue = [self CleanTextField:DataValue];
    if ([Cleanvalue rangeOfCharacterFromSet:ALLOWEDCHARATERSET].location != NSNotFound)
        return NO;
    else
        return YES;
}

-(NSDictionary *)executeFetch:(NSString *)query
{
    IMFAPPPRINTMETHOD();
    
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    return results;
}

-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray {
    
    IMFAPPPRINTMETHOD();
    
    @try {
        
        NSMutableDictionary *ParamDictionary = [[NSMutableDictionary alloc] initWithCapacity:(NSUInteger)FieldArray.count];
        if ((NSUInteger)ParamArray.count > 0) {
            if((NSUInteger)FieldArray.count >0) {
                for (int i = 0; i<(NSUInteger)ParamArray.count; i++) {
                    [ParamDictionary setObject:[FieldArray objectAtIndex:i] forKey:[ParamArray objectAtIndex:i]];
                }
            } else {
                NSLog(@"Field data is blank");
            }
        } else {
            NSLog(@"Param object is blank");
        }
        return ParamDictionary;
    }
    @catch (NSException *Exception) {
        NSLog(@"Err in ParamDictionary %@",Exception);
    }
}

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType
{
    
    IMFAPPPRINTMETHOD();
    
    NSMutableString *URLstring = [[NSMutableString alloc]init];
    
    int i=0;
    for (id key in TotalData) {
        
        i++;
        id anObject = [TotalData objectForKey:key];
        if(i==TotalData.count)
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        else
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@&",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSString *FinalString = [NSString stringWithFormat:@"%@%@?%@",ALAppServices.AFApiUrl,UrlType,URLstring];
    return FinalString;
    
}

-(BOOL)validatePhone:(NSString*)phone {
    
    IMFAPPPRINTMETHOD();
    
    if ([phone length] < 10) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![test evaluateWithObject:phone];
}
- (NSString *) stripTags:(NSString *)s
{
    
    IMFAPPPRINTMETHOD();
    
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
