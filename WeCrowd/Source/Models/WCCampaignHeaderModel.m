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

@property (nonatomic, strong, readwrite) UIImage *thumbnailImage;
@property (nonatomic, strong, readwrite) NSString *thumbnailImageURLString;

@end


#pragma mark - Implementation

@implementation WCCampaignHeaderModel

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                          endDate:(NSDate *) endDate
                   donationTarget:(CGFloat) donationTarget
                   donationAmount:(CGFloat) donationAmount
                   imageURLString:(NSString *) imageURLString
{
    if (self = [super initWithCampaign:campaign
                                 title:title endDate:endDate
                        donationTarget:donationTarget
                        donationAmount:donationAmount])
    {
        self.thumbnailImageURLString = imageURLString;
    } else {
        // Do nothing
    }
    
    return self;
}

@end
