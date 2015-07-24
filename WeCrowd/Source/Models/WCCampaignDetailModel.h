//
//  WCCampaignDetailModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCCampaignBaseModel.h"

@class WCCampaignBaseModel, UIImage;

@interface WCCampaignDetailModel : WCCampaignBaseModel

@property (nonatomic, strong, readonly) UIImage* detailImage;
@property (nonatomic, strong, readonly) NSString* detailDescription;
@property (nonatomic, strong, readonly) NSDate * dateEnd;

@property (nonatomic, readonly) CGFloat donationTargetAmount;
@property (nonatomic, readonly) CGFloat donationAmount;

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                          endDate:(NSDate *) endDate
                   donationTarget:(CGFloat) donationTarget
                   donationAmount:(CGFloat) donationAmount
                      detailImage:(UIImage *) detailImage
                detailDescription:(NSString *) detailDescription;

@end
