//
//  WCLoginManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCUserModel.h"

@interface WCLoginManager : NSObject

/**
 * Define the user types
 */
typedef NS_ENUM(NSUInteger, WCLoginUserType) {
    WCLoginUserPayer    = 0,
    WCLoginUserMerchant = 1
};

+ (void) loginMerchantWithUsername:(NSString *) username
                          password:(NSString *) password
                   completionBlock:(void (^)(NSError *error)) completionBlock;


+ (void) logoutWithCompletionBlock:(void (^)(NSError *error)) completionBlock;

+ (WCUserModel *) currentUser;
+ (WCLoginUserType) userType;

@end
