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
@property (strong, nonatomic, readwrite) NSString *campaignID;
@property (strong, nonatomic, readwrite) NSString *donatorName;
@property (strong, nonatomic, readwrite) NSString *donatorEmail;
@property (strong, nonatomic, readwrite) NSString *creditCardID;
@property (strong, nonatomic, readwrite) NSString *amount;

- (instancetype) initWithCampaignID:(NSString *) campaignID
                        donatorName:(NSString *) donatorName
                       donatorEmail:(NSString *) donatorEmail
                       creditCardID:(NSString *) creditCardID
                             amount:(NSString *) amount;

@end
