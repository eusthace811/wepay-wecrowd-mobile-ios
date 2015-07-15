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

typedef NS_ENUM(NSInteger, WCDonationStatus) {
    WCDonationStatusNone = 0,
    WCDonationStatusPending = 1
};

@property (nonatomic, strong, readonly) WCCampaignDonationModel *donation;
@property (nonatomic, strong, readonly) NSString *checkoutID;
@property (nonatomic, readonly) WCDonationStatus donationStatus;

+ (instancetype) sharedManager;

- (void) configureDonationForCampaignID:(NSString *) campaignID;

- (void) makeDonationForCampaignWithAmount:(NSString *) amount
                                      name:(NSString *) name
                                     email:(NSString *) email
                              creditCardID:(NSString *) creditCardID
                           completionBlock:(void (^)(NSError *error)) completionBlock;

@end
