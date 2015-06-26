//
//  WCLoginManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCLoginManager.h"
#import "WCClient.h"
#import "WCConstants.h"

@interface WCLoginManager ()

@end

@implementation WCLoginManager

// Static logged-in user member
static WCUser *user = nil;
+ (WCUser *) currentUser { return user; }

+ (void) loginUserWithUsername:(NSString *) username
                      password:(NSString *) password
               completionBlock:(void (^)(NSError *)) completionBlock
{
    [WCClient loginWithUsername:username
                       password:password
                completionBlock:^(NSDictionary *userInfo, NSError *error) {
                    if (!error) {
                        // Allocate memory if user instance has not been created
                        if (!user) {
                            user = [WCUser new];
                        }
                        
                        [user setUserID:[userInfo objectForKey:kAPIParameterUserID]
                                  email:username
                                  token:[userInfo objectForKey:kAPIParameterUserToken]];
                    }
                    
                    completionBlock (error);
                }];
}

+ (void) logoutWithCompletionBlock:(void (^)(NSError *)) completionBlock
{
    // No API call for logging out, so just set the current user to nil
    user = nil;
    
    completionBlock(nil);
}

@end
