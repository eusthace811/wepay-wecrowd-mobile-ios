//
//  WCCampaignHeaderModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignHeaderModel.h"

#pragma mark - Interface

@interface WCCampaignHeaderModel ()

@property (strong, nonatomic, readwrite) UIImage * thumbnailImage;

@end


#pragma mark - Implementation

@implementation WCCampaignHeaderModel

#pragma mark - Initialization

- (id) initWithCampaign:(NSString *) campaign
                  title:(NSString *) title
                endDate:(NSDate *) endDate
         donationTarget:(CGFloat) donationTarget
         donationAmount:(CGFloat) donationAmount
         thumbnailImage:(UIImage *) thumbnailImage
{
    if (self = [super initWithCampaign:campaign
                                 title:title endDate:endDate
                        donationTarget:donationTarget
                        donationAmount:donationAmount])
    {
        self.thumbnailImage = thumbnailImage;
    } else {
        // do nothing
    }
    
    return self;
}

@end
