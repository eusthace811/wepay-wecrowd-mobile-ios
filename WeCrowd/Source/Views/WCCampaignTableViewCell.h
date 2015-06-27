//
//  WCCampaignTableViewCell.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCCampaignHeaderModel;

@interface WCCampaignTableViewCell : UITableViewCell

- (void) configureForCampaignHeader:(WCCampaignHeaderModel *) model;

@end
