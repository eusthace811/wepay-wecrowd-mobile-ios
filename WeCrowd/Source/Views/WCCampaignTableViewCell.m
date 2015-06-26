//
//  WCCampaignTableViewCell.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignTableViewCell.h"

@interface WCCampaignTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *endDate;
@property (weak, nonatomic) IBOutlet UIView *donationProgress;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation WCCampaignTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

@end
