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

@property (strong, nonatomic, readwrite) WCCampaignBaseModel* baseModel;
@property (strong, nonatomic, readwrite) UIImage* thumbnailImage;

@end


#pragma mark - Implementation

@implementation WCCampaignHeaderModel

#pragma mark - Initialization

- (id) initWithCampaignBaseModel:(WCCampaignBaseModel *)campaignBaseModel
                  thumbnailImage:(UIImage *)thumbnailImage
{
    if (self = [super init]) {
        self.baseModel = campaignBaseModel;
        self.thumbnailImage = thumbnailImage;
    } else {
        // unable to initialize objects
    }
    
    return self;
}

@end
