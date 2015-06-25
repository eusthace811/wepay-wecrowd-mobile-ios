//
//  WCMerchant.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCMerchant.h"

#pragma mark - Interface

@interface WCMerchant ()

@property (strong, nonatomic, readwrite) NSArray* campaigns;

@end


#pragma mark - Implementation

@implementation WCMerchant

#pragma mark - Initialization

- (id) initWithUserID:(NSString *) userID
                email:(NSString *) email
                token:(NSString *) token
            campaigns:(NSArray *) campaigns
{
    if (self = [super initWithUserID:userID
                               email:email
                               token:token])
    {
        self.campaigns = campaigns;
    } else {
        // unable to initialize objects
    }
    
    return self;
}

@end
