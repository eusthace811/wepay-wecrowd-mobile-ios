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
        
        campaign = campaigns[i];
        
        campaignID = [[campaign objectForKey:kAPICampaignIDKey] stringValue];
        campaignName = [campaign objectForKey:kAPICampaignNameKey];
        imageURLString = [campaign objectForKey:kAPICampaignImageURLKey];
        
        array[i] = [[WCCampaignHeaderModel alloc] initWithCampaign:campaignID
                                                             title:campaignName
                                                    imageURLString:imageURLString];
    }
    
    return array;
}

+ (void) createCampaignDetailFromDictionary:(NSDictionary *) dictionary
                                 completion:(WCModelProcessorCompletion) completion
{
    CGFloat donationAmount, donationTarget;
    NSString *imageURLString, *campaignIDString;
    
    // Nasty cast + conversion to get the float value
    donationAmount = [((NSNumber *) [dictionary objectForKey:kAPICampaignGoalKey]) floatValue];
    donationTarget = [((NSNumber *) [dictionary objectForKey:kAPICampaignProgressKey]) floatValue];
    
    imageURLString = [dictionary objectForKey:kAPICampaignImageURLKey];
    campaignIDString = [[dictionary objectForKey:kAPICampaignIDKey] stringValue];
    
    // Separate call to download the image - little wonky, I know
    [WCClient fetchImageWithURLString:imageURLString
                      completionBlock:^(UIImage *image, NSError *error) {
                          WCCampaignDetailModel *detailModel;
                          
                          if (error) {
                              NSLog(@"Error: ModelProcessor: Unable to fetch image.");
                          }
                          
                          detailModel = [[WCCampaignDetailModel alloc] initWithCampaign:campaignIDString
                                                                                  title:[dictionary objectForKey:kAPICampaignNameKey]
                                                                                endDate:nil
                                                                         donationTarget:donationAmount
                                                                         donationAmount:donationTarget
                                                                            detailImage:image
                                                                      detailDescription:[dictionary objectForKey:kAPICampaignDescriptionKey]];
                          
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
