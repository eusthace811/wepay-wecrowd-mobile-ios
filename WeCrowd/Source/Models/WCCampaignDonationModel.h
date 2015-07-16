//
//  WCCampaignDonationModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Interface

@interface WCCampaignDonationModel : NSObject

/**
 * Since the donation model is stitched together, make properties mutable.
 */
@property (nonatomic, strong, readwrite) NSString *campaignID;
@property (nonatomic, strong, readwrite) NSString *donatorName;
@property (nonatomic, strong, readwrite) NSString *donatorEmail;
@property (nonatomic, strong, readwrite) NSString *creditCardID;
@property (nonatomic, strong, readwrite) NSString *amount;
@property (nonatomic, strong, readwrite) NSString *checkoutID;

- (instancetype) initWithCampaignID:(NSString *) campaignID
                        donatorName:(NSString *) donatorName
                       donatorEmail:(NSString *) donatorEmail
                       creditCardID:(NSString *) creditCardID
                             amount:(NSString *) amount;

@end
