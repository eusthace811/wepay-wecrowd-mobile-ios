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

#pragma mark - Static Members

static WCUserModel *user = nil;
static WCLoginUserType userType = WCLoginUserPayer;

#pragma mark - Interface Methods

+ (void) loginMerchantWithUsername:(NSString *) username
                          password:(NSString *) password
                   completionBlock:(void (^)(NSError *)) completionBlock
{
    [self loginUserWithUsername:username
                       password:password
                completionBlock:^(NSError *error) {
                    if (!error) {
                        userType = WCLoginUserMerchant;
                    }
                    
                    completionBlock(error);
                }];
}

+ (WCUserModel *) currentUser { return user; }
+ (WCLoginUserType) userType { return userType; }

#pragma mark - Helper Methods

+ (void) loginUserWithUsername:(NSString *) username
                      password:(NSString *) password
               completionBlock:(void (^)(NSError *)) completionBlock
{
    [WCClient loginWithUsername:username
                       password:password
                completionBlock:^(NSDictionary *userInfo, NSError *error) {
                    // TODO: Perform proper error checking
                    if (!error) {
                        // Allocate memory if user instance has not been created
                        if (!user) {
                            user = [WCUserModel new];
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
    userType = WCLoginUserPayer;
    
    completionBlock(nil);
}

@end
