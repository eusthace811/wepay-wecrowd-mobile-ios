//
//  WCDonationManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/1/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  WCCampaignDonationModel;

@interface WCDonationManager : NSObject

//+ (instancetype) sharedInstance;

+ (void) makeDonationForCampaignWithID:(NSString *) ID
                                amount:(NSString *) amount
                                  name:(NSString *) name
                                 email:(NSString *) email
                          creditCardID:(NSString *) creditCardID
                       completionBlock:(void (^)(NSError *error))completionBlock;

@end
