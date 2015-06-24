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
static NSString* const kHTTPRequestGet  = @"GET";

#pragma mark - Implementation

@implementation WCClient

#pragma mark External Methods

+ (void) loginWithUsername:(NSString *) username
                  password:(NSString *) password
           completionBlock:(void (^)(NSError *)) completionBlock
{
    [self makePostRequestToEndPoint:[WCClient apiURLWithEndpoint:@"/login"]
                             values:@ { @"user_email" : username, @"password" : password }
                            accessToken:nil
                           successBlock:^(NSDictionary *returnData) {
                               // check the status of the return data
                               if ([returnData objectForKey:@"error_code"]) {
                                   // TODO: create an actual error to hand off
                                   completionBlock(nil);
                               } else {
                                   completionBlock(nil);
                               }
                           }
                           errorHandler:^(NSError *error) {
                               // This means there was either a connection error or a parse error
                               // TODO: create an actual error to hand off
                               completionBlock(nil);
                           }
     ];
}

+ (void) makeGetRequestToEndpoint:(NSURL *) endpoint
                           values:(NSDictionary *) values
                      accessToken:(NSString *) accessToken
                     successBlock:(void (^)(id returnData)) successHandler
                     errorHandler:(void (^)(NSError *)) errorHandler
{
    [self makeRequestToEndPoint:endpoint
                         method:kHTTPRequestGet
                         values:values
                    accessToken:accessToken
                   successBlock:successHandler
                   errorHandler:errorHandler];
}

+ (NSURL *) apiURLWithEndpoint:(NSString *) endpoint {
    return [NSURL URLWithString:[kAPIURLString stringByAppendingString:endpoint]];
}

#pragma mark - Internal Methods

+ (void) makePostRequestToEndPoint:(NSURL *) endpoint
                            values:(NSDictionary *) params
                       accessToken:(NSString *) accessToken
                      successBlock:(void (^)(id returnData)) successHandler
                      errorHandler:(void (^)(NSError * error)) errorHandler
{
    [self makeRequestToEndPoint:endpoint
                         method:kHTTPRequestPost
                         values:params
                    accessToken:accessToken
                   successBlock:successHandler
                   errorHandler:errorHandler];
}

+ (void) makeRequestToEndPoint:(NSURL *) endpoint
                        method:(NSString *) method
                        values:(NSDictionary *) params
                   accessToken:(NSString *) accessToken
                  successBlock:(void (^)(id returnData)) successHandler
                  errorHandler:(void (^)(NSError * error)) errorHandler
{
    [self createDefaultRequestWithURL:endpoint
                               method:method
                             bodyData:params
                          accessToken:accessToken
                      completionBlock:^(NSMutableURLRequest *returnRequest, NSError *error) {
                          if (error) {
                              // Encountered a parse error while creating the request
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
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    
    // Set the access token if it exists
    // (Not super sure what this does since the cases I've seen have all been nil)
    if (accessToken) {
        [request setValue:[NSString stringWithFormat:@"bearer %@", accessToken]
       forHTTPHeaderField:@"Authorization"];
    }
    
    // Set the body data if there is any
    if (bodyData) {
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:bodyData
                                                             options:kNilOptions
                                                               error:&parseError]];
    }
    
    if (parseError) {
        completion(nil, parseError);
    } else {
        completion(request, nil);
    }
}

+ (void) processResponse:(NSURLResponse *) response
                    data:(NSData *) data
                   error:(NSError *) error
            successBlock:(void (^)(id returnData)) successHandler
            errorHandler:(void (^)(NSError* error)) errorHandler
{
    // Build a dictionary from the raw data
    id extractedData = nil;
    
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
            // TODO: There was a connection error
        }
    } else if (error) {
        // TODO: There was a connection error with the request
        errorHandler(error);
    } else if (!extractedData) {
        // TODO: There was an error in the data extracted from the request
    }
}

@end
