//
//  WCCampaignDonation.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignDonation.h"


#pragma mark - Interface

@interface WCCampaignDonation ()

@property (strong, nonatomic, readwrite) WCUser* donator;
@property (strong, nonatomic, readwrite) NSString* campaignID;
@property (strong, nonatomic, readwrite) NSString* creditCardID;
@property (strong, nonatomic, readwrite) NSString* donationAmount;

@end


#pragma mark - Implementation

@implementation WCCampaignDonation

#pragma mark - Initialization

- (id) initWithDonator:(WCUser *) donator
            campaignID:(NSString *) campaignID
          creditCardID:(NSString *) creditCardID
        donationAmount:(NSString *) donationAmount
{
    if (self = [super init]) {
        self.donator = donator;
        self.campaignID = campaignID;
        self.creditCardID = creditCardID;
        self.donationAmount = donationAmount;
    } else {
        // unable to initialize objects
    }
    
    return self;
}

@end
