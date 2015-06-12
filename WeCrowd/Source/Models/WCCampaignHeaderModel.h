//
//  WCCampaignHeaderModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WCCampaignBaseModel;

#pragma mark - Interface

@interface WCCampaignHeaderModel : NSObject

@property (strong, nonatomic, readonly) WCCampaignBaseModel* baseModel;
@property (strong, nonatomic, readonly) UIImage* thumbnailImage;

- (id) initWithCampaignBaseModel:(WCCampaignBaseModel *) campaignBaseModel
                  thumbnailImage:(UIImage *) thumbnailImage;

@end
