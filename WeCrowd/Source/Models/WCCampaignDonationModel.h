//
//  WCCampaignDonationModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCUserModel;


#pragma mark - Interface

@interface WCCampaignDonationModel : NSObject

@property (strong, nonatomic, readonly) WCUserModel* donator;
@property (strong, nonatomic, readonly) NSString* campaignID;
@property (strong, nonatomic, readonly) NSString* creditCardID;
@property (strong, nonatomic, readonly) NSString* donationAmount;

- (id) initWithDonator:(WCUserModel *) donator
            campaignID:(NSString *) campaignID
          creditCardID:(NSString *) creditCardID
        donationAmount:(NSString *) donationAmount;

@end
