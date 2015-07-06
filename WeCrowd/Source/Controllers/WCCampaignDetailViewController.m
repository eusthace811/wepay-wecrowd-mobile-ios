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
#import "WCConstants.h"
#import "WCDonationManager.h"
#import "WCLoginManager.h"

@interface WCCampaignDetailViewController () <CampaignDetailDelegate>

@property (weak, nonatomic) IBOutlet UILabel *campaignDescription;
@property (weak, nonatomic) IBOutlet UILabel *campaignDonationProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *campaignDonationProgressBar;
@property (weak, nonatomic) IBOutlet UIButton *giveMoneyButton;

@property (strong, nonatomic, readwrite) WCCampaignDetailModel *campaignDetail;

@end

@implementation WCCampaignDetailViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if ([WCLoginManager userType] == WCLoginUserMerchant) {
        [self.giveMoneyButton setTitle:@"Accept Donation" forState:UIControlStateNormal];
    } else if ([WCLoginManager userType] == WCLoginUserPayer) {
        [self.giveMoneyButton setTitle:@"Donate" forState:UIControlStateNormal];
    }
    
    
}

- (void) didReceiveMemoryWarning {
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
                          
                          // Configure the UI
                          self.navigationItem.title = self.campaignDetail.title;
                          self.campaignDescription.text = self.campaignDetail.detailDescription;
                          self.campaignDonationProgress.text = [NSString stringWithFormat:@"%.f", donationProgress * 100];
                          self.campaignDonationProgress.text = [self.campaignDonationProgress.text stringByAppendingString:@"%"];
                          self.campaignDonationProgressBar.progress = donationProgress;
                      }
                  }];
}

- (IBAction) didPressPaymentButton:(id) sender
{
    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kIBStoryboardPaymentFlow bundle:nil];
    
    if ([WCLoginManager userType] == WCLoginUserMerchant) {
        [self displayPaymentOptionActionSheetWithStoryboard:paymentStoryboard];
    } else if ([WCLoginManager userType] == WCLoginUserPayer) {
        [self pushViewControllerWithIdentifier:@"WCManualPaymentViewController" forStoryboard:paymentStoryboard];
    }
    
    [[WCDonationManager sharedManager] setDonationCampaignID:self.campaignDetail.campaignID];
}

- (void) displayPaymentOptionActionSheetWithStoryboard:(UIStoryboard *) storyboard
{
    UIAlertController *alertController;
    UIAlertAction *swipeAction, *manualAction, *cancelAction;
    
    alertController  = [UIAlertController alertControllerWithTitle:@"Choose payment method."
                                                           message:nil
                                                    preferredStyle:UIAlertControllerStyleActionSheet];
    swipeAction = [UIAlertAction actionWithTitle:@"Swipe Card"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [self pushViewControllerWithIdentifier:@"WCSwiperViewController"
                                                                      forStoryboard:storyboard];
                                         }];
    manualAction = [UIAlertAction actionWithTitle:@"Manual Entry"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                              [self pushViewControllerWithIdentifier:@"WCManualPaymentViewController"
                                                                       forStoryboard:storyboard];
                                          }];
    cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:nil];
    
    [alertController addAction:swipeAction];
    [alertController addAction:manualAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) pushViewControllerWithIdentifier:(NSString *) identifier
                            forStoryboard:(UIStoryboard *) storyboard
{
    UIViewController *viewController;

    viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self presentViewController:viewController animated:YES completion:^{
        NSLog(@"Completed presenting!");
    }];
}

@end
