//
//  WCDonationManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/1/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCDonationManager.h"
#import "WCCampaignDonationModel.h"
#import "WCClient.h"

@implementation WCDonationManager

//+ (instancetype) sharedInstance
//{
//    static WCDonationManager *instance = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        instance = [WCDonationManager new];
//    });
//    
//    return instance;
//}

+ (void) makeDonationForCampaignWithID:(NSString *) ID
                                amount:(NSString *) amount
                                  name:(NSString *) name
                                 email:(NSString *) email
                          creditCardID:(NSString *) creditCardID
                       completionBlock:(void (^)(NSError *error))completionBlock
{
    WCCampaignDonationModel *donation;
    
    // Make the API donate call
    [WCClient donateWithDonation:donation
                 completionBlock:^(NSString *checkoutID, NSError *error) {
                     // TODO: Handle error
                     if (!error) {
                         NSLog(@"Donation successful");
                     } else {
                         NSLog(@"Error: Unable to make donation.");
                     }
                     
                     completionBlock(error);
                 }];
}

@end
