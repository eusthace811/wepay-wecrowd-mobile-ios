//
//  WCModelProcessor.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCCampaignDetailModel;

@interface WCModelProcessor : NSObject

+ (NSArray *) createProcessedArrayForCampaigns:(NSArray *) campaigns;
+ (WCCampaignDetailModel *) createCampaignDetailFromDictionary:(NSDictionary *) dictionary;

@end
