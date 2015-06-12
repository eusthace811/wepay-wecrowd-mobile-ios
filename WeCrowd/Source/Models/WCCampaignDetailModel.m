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

@property (strong, nonatomic, readwrite) WCCampaignBaseModel* baseModel;
@property (strong, nonatomic, readwrite) UIImage* detailImage;
@property (strong, nonatomic, readwrite) NSString* detailDescription;
@property (strong, nonatomic, readwrite) NSString* location;

@end


#pragma mark - Implementation

@implementation WCCampaignDetailModel

#pragma mark - Initialization

- (id) initWithCampaignBaseModel:(WCCampaignBaseModel *) baseModel
                     detailImage:(UIImage *) detailImage
               detailDescription:(NSString *) detailDescription
                        location:(NSString *) location
{
    if (self = [super init]) {
        self.baseModel = baseModel;
        self.detailImage = detailImage;
        self.detailDescription = detailDescription;
        self.location = location;
    } else {
        // unable to initialize objects
    }
    
    return self;
}

@end
