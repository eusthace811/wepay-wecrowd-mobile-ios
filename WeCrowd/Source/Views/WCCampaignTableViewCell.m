//
//  WCCampaignTableViewCell.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignTableViewCell.h"
#import "WCCampaignHeaderModel.h"
#import "WCClient.h"

@interface WCCampaignTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *donationProgress;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *contentInsetView;

@property (nonatomic, readwrite) BOOL hasImageLoaded;

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
    if (!self.hasImageLoaded) {
        [WCClient fetchImageWithURLString:model.thumbnailImageURLString
                          completionBlock:^(UIImage *image, NSError *error) {
                                  self.thumbnailImageView.image = image;
                                  self.hasImageLoaded = YES;
                          }];
    }
    
    // Cell appearance customization
    [self.contentInsetView.layer setBorderWidth:0.5f];
    [self.contentInsetView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

@end
