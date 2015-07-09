//
//  WCModelProcessor.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCModelProcessor.h"
#import <UIKit/UIKit.h>
#import "WCConstants.h"

#import "WCCampaignHeaderModel.h"
#import "WCCampaignDetailModel.h"
#import "WCCreditCardModel.h"
#import "WCClient.h"

@implementation WCModelProcessor

+ (NSArray *) createProcessedArrayForCampaigns:(NSArray *) campaigns
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[campaigns count]];
    
    // Process the list of dictionaries
    for (int i = 0; i < [campaigns count]; ++i) {
        NSDictionary *campaign;
        NSString *campaignID, *campaignName, *imageURLString;
        CGFloat campaignGoal;
        
        campaign = campaigns[i];
        
        campaignID = [campaign objectForKey:kAPIParameterCampaignID];
        campaignName = [campaign objectForKey:kAPIParameterCampaignName];
        imageURLString = [campaign objectForKey:@"campaign_image_url"];
        campaignGoal = [((NSNumber *) [campaign objectForKey:kAPIParameterCampaignGoal]) floatValue];
        
        array[i] = [[WCCampaignHeaderModel alloc] initWithCampaign:campaignID
                                                             title:campaignName
                                                           endDate:nil
                                                    donationTarget:campaignGoal
                                                    donationAmount:0];
    }
    
    return array;
}

+ (void) createCampaignDetailFromDictionary:(NSDictionary *) dictionary
                                 completion:(WCModelProcessorCompletion) completion
{
    CGFloat donationAmount, donationTarget;
    NSString *imageURLString;
    
    // Nasty cast + conversion to get the float value
    donationAmount = [((NSNumber *) [dictionary objectForKey:kAPIParameterCampaignGoal]) floatValue];
    donationTarget = [((NSNumber *) [dictionary objectForKey:kAPIParameterCampaignProgress]) floatValue];
    // TODO: Replace key with constant
    imageURLString = [dictionary objectForKey:@"campaign_image_url"];
    
    // Separate call to download the image - little wonky, I know
    [WCClient fetchImageWithURLString:imageURLString
                      completionBlock:^(UIImage *image, NSError *error) {
                          WCCampaignDetailModel *detailModel;
                          
                          if (error) {
                              NSLog(@"Error: ModelProcessor: Unable to fetch image");
                          }
                          
                          detailModel = [[WCCampaignDetailModel alloc] initWithCampaign:[dictionary objectForKey:kAPIParameterCampaignID]
                                                                                  title:[dictionary objectForKey:kAPIParameterCampaignName]
                                                                                endDate:nil
                                                                         donationTarget:donationAmount
                                                                         donationAmount:donationTarget
                                                                            detailImage:image
                                                                      detailDescription:[dictionary objectForKey:kAPIParameterCampaignDescription]
                                                                               location:nil];
                          
                          completion(detailModel, error);
                      }];
}

+ (WCCreditCardModel *) createCreditCardModelFromFirstName:(NSString *) firstName
                                                  lastName:(NSString *) lastName
                                                cardNumber:(NSString *) cardNumber
                                                       cvv:(NSString *) cvv
                                                   zipCode:(NSString *) zipCode
                                           expirationMonth:(NSString *) expirationMonth
                                            expirationYear:(NSString *) expirationYear
{
    // Objects to extract the date from the given fields
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    NSDate *expiration;
    
    dateComponents.month = [expirationMonth integerValue];
    dateComponents.year = [expirationYear integerValue];
    
    expiration = [calendar dateFromComponents:dateComponents];
    
    return [[WCCreditCardModel alloc] initWithFirstName:firstName
                                                               lastName:lastName
                                                             cardNumber:cardNumber
                                                              cvvNumber:cvv
                                                                zipCode:zipCode
                                                         expirationDate:expiration];
}

@end
