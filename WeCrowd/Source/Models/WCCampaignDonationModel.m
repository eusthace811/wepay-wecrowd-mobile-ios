//
//  WCCampaignDonationModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignDonationModel.h"


#pragma mark - Interface

@interface WCCampaignDonationModel ()

@property (strong, nonatomic, readwrite) WCUserModel* donator;
@property (strong, nonatomic, readwrite) NSString* campaignID;
@property (strong, nonatomic, readwrite) NSString* creditCardID;
@property (strong, nonatomic, readwrite) NSString* amount;

@end


#pragma mark - Implementation

@implementation WCCampaignDonationModel

#pragma mark - Initialization

- (instancetype) initWithDonator:(WCUserModel *) donator
                      campaignID:(NSString *) campaignID
                    creditCardID:(NSString *) creditCardID
                  donationAmount:(NSString *) amount
{
    if (self = [super init]) {
        self.donator = donator;
        self.campaignID = campaignID;
        self.creditCardID = creditCardID;
        self.amount = amount;
    } else {
        // Do nothing
    }
    
    return self;
}

@end
