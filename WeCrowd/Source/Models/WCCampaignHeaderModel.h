//
//  WCCampaignHeaderModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WCCampaignBaseModel.h"

#pragma mark - Interface

@interface WCCampaignHeaderModel : WCCampaignBaseModel

@property (nonatomic, strong, readonly) NSString *thumbnailImageURLString;
@property (nonatomic, strong, readonly) UIImage *thumbnailImage;

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title
                          endDate:(NSDate *) endDate
                   donationTarget:(CGFloat) donationTarget
                   donationAmount:(CGFloat) donationAmount
                   imageURLString:(NSString *) imageURLString;

- (void) fetchImageIfNeededWithCompletion:(void(^)(UIImage *image, NSError *error)) completion;

@end
