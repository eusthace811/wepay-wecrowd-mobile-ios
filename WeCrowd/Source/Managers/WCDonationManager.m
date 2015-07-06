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

@interface WCDonationManager ()

@property (nonatomic, strong, readwrite) NSString *campaignID;

@end

@implementation WCDonationManager

+ (instancetype) sharedManager
{
    static WCDonationManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [WCDonationManager new];
    });
    
    return instance;
}

- (void) setDonationCampaignID:(NSString *) campaignID
{
    self.campaignID = campaignID;
}


- (void) makeDonationForCampaignWithAmount:(NSString *) amount
                                      name:(NSString *) name
                                     email:(NSString *) email
                              creditCardID:(NSString *) creditCardID
                           completionBlock:(void (^)(NSError *error)) completionBlock
{
    WCCampaignDonationModel *donation;
    
    donation = [[WCCampaignDonationModel alloc] initWithCampaignID:self.campaignID
                                                       donatorName:name
                                                      donatorEmail:email
                                                      creditCardID:creditCardID
                                                            amount:amount];
    
    // Make the API donate call
    [WCClient donateWithDonation:donation
                 completionBlock:^(NSString *checkoutID, NSError *error) {
                     // TODO: Handle error
                     if (!error) {
                         NSLog(@"Donation successful");
                     } else {
                         NSLog(@"Error: DonationManager: Unable to make donation.");
                     }
                     
                     completionBlock(error);
                 }];
}

@end
