//
//  WCDonationManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/1/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCCampaignDonationModel.h"

@interface WCDonationManager : NSObject

@property (nonatomic, strong, readwrite) WCCampaignDonationModel *donation;

+ (instancetype) sharedInstance;

@end
