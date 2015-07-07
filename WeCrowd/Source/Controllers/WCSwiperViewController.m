//
//  WCSwiperViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/29/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCSwiperViewController.h"
#import "WCWePayManager.h"
#import "WCDonationManager.h"
#import <WePay/WePay.h>

@interface WCSwiperViewController () <WPCardReaderDelegate, WPTokenizationDelegate>

@property (weak, nonatomic) IBOutlet UILabel *swiperStatusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *donationField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation WCSwiperViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up the UI controls
    self.swiperStatusLabel.text = @"";
    [self.submitButton setHidden:YES];
    [self.donationField addTarget:self
                           action:@selector(donationFieldDidChange)
                 forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark - Interface Builder

- (IBAction) submitAction:(id) sender {
    // Kick off the swiping payment sequence
    [self.donationField setEnabled:NO];
    [self.submitButton setHidden:YES];
    [self.swiperStatusLabel setHidden:NO];
    
    [[WCWePayManager sharedInstance] startCardReadTokenizationWithReaderDelegate:self
                                                            tokenizationDelegate:self];
}

- (void) cardReaderDidChangeStatus:(id) status
{
    if (status == kWPCardReaderStatusNotConnected) {
        self.swiperStatusLabel.text = @"Please connect the card reader to your device.";
    } else if (status == kWPCardReaderStatusConnected) {
        self.swiperStatusLabel.text = @"Card reader connected.";
    } else if (status == kWPCardReaderStatusWaitingForSwipe) {
        self.swiperStatusLabel.text = @"Waiting for swipe...";
    } else if (status == kWPCardReaderStatusSwipeDetected) {
        self.swiperStatusLabel.text = @"Detected swipe!";
        [self.activityIndicator startAnimating];
    } else if (status == kWPCardReaderStatusTokenizing) {
        self.swiperStatusLabel.text = @"Tokenizing card";
    } else if (status == kWPCardReaderStatusStopped) {
        self.swiperStatusLabel.text = @"Card reader has stopped.";
    }
}

- (void) donationFieldDidChange
{
    NSScanner *scanner = [NSScanner scannerWithString:self.donationField.text];
    BOOL isNotNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    
    [self.submitButton setHidden:!isNotNumeric];
    [self.swiperStatusLabel setHidden:isNotNumeric];
}

#pragma mark - WPCardReaderDelegate

- (void) didReadPaymentInfo:(WPPaymentInfo *) paymentInfo
{
    // Don't need to do anything with the payment info
    self.swiperStatusLabel.text = @"Payment info has been read";
}

- (void) didFailToReadPaymentInfoWithError:(NSError *) error
{
    UIAlertController *alertController;
    UIAlertAction *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:@"Unable to read card"
                                                          message:@"There was an error processing the card. Please try again."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:closeAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    NSLog(@"Error: Card reader: %@", [error localizedDescription]);
}


#pragma mark - WPTokenizationDelegate

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didTokenize:(WPPaymentToken *) paymentToken
{
    [[WCDonationManager sharedManager] makeDonationForCampaignWithAmount:self.donationField.text
                                                                    name:nil
                                                                   email:nil
                                                            creditCardID:paymentToken.tokenId
                                                         completionBlock:^(NSError *error) {
                                                             if (!error) {
                                                                 NSLog(@"Success: Made donation.");
                                                                 [self.delegate didFinishPaymentWithSender:self];
                                                             }
                                                             
                                                             [self.activityIndicator stopAnimating];
                                                         }];
    
    self.swiperStatusLabel.text = @"Processing donation...";
    NSLog(@"Success: Did tokenize!");
}

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didFailTokenization:(NSError *) error
{
    UIAlertController *alertController;
    UIAlertAction *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:@"Unable to complete transaction"
                                                          message:@"There was a payment service error. Please try again."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:closeAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    NSLog(@"Error: Tokenization: %@", [error localizedDescription]);
}

@end
