//
//  WCDonationManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/1/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCDonationManager.h"

@implementation WCDonationManager

+ (instancetype) sharedInstance
{
    static WCDonationManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [WCDonationManager new];
        instance.donation = [WCCampaignDonationModel new];
    });
    
    return instance;
}

@end
