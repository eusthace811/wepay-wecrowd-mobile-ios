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
#import "WCManualPaymentViewController.h"
#import "WCSwiperViewController.h"
#import "WCAlert.h"

@interface WCCampaignDetailViewController () <CampaignDetailDelegate, PaymentFlowDelegate>


@property (weak, nonatomic) IBOutlet UITextView *campaignDescription;
@property (weak, nonatomic) IBOutlet UILabel *campaignDonationProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *campaignDonationProgressBar;
@property (weak, nonatomic) IBOutlet UIButton *giveMoneyButton;
@property (weak, nonatomic) IBOutlet UIImageView *campaignImage;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@property (strong, nonatomic, readwrite) WCCampaignDetailModel *campaignDetail;

@end

@implementation WCCampaignDetailViewController

- (instancetype) initWithCoder:(NSCoder *) aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpNavigationItemTitleLabel];
    } else {
        // Do nothing
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if ([WCLoginManager userType] == WCLoginUserMerchant) {
        [self.giveMoneyButton setTitle:@"Accept Donation" forState:UIControlStateNormal];
    } else if ([WCLoginManager userType] == WCLoginUserPayer) {
        [self.giveMoneyButton setTitle:@"Donate" forState:UIControlStateNormal];
    }
    
    self.navigationItem.titleView = self.titleLabel;
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

- (void) didFinishWithSender:(id) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Interface Builder

- (IBAction) didPressPaymentButton:(id) sender
{
    UIStoryboard *paymentStoryboard = [UIStoryboard storyboardWithName:kIBStoryboardPaymentFlow bundle:nil];
    
    if ([WCLoginManager userType] == WCLoginUserMerchant) {
        [self displayPaymentOptionActionSheetWithStoryboard:paymentStoryboard sender:sender];
    } else if ([WCLoginManager userType] == WCLoginUserPayer) {
        [self pushViewControllerWithIdentifier:NSStringFromClass([WCManualPaymentViewController class]) forStoryboard:paymentStoryboard];
    }
    
    [[WCDonationManager sharedManager] configureDonationForCampaignID:self.campaignDetail.campaignID];
}

#pragma mark - Helper Methods

- (void) displayPaymentOptionActionSheetWithStoryboard:(UIStoryboard *) storyboard sender:(UIButton *) sender
{
    UIAlertController *alertController;
    UIAlertAction *swipeAction, *manualAction, *cancelAction;
    UIPopoverPresentationController *popoverPresenter;  // iPad support
    
    
    alertController  = [UIAlertController alertControllerWithTitle:@"Choose payment method."
                                                           message:nil
                                                    preferredStyle:UIAlertControllerStyleActionSheet];
    
    swipeAction = [UIAlertAction actionWithTitle:@"Swipe Card"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [self pushViewControllerWithIdentifier:NSStringFromClass([WCSwiperViewController class])
                                                                      forStoryboard:storyboard];
                                         }];
    manualAction = [UIAlertAction actionWithTitle:@"Manual Entry"
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                              [self pushViewControllerWithIdentifier:NSStringFromClass([WCManualPaymentViewController class])
                                                                       forStoryboard:storyboard];
                                          }];
    cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:nil];
    
    [alertController addAction:swipeAction];
    [alertController addAction:manualAction];
    [alertController addAction:cancelAction];
    
    // iPad support - Anything popover
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    popoverPresenter = [alertController popoverPresentationController];
    popoverPresenter.sourceView = sender;
    popoverPresenter.sourceRect = sender.bounds;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) pushViewControllerWithIdentifier:(NSString *) identifier
                            forStoryboard:(UIStoryboard *) storyboard
{
    WCPaymentViewController *viewController;
    UINavigationController *navigationController;

    viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    viewController.delegate = self;
    
    navigationController = [storyboard instantiateViewControllerWithIdentifier:kIBPaymentNavigationControllerIdentifier];
    [navigationController setViewControllers:@[viewController] animated:NO];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void) executeFetchCampaignDetailWithID:(NSString *) campaignID
{
    [WCClient fetchCampaignWithID:campaignID
                  completionBlock:^(WCCampaignDetailModel *campaign, NSError *error) {
                      if (error) {
                          [WCAlert showAlertWithOptionFromViewController:self
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
                          self.titleLabel.text = self.campaignDetail.title;
                          self.campaignImage.image = self.campaignDetail.detailImage;
                          self.campaignDonationProgress.text = [NSString stringWithFormat:@"%.f", donationProgress * 100];
                          self.campaignDonationProgress.text = [self.campaignDonationProgress.text stringByAppendingString:@"% funded"];
                          self.campaignDonationProgressBar.progress = donationProgress;
                          
                          // Hack for resizing the headerview on iPad since the imageview does not
                          // respect the header view height
                          if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                              CGRect headerFrame;
                              
                              headerFrame = self.tableView.tableHeaderView.frame;
                              headerFrame.size.height = self.campaignImage.frame.size.height + 400;
                              
                              self.tableView.tableHeaderView.frame = headerFrame;
                              self.tableView.tableHeaderView = self.campaignImage;
                          }
                      }
                      
                      // Scroll the text view now the image height is calculated
                      [self.campaignDescription setContentOffset:CGPointMake(0, 0) animated:YES];
                  }];
}

#pragma mark Setup

- (void) setUpNavigationItemTitleLabel
{
    // Style the detail title label so the text fits in the navbar
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
    self.titleLabel.minimumScaleFactor = 0.6f;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textColor = [UIColor whiteColor];
}

@end
