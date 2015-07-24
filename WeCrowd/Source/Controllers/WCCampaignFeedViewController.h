//
//  WCCampaignFeedViewController.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/22/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCCampaignFeedViewController;

@protocol CampaignDetailDelegate <NSObject>

- (void) campaignFeedViewController:(UIViewController *) viewController
            didSelectCampaignWithID:(NSString *) campaignID;

@end

@interface WCCampaignFeedViewController : UITableViewController

@end
