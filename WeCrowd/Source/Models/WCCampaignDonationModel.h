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

@property (strong, nonatomic, readonly) NSString *campaignID;
@property (strong, nonatomic, readonly) NSString *donatorName;
@property (strong, nonatomic, readonly) NSString *donatorEmail;
@property (strong, nonatomic, readonly) NSString *creditCardID;
@property (strong, nonatomic, readonly) NSString *amount;

- (instancetype) initWithCampaignID:(NSString *) campaignID
                        donatorName:(NSString *) donatorName
                       donatorEmail:(NSString *) donatorEmail
                       creditCardID:(NSString *) creditCardID
                             amount:(NSString *) amount;

@end
