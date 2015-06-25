//
//  WCCampaignBaseModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>


#pragma mark - Interface

@interface WCCampaignBaseModel : NSObject

@property (strong, nonatomic, readonly) NSString * campaignID;
@property (strong, nonatomic, readonly) NSString * title;
@property (strong, nonatomic, readonly) NSDate * dateEnd;

@property (nonatomic, readonly) CGFloat donationTargetAmount;
@property (nonatomic, readonly) CGFloat donationAmount;


#pragma mark - Initialization

- (id) initWithCampaign:(NSString *) campaign
                  title:(NSString *) title
                endDate:(NSDate *) endDate
         donationTarget:(CGFloat) donationTarget
         donationAmount:(CGFloat) donationAmount;

@end
