//
//  WCClient.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/19/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCClient : NSObject

+ (void) loginWithUsername:(NSString *) username
                  password:(NSString *) password
           completionBlock:(void (^)(NSDictionary *userInfo, NSError *error)) completionBlock;

+ (void) fetchAllCampaigns:(void (^)(NSArray *campaigns, NSError *error)) completionBlock;

+ (void) fetchAllCampaignsForUser:(NSString *) userID
                        withToken:(NSString *) token
                  completionBlock:(void (^)(NSArray *campaigns, NSError *error)) completionBlock;

@end
