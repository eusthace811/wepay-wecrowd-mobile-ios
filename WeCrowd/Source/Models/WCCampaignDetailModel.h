//
//  WCCampaignDetailModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCCampaignBaseModel, UIImage;

#pragma mark - Interface

@interface WCCampaignDetailModel : NSObject

@property (strong, nonatomic, readonly) WCCampaignBaseModel* baseModel;
@property (strong, nonatomic, readonly) UIImage* detailImage;
@property (strong, nonatomic, readonly) NSString* detailDescription;
@property (strong, nonatomic, readonly) NSString* location; // consider using location object

- (id) initWithCampaignBaseModel:(WCCampaignBaseModel *) baseModel
                     detailImage:(UIImage *) detailImage
               detailDescription:(NSString *) detailDescription
                        location:(NSString *) location;

@end
