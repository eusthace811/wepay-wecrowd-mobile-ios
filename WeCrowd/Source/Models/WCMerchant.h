//
//  WCMerchant.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCUser.h"


#pragma mark - Interface

@interface WCMerchant : WCUser

// array of campaign IDs
@property (strong, nonatomic, readonly) NSArray* campaigns;

- (id) initWithUserID:(NSString *) userID
                email:(NSString *) email
                token:(NSString *) token
            campaigns:(NSArray *) campaigns;

@end
