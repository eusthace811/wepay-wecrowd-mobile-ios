//
//  WCLoginManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCLoginManager.h"
#import "WCClient.h"
#import "WCUser.h"

@interface WCLoginManager ()

@end

@implementation WCLoginManager

+ (WCUser *) currentUser
{
    // This line will only be executed once because it is a static declaration
    static WCUser *user = nil;
    
    if (!user) {
        user = [WCUser new];
    }
    
    return user;
}

+ (void) loginUserWithUsername:(NSString *) username
                      password:(NSString *) password
               completionBlock:(void (^)(NSError *)) completionBlock
{
    [WCClient loginWithUsername:username
                       password:password
                completionBlock:^(NSDictionary *userInfo, NSError *error) {
                    if (!error) {
                    }
                    
                    completionBlock (error);
                }];
}

@end
