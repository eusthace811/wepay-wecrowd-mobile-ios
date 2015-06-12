//
//  WCCampaignDonation.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCUser;


#pragma mark - Interface

@interface WCCampaignDonation : NSObject

@property (strong, nonatomic, readonly) WCUser* donator;
@property (strong, nonatomic, readonly) NSString* campaignID;
@property (strong, nonatomic, readonly) NSString* creditCardID;
@property (strong, nonatomic, readonly) NSString* donationAmount;

- (id) initWithDonator:(WCUser *) donator
            campaignID:(NSString *) campaignID
          creditCardID:(NSString *) creditCardID
        donationAmount:(NSString *) donationAmount;

@end
