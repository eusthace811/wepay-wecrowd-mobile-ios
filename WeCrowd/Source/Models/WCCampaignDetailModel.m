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
@property (nonatomic, strong, readwrite) NSString* location;

@end


#pragma mark - Implementation

@implementation WCCampaignDetailModel

#pragma mark - Initialization

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                          endDate:(NSDate *) endDate
                   donationTarget:(CGFloat) donationTarget
                   donationAmount:(CGFloat) donationAmount
                      detailImage:(UIImage *) detailImage
                detailDescription:(NSString *) detailDescription
                         location:(NSString *) location
{
    if (self = [super initWithCampaign:campaign
                                 title:title
                               endDate:endDate
                        donationTarget:donationTarget
                        donationAmount:donationAmount])
    {
        self.detailImage = detailImage;
        self.detailDescription = detailDescription;
        self.location = location;
    } else {
        // Do nothing
    }
    
    return self;
}

@end
