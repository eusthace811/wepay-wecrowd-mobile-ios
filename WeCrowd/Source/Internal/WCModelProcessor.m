//
//  WCModelProcessor.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCModelProcessor.h"
#import <UIKit/UIKit.h>
#import "WCCampaignHeaderModel.h"
#import "WCCampaignDetailModel.h"

@implementation WCModelProcessor

+ (NSArray *) createProcessedArrayForCampaigns:(NSArray *) campaigns;
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[campaigns count]];
    
    // Process the list of dictionaries
    for (int i = 0; i < [campaigns count]; ++i) {
        NSDictionary *campaign;
        NSString *campaignID, *campaignName;
        CGFloat campaignGoal;
        
        campaign = campaigns[i];
        
        campaignID = [campaign objectForKey:@"campaign_id"];
        campaignName = [campaign objectForKey:@"campaign_name"];
        campaignGoal = [((NSNumber *) [campaign objectForKey:@"campaign_goal"]) floatValue];
        
        array[i] = [[WCCampaignHeaderModel alloc] initWithCampaign:campaignID
                                                             title:campaignName endDate:nil
                                                    donationTarget:campaignGoal
                                                    donationAmount:0];
    }
    
    return array;
}

+ (WCCampaignDetailModel *) createCampaignDetailFromDictionary:(NSDictionary *) dictionary
{
    CGFloat donationAmount, donationTarget;
    
    // Nasty cast + conversion to get the float value
    donationAmount = [((NSNumber *) [dictionary objectForKey:@"campaign_goal"]) floatValue];
    donationTarget = [((NSNumber *) [dictionary objectForKey:@"campaign_progress"]) floatValue];
    
    return [[WCCampaignDetailModel alloc] initWithCampaign:[dictionary objectForKey:@"campaign_id"]
                                                      title:[dictionary objectForKey:@"campaign_name"]
                                                    endDate:nil
                                             donationTarget:donationAmount
                                             donationAmount:donationTarget];
}

@end
