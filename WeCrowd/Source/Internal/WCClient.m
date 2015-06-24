//
//  WCClient.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/19/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCClient.h"


// Requests
static NSInteger const kTimeoutInterval = 5;
static NSString* const kAPIURLString    = @"http://0.0.0.0:3000/api";
static NSString* const kHTTPRequestPost = @"POST";

#pragma mark - Implementation

@implementation WCClient

#pragma mark External Methods

+ (void) makePostRequestToEndPoint:(NSURL *) endpoint
                            values:(NSDictionary *) params
                       accessToken:(NSString *) accessToken
                      successBlock:(void (^)(NSDictionary * returnData)) successHandler
                      errorHandler:(void (^)(NSError * error)) errorHandler
{
    [self makeRequestToEndPoint:endpoint
                         method:kHTTPRequestPost
                         values:params
                    accessToken:accessToken
                   successBlock:successHandler
                   errorHandler:errorHandler];
}

+ (NSURL *) apiURLWithEndpoint:(NSString *) endpoint {
    return [NSURL URLWithString:[kAPIURLString stringByAppendingString:endpoint]];
}

#pragma mark - Internal Methods

+ (void) makeRequestToEndPoint:(NSURL *) endpoint
                        method:(NSString *) method
                        values:(NSDictionary *) params
                   accessToken:(NSString *) accessToken
                  successBlock:(void (^)(NSDictionary * returnData)) successHandler
                  errorHandler:(void (^)(NSError * error)) errorHandler
{
    [self createDefaultRequestWithURL:endpoint
                               method:method
                             bodyData:params
                          accessToken:accessToken
                      completionBlock:^(NSMutableURLRequest *returnRequest, NSError *error) {
                          if (error) {
                              errorHandler(error);
                          } else {
                              // Request was successfully created
                              NSOperationQueue* queue = [NSOperationQueue mainQueue];
                              
                              // Send the request asynchronously and process the response
                              [NSURLConnection sendAsynchronousRequest:returnRequest
                                                                 queue:queue
                                                     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                                         // Process the server's response
                                                         [self processResponse:response
                                                                          data:data
                                                                         error:connectionError
                                                                  successBlock:successHandler
                                                                  errorHandler:errorHandler];
                                                     }];
                          }
                      }
     ];
}

+ (void) createDefaultRequestWithURL:(NSURL *) URL
                              method:(NSString *) method
                            bodyData:(id) bodyData
                         accessToken:(NSString *) accessToken
                     completionBlock:(void (^)(NSMutableURLRequest *returnRequest, NSError * error)) completion
{
    NSError* parseError = nil;
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kTimeoutInterval];
    // Configure the  request
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"charset" forHTTPHeaderField:@"utf-8"];
    [request setValue:@"WeCrowd iOS" forHTTPHeaderField:@"User-Agent"];
    
    // Set access token (Not super sure what this does since the cases I've seen have all been nil)
    if (accessToken) {
        [request setValue:[NSString stringWithFormat:@"Bearer: %@", accessToken]
       forHTTPHeaderField:@"Authorization"];
    }
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:bodyData
                                                         options:kNilOptions
                                                           error:&parseError]];
    
    if (parseError) {
        completion(nil, parseError);
    } else {
        completion(request, nil);
    }
}

+ (void) processResponse:(NSURLResponse *) response
                    data:(NSData *) data
                   error:(NSError *) error
            successBlock:(void (^)(NSDictionary* returnData)) successHandler
            errorHandler:(void (^)(NSError* error))  errorHandler
{
    // Build a dictionary from the raw data
    NSDictionary* extractedData = nil;
    
    if ([data length] >= 1) {
        extractedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
    if (extractedData && !error) {
        // Safely retrieve the status code since there were no errors and the data is valid
        NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
        
        // Check the status code. 200 means success
        if (statusCode == 200) {
            successHandler(extractedData);
        } else {
            NSLog(@"Error: response carrying status code %ld.", statusCode);
        }
    } else if (error) {
        errorHandler(error);
    } else if (!extractedData) {
        NSLog(@"Error: data extraction failed.");
    }
}

@end
