//
//  WCCampaignBaseModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@interface WCCampaignBaseModel : NSObject

@property (nonatomic, strong, readonly) NSString * campaignID;
@property (nonatomic, strong, readonly) NSString * title;

- (instancetype) initWithCampaign:(NSString *) campaign
                            title:(NSString *) title;

@end
