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

@property (nonatomic, strong, readwrite) WCCampaignDonationModel *donation;
@property (nonatomic, strong, readwrite) NSString *checkoutID;
@property (nonatomic, readwrite) WCDonationStatus donationStatus;

@end

@implementation WCDonationManager


+ (instancetype) sharedManager
{
    static WCDonationManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [WCDonationManager new];
        instance.donation = [WCCampaignDonationModel new];
    });
    
    return instance;
}

- (void) configureDonationForCampaignID:(NSString *) campaignID
{
    self.donation.campaignID = campaignID;
}

- (void) makeDonationForCampaignWithAmount:(NSString *) amount
                                      name:(NSString *) name
                                     email:(NSString *) email
                              creditCardID:(NSString *) creditCardID
                           completionBlock:(void (^)(NSError *error)) completionBlock
{
    [self configureDonationWithAmount:amount name:name email:email creditCardID:creditCardID];
    
    // Make the API donate call
    [WCClient donateWithDonation:self.donation
                 completionBlock:^(NSString *checkoutID, NSError *error) {
                     if (error) {
                         NSLog(@"Error: DonationManager: Unable to make donation. Description: %@.", [error localizedDescription]);
                     } else {
                         self.donation.checkoutID = checkoutID;
                         self.checkoutID = self.donation.checkoutID;
                         NSLog(@"Success: DonationManager: Donation successful.");
                     }
                     
                     self.donationStatus = WCDonationStatusNone;
                     completionBlock(error);
                 }];
    
    // Set the status
    self.donationStatus = WCDonationStatusPending;
}

- (void) configureDonationWithAmount:(NSString *) amount
                                name:(NSString *) name
                               email:(NSString *) email
                        creditCardID:(NSString *) creditCardID
{
    self.donation.amount = amount;
    self.donation.donatorName = name;
    self.donation.donatorEmail = email;
    self.donation.creditCardID = creditCardID;
}

@end
