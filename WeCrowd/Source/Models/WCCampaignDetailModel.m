//
//  WCCampaignDetailModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignDetailModel.h"

#pragma mark - Interface

@interface WCCampaignDetailModel ()

@property (nonatomic, strong, readwrite) UIImage* detailImage;
@property (nonatomic, strong, readwrite) NSString* detailDescription;
@property (nonatomic, strong, readwrite) NSDate * dateEnd;

@property (nonatomic, readwrite) CGFloat donationTargetAmount;
@property (nonatomic, readwrite) CGFloat donationAmount;

@end


#pragma mark - Implementation

@implementation WCCampaignDetailModel

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                          endDate:(NSDate *) endDate
                   donationTarget:(CGFloat) donationTarget
                   donationAmount:(CGFloat) donationAmount
                      detailImage:(UIImage *) detailImage
                detailDescription:(NSString *) detailDescription
{
    if (self = [super initWithCampaign:campaign
                                 title:title])
    {
        self.detailImage = detailImage;
        self.detailDescription = detailDescription;
        self.dateEnd = endDate;
        self.donationTargetAmount = donationTarget;
        self.donationAmount = donationAmount;
    } else {
        // Do nothing
    }
    
    return self;
}

@end
