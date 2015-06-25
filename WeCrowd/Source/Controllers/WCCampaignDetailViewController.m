//
//  WCCampaignDetailViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/25/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignDetailViewController.h"
#import "WCCampaignFeedViewController.h"
#import "WCCampaignDetailModel.h"
#import "WCClient.h"

@interface WCCampaignDetailViewController () <CampaignDetailDelegate>

@property (weak, nonatomic) IBOutlet UILabel *campaignDescription;
@property (weak, nonatomic) IBOutlet UILabel *campaignDonationProgress;

@property (strong, nonatomic, readwrite) WCCampaignDetailModel *campaignDetail;

@end

@implementation WCCampaignDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CampaignDetailDelegate

- (void) campaignFeedViewController:(UIViewController *) viewController
            didSelectCampaignWithID:(NSString *) campaignID
{
    [WCClient fetchCampaignWithID:campaignID
                  completionBlock:^(WCCampaignDetailModel *campaign, NSError *error) {
                      if (error) {
                          // TODO: Handle campaign fetching error
                      } else {
                          CGFloat donationProgress;
                          
                          self.campaignDetail = campaign;
                          
                          donationProgress = self.campaignDetail.donationTargetAmount == 0 ? 0 : self.campaignDetail.donationAmount / self.campaignDetail.donationTargetAmount;
                          donationProgress *= 100;
                          
                          // Configure the UI
                          self.navigationItem.title = self.campaignDetail.title;
                          self.campaignDescription.text = self.campaignDetail.detailDescription;
                          self.campaignDonationProgress.text = [NSString stringWithFormat:@"%.f", donationProgress];
                          self.campaignDonationProgress.text = [self.campaignDonationProgress.text stringByAppendingString:@"%"];
                      }
                  }];
}

@end
