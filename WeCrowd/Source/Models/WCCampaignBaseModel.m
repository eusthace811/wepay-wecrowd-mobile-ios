//
//  WCCampaignBaseModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignBaseModel.h"


#pragma mark - Interface

@interface WCCampaignBaseModel ()

// declare properties as read/write internally
@property (strong, nonatomic, readwrite) NSString* campaignID;
@property (strong, nonatomic, readwrite) NSString* title;
@property (strong, nonatomic, readwrite) NSDate* dateEnd;

@property (nonatomic, readwrite) CGFloat donationTargetAmount;
@property (nonatomic, readwrite) CGFloat donationAmount;

@end


#pragma mark - Implementation

@implementation WCCampaignBaseModel

#pragma mark - Initialization

- (id) initWithCampaign:(NSString *) campaign
                  title:(NSString *) title
                endDate:(NSDate *) endDate
         donationTarget:(CGFloat) donationTarget
         donationAmount:(CGFloat) donationAmount
{
    if (self = [super init]) {
        self.campaignID = campaign;
        self.title = title;
        self.dateEnd = endDate;
        self.donationTargetAmount = donationTarget;
        self.donationAmount = donationAmount;
    } else {
        // unable to initialize object
    }
    
    return self;
}

@end