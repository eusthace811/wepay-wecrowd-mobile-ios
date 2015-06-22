//
//  WCClient.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/19/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCClient.h"

#pragma mark - Interface


@interface WCClient ()



@end

#pragma mark - Implementation

@implementation WCClient

+ (void) makePostRequestToEndPoint:(NSURL *) endpoint
                           values:(NSDictionary *) params
                      accessToken:(NSString *) accessToken
                     successBlock:(void (^)(NSDictionary * returnData)) successHandler
                     errorHandler:(void (^)(NSError * error)) errorHandler
{
    NSError* parseError = nil;
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.50.105:3000/api/login"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:5];
    NSDictionary* testParams = @{ @"user_email" : @"conehead@brainsnotpeople.com",
                                  @"password"   : @"brains"};
    
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    [request setValue: @"WeCrowd iOS" forHTTPHeaderField:@"User-Agent"];
    
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:testParams
                                                         options:kNilOptions
                                                           error:&parseError]];
    
    if (parseError) {
        errorHandler(parseError);
    } else {
        NSLog(@"Header fields: %@", [request allHTTPHeaderFields]);
        NSLog(@"Body : %@", [request HTTPBody]);
        
        NSOperationQueue* queue = [NSOperationQueue mainQueue];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   // Process the server's response
                                   if (connectionError) {
                                       errorHandler(connectionError);
                                   } else {
                                       successHandler(nil);
                                   }
                               }];
    }
}

@end
