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
#import "WCPaymentViewController.h"
#import "WCAlerts.h"

@interface WCCampaignDetailViewController () <CampaignDetailDelegate, PaymentViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *campaignDescription;
@property (weak, nonatomic) IBOutlet UILabel *campaignDonationProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *campaignDonationProgressBar;
@property (weak, nonatomic) IBOutlet UIButton *giveMoneyButton;
@property (weak, nonatomic) IBOutlet UIImageView *campaignImage;

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
    [self executeFetchCampaignDetailWithID:campaignID];
}

#pragma mark - PaymentViewDelagate

- (void) didFinishWithSender:(WCPaymentViewController *) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Interface Builder

- (IBAction) didPressPaymentButton:(id) sender
{
    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kIBStoryboardPaymentFlow bundle:nil];
    
    if ([WCLoginManager userType] == WCLoginUserMerchant) {
        [self displayPaymentOptionActionSheetWithStoryboard:paymentStoryboard];
    } else if ([WCLoginManager userType] == WCLoginUserPayer) {
        [self pushViewControllerWithIdentifier:@"WCManualPaymentViewController" forStoryboard:paymentStoryboard];
    }
    
    [[WCDonationManager sharedManager] setCampaignID:self.campaignDetail.campaignID];
}

#pragma mark - Helper Methods

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
    WCPaymentViewController *viewController;
    UINavigationController *navigationController;

    viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    viewController.delegate = self;
    
    navigationController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentNavigationController"];
    [navigationController setViewControllers:@[viewController] animated:NO];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void) executeFetchCampaignDetailWithID:(NSString *) campaignID
{
    [WCClient fetchCampaignWithID:campaignID
                  completionBlock:^(WCCampaignDetailModel *campaign, NSError *error) {
                      if (error) {
                          [WCAlerts showAlertWithOptionFromViewController:self
                                                                withTitle:@"Unable to fetch campaign details"
                                                                  message:@"The details of this campaign could not be fetched. Ensure you are connected to a network and try again."
                                                              optionTitle:@"Try Again"
                                                         optionCompletion:^{ [self executeFetchCampaignDetailWithID:campaignID]; }
                                                          closeCompletion:nil];
                      } else {
                          CGFloat donationProgress;
                          
                          self.campaignDetail = campaign;
                          
                          donationProgress = self.campaignDetail.donationTargetAmount == 0 ? 0 : self.campaignDetail.donationAmount / self.campaignDetail.donationTargetAmount;
                          
                          // Configure the UI
                          self.navigationItem.title = self.campaignDetail.title;
                          self.campaignImage.image = self.campaignDetail.detailImage;
                          self.campaignDonationProgress.text = [NSString stringWithFormat:@"%.f", donationProgress * 100];
                          self.campaignDonationProgress.text = [self.campaignDonationProgress.text stringByAppendingString:@"%"];
                          self.campaignDonationProgressBar.progress = donationProgress;
                      }
                      
                      // Scroll the text view now the image height is calculated
                      [self.campaignDescription setContentOffset:CGPointMake(0, 0) animated:YES];
                  }];
}

@end
