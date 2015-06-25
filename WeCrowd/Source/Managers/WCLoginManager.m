//
//  WCLoginManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCUser;

@interface WCLoginManager : NSObject

// Static declaration of the logged-in user
+ (WCUser *) currentUser;

+ (void) loginUserWithUsername:(NSString *) username
                      password:(NSString *) password
               completionBlock:(void (^)(NSError *error)) completionBlock;

@end
