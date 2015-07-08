//
//  WCClient.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/19/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCClient.h"
#import "WCModelProcessor.h"
#import "WCConstants.h"
#import "WCCampaignDonationModel.h"
#import "WCUserModel.h"
#import "WCError.h"

#pragma mark - Constants

// Requests
static NSInteger const kTimeoutInterval = 5;
static NSString* const kHTTPRequestPost = @"POST";
static NSString* const kHTTPRequestGet  = @"GET";

// API
static NSString* const kAPIURLString = @"http://wecrowd.wepay.com/api";

#pragma mark - Implementation

@implementation WCClient

#pragma mark - External Methods

+ (void) loginWithUsername:(NSString *) username
                  password:(NSString *) password
           completionBlock:(void (^)(NSDictionary *userInfo, NSError *)) completionBlock
{
    [self makePostRequestToEndPoint:[self apiURLWithEndpoint:kAPIEndpointLogin]
                             values:@{ kAPIParameterEmail : username, kAPIParameterPassword : password }
                        accessToken:nil
                       successBlock:^(NSDictionary *returnData) {
                           // Check the status of the return data
                           if ([returnData objectForKey:kAPIParameterErrorCode]) {
                               NSError *APIError;
                               NSInteger errorCode;
                               
                               errorCode = [(NSString *) [returnData objectForKey:kAPIParameterErrorCode] integerValue];
                               
                               APIError = [WCError APIErrorWithDescription:@"API error for login."
                                                             serverMessage:[returnData objectForKey:kAPIParameterErrorMessage]
                                                                      code:errorCode];
                               
                               completionBlock(nil, APIError);
                               NSLog(@"Error: API: %@.", [returnData objectForKey:kAPIParameterErrorMessage]);
                           } else {
                               // No error code, so hand off the data
                               completionBlock(returnData, nil);
                           }
                       }
                       errorHandler:^(NSError *error) {
                           // This means there was either a connection error or a parse error
                           completionBlock(nil, error);
                       }
     ];
}

+ (void) donateWithDonation:(WCCampaignDonationModel *) donation
            completionBlock:(void (^)(NSString *checkoutID, NSError *)) completionBlock
{
    NSNumber *amount, *campaignID;
    
    amount = [NSNumber numberWithInteger:[donation.amount integerValue]];
    campaignID = [NSNumber numberWithInteger:[donation.campaignID integerValue]];
    
    NSDictionary *values = @{ kAPIParameterDonationID              : campaignID,
                              kAPIParameterDonationCreditCardToken : donation.creditCardID,
                              kAPIParameterDonationAmount          : amount };
    
     [self makePostRequestToEndPoint:[self apiURLWithEndpoint:kAPIEndpointDonate]
                              values:values
                         accessToken:nil
                        successBlock:^(id returnData) {
                            // Check for an API error
                            if ([returnData objectForKey:kAPIParameterErrorCode]) {
                                // TODO: create an actual error to hand off
                                completionBlock(nil, [NSError new]);
                                NSLog(@"Error: API: %@.", [returnData objectForKey:kAPIParameterErrorMessage]);
                            } else {
                                // No error code, so hand off the data
                                completionBlock(returnData, nil);
                            }
                        }
                        errorHandler:^(NSError *error) {
                            // This means there was either a connection error or a parse error
                            completionBlock(nil, error);
                            NSLog(@"Error: Client: Unable to complete donation.");
                        }];
}

+ (void) fetchAllCampaigns:(void (^)(NSArray *campaigns, NSError *error)) completionBlock
{
    [self makeGetRequestToEndpoint:[self apiURLWithEndpoint:kAPIEndpointCampaigns]
                            values:nil
                       accessToken:nil
                      successBlock:^(NSArray *returnData) {
                          completionBlock([WCModelProcessor createProcessedArrayForCampaigns:returnData], nil);
                      }
                      errorHandler:^(NSError *error) {
                          completionBlock(nil, error);
                      }];
}

+ (void) fetchAllCampaignsForUser:(NSString *) userID
                        withToken:(NSString *) token
                  completionBlock:(void (^)(NSArray *campaigns, NSError *error)) completionBlock
{
    [self makePostRequestToEndPoint:[self apiURLWithEndpoint:kAPIEndpointUsers]
                             values:@{ kAPIParameterUserID : userID, kAPIParameterUserToken : token }
                        accessToken:nil
                       successBlock:^(NSArray *returnData) {
                           NSLog(@"Success: Client: Fetched campaigns for user.");
                           completionBlock([WCModelProcessor createProcessedArrayForCampaigns:returnData], nil);
                       }
                       errorHandler:^(NSError *error) {
                           NSLog(@"Error: Client: failed to fetch user campaigns.");
                           completionBlock(nil, error);
                       }];
}

+ (void) fetchCampaignWithID:(NSString *) campaignID
             completionBlock:(void (^)(WCCampaignDetailModel *campaign, NSError *error)) completionBlock
{
    [self makePostRequestToEndPoint:[self apiURLWithEndpoint:kAPIEndpointCampaigns]
                             values:@{ kAPIParameterCampaignID : campaignID }
                        accessToken:nil
                       successBlock:^(id returnData) {
                           NSLog(@"Success: Client: Fetched campaign.");
                           completionBlock([WCModelProcessor createCampaignDetailFromDictionary:returnData], nil);
                       }
                       errorHandler:^(NSError *error) {
                           NSLog(@"API error: Unable to fetch campaign.");
                           completionBlock(nil, error);
                       }];
}

#pragma mark - Endpoint Requests

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

#pragma mark - Helpers

+ (void) createDefaultRequestWithURL:(NSURL *) URL
                              method:(NSString *) method
                            bodyData:(id) bodyData
                         accessToken:(NSString *) accessToken
                     completionBlock:(void (^)(NSMutableURLRequest *returnRequest, NSError * error)) completion
{
    NSError *parseError = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kTimeoutInterval];
    // Configure the  request
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    
    // Set the access token if it exists
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

+ (NSURL *) apiURLWithEndpoint:(NSString *) endpoint {
    return [NSURL URLWithString:[kAPIURLString stringByAppendingString:endpoint]];
}

#pragma mark - Data Processing

+ (void) processResponse:(NSURLResponse *) response
                    data:(NSData *) data
                   error:(NSError *) error
            successBlock:(void (^)(id returnData)) successHandler
            errorHandler:(void (^)(NSError* error)) errorHandler
{
    NSError *extractionError;
    
    // Build a structure from the raw data
    id extractedData = nil;
    
    if ([data length] > 0) {
        extractedData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:&extractionError];
    }
    
    if (extractedData && !error) {
        // Safely retrieve the status code since there were no errors and the data is valid
        NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
        
        // Check the status code. 200 means success
        if (statusCode == 200) {
            successHandler(extractedData);
        } else {
            NSDictionary *userInfo;
            NSString *description;
            
            description = [NSString stringWithFormat:@"Error processing request %@.", response.URL.path];
            userInfo =  @{ NSLocalizedDescriptionKey : NSLocalizedString(description, nil) };
            
            errorHandler([NSError errorWithDomain:NSURLErrorDomain
                                             code:statusCode
                                         userInfo:userInfo]);
        }
    } else if (error) {
        errorHandler(error);
        NSLog(@"Error: Client: %@.", [error localizedDescription]);
    } else if (extractionError) {
        errorHandler(extractionError);
        NSLog(@"Error: Client: %@.", [extractionError localizedDescription]);
    }
}

@end
