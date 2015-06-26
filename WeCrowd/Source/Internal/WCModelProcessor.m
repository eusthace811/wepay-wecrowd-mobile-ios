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
#import "WCConstants.h"

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
        
        campaignID = [campaign objectForKey:kAPIParameterCampaignID];
        campaignName = [campaign objectForKey:kAPIParameterCampaignName];
        campaignGoal = [((NSNumber *) [campaign objectForKey:kAPIParameterCampaignGoal]) floatValue];
        
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
    donationAmount = [((NSNumber *) [dictionary objectForKey:kAPIParameterCampaignGoal]) floatValue];
    donationTarget = [((NSNumber *) [dictionary objectForKey:kAPIParameterCampaignProgress]) floatValue];
    
    return [[WCCampaignDetailModel alloc] initWithCampaign:[dictionary objectForKey:kAPIParameterCampaignID]
                                                      title:[dictionary objectForKey:kAPIParameterCampaignName]
                                                    endDate:nil
                                             donationTarget:donationAmount
                                             donationAmount:donationTarget
                                                detailImage:nil
                                          detailDescription:[dictionary objectForKey:kAPIParameterCampaignDescription]
                                                   location:nil];
}

@end
