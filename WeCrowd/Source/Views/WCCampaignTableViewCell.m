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
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *contentInsetView;

@end

@implementation WCCampaignTableViewCell

#pragma mark - Interface

- (void) configureForCampaignHeader:(WCCampaignHeaderModel *) model
{
    NSDateFormatter* standardDateFormat = [NSDateFormatter new];
    NSString* timeRemaining, *pledgeProgress;
    CGFloat pledgeProgressNum = model.donationAmount > 0 ? model.donationTargetAmount / model.donationAmount : 0;
    UIColor *backgroundColor;
    
    // Format the view information
    // Hard code random end date from now since there's no real end day
    [standardDateFormat setDateStyle:NSDateFormatterShortStyle];
    timeRemaining = [NSString stringWithFormat:@"Ends %@", [standardDateFormat stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * (rand() % 10 + 1)]]];
    pledgeProgress = [NSString stringWithFormat:@"%.f", pledgeProgressNum];
    pledgeProgress = [pledgeProgress stringByAppendingString:@"% funded"];
    
    // Configure the display information within the view
    self.title.text = model.title;
    self.endDate.text = timeRemaining;
    // TODO: use thumbnail image from server
    [model fetchImageIfNeededWithCompletion:^(UIImage *image, NSError *error) {
        [self.thumbnailImageView setContentMode:UIViewContentModeScaleToFill];
        self.thumbnailImageView.image = image;
    }];
    
    // Cell appearance customization
    backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithString:@"0.925 0.925 0.925"]];
    
    [self.contentInsetView.layer setBorderWidth:0.5f];
    [self.contentInsetView.layer setBorderColor:backgroundColor.CGColor];
    [self.contentView setBackgroundColor:backgroundColor];
}

@end
