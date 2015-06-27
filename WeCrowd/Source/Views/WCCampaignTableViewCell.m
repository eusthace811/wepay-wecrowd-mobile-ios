//
//  WCCampaignTableViewCell.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignTableViewCell.h"
#import "WCCampaignHeaderModel.h"

@interface WCCampaignTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *donationProgress;

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation WCCampaignTableViewCell

#pragma mark - Interface

- (void) configureForCampaignHeader:(WCCampaignHeaderModel *) model
{
    NSDateFormatter* standardDateFormat = [NSDateFormatter new];
    NSString* timeRemaining, *pledgeProgress;
    CGFloat pledgeProgressNum = model.donationAmount > 0 ? model.donationTargetAmount / model.donationAmount : 0;
    
    // format the view information
    [standardDateFormat setDateStyle:NSDateFormatterShortStyle];
    // TODO: use end date from server
    timeRemaining = [NSString stringWithFormat:@"Ends %@", [standardDateFormat stringFromDate:[NSDate date]]];
    pledgeProgress = [NSString stringWithFormat:@"%.f", pledgeProgressNum];
    pledgeProgress = [pledgeProgress stringByAppendingString:@"%"];
    
    // configure the display information within the view
    self.title.text = model.title;
    self.endDate.text = timeRemaining;
    self.donationProgress.text = pledgeProgress;
    // TODO: use thumbnail image from server
    self.thumbnailImageView.image = model.thumbnailImage;
}

@end
