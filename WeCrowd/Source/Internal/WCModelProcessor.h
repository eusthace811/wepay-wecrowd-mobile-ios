//
//  WCModelProcessor.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCCampaignDetailModel, WCCreditCardModel;

@interface WCModelProcessor : NSObject

+ (NSArray *) createProcessedArrayForCampaigns:(NSArray *) campaigns;

+ (void) createCampaignDetailFromDictionary:(NSDictionary *) dictionary
                            completionBlock:(void (^)(WCCampaignDetailModel *model, NSError *error)) completionBlock;

+ (WCCreditCardModel *) createCreditCardModelFromFirstName:(NSString *) firstName
                                                  lastName:(NSString *) lastName
                                                cardNumber:(NSString *) cardNumber
                                                       cvv:(NSString *) cvv
                                                   zipCode:(NSString *) zipCode
                                           expirationMonth:(NSString *) expirationMonth
                                            expirationYear:(NSString *) expirationYear;

@end
