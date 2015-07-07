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

@interface WCSwiperViewController () <WPCardReaderDelegate,
                                      WPTokenizationDelegate,
                                      UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *swiperStatusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *donationField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation WCSwiperViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFeedbackUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark - Interface Builder

- (IBAction) submitAction:(id) sender
{
    [self executeCardRead];
}

- (IBAction) viewSwipeDownAction:(id) sender
{
    if ([[WCDonationManager sharedManager] donationStatus] == WCDonationStatusNone) {
        NSLog(@"Swipe down");
        [self.delegate didFinishWithSender:self];
    }
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
    BOOL isValid = [self isDonationFieldValid];
    
    [self.submitButton setHidden:!isValid];
    [self.swiperStatusLabel setHidden:isValid];
    [self.instructionLabel setHidden:isValid];
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
    
    [self resetFeedbackUI];
    NSLog(@"Error: Card reader: %@", [error localizedDescription]);
}


#pragma mark - WPTokenizationDelegate

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didTokenize:(WPPaymentToken *) paymentToken
{
    [self executeDonationWithPaymentToken:paymentToken];
    
    self.swiperStatusLabel.text = @"Processing donation...";
    
    NSLog(@"Success: Tokenization: Did tokenize!");
}

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didFailTokenization:(NSError *) error
{
    UIAlertController *alertController;
    UIAlertAction *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:@"Unable to complete tokenization"
                                                          message:@"There was a payment service error. Please try again."
                                                   preferredStyle:UIAlertControllerStyleAlert];
    closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:closeAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    [self resetFeedbackUI];
    NSLog(@"Error: Tokenization: %@", [error localizedDescription]);
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    if (textField == self.donationField) {
        if ([self isDonationFieldValid]) {
            [textField resignFirstResponder];
            
            [self executeCardRead];
        }
    }
    
    return YES;
}

#pragma mark - Internal Methods

- (void) executeCardRead
{
    // Configure UI
    [self.donationField setEnabled:NO];
    [self.submitButton setHidden:YES];
    [self.swiperStatusLabel setHidden:NO];
    
    // Kick off the swiping payment sequence
    [[WCWePayManager sharedInstance] startCardReadTokenizationWithReaderDelegate:self
                                                            tokenizationDelegate:self];
}

- (void) executeDonationWithPaymentToken:(WPPaymentToken *) paymentToken
{
    [[WCDonationManager sharedManager] makeDonationForCampaignWithAmount:self.donationField.text
                                                                    name:nil
                                                                   email:nil
                                                            creditCardID:paymentToken.tokenId
                                                         completionBlock:^(NSError *error) {
                                                             if (error) {
                                                                 UIAlertController *alertController;
                                                                 UIAlertAction *retryAction, *closeAction;
                                                                 
                                                                 alertController = [UIAlertController alertControllerWithTitle:@"Unable to complete donation"
                                                                                                                       message:@"There was a server error. Please try again."
                                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                                                 retryAction = [UIAlertAction actionWithTitle:@"Try Again"
                                                                                                        style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                                                                            [self executeCardRead];
                                                                                                        }];
                                                                 closeAction = [UIAlertAction actionWithTitle:@"Close"
                                                                                                        style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                                                                            [self resetFeedbackUI];
                                                                                                        }];
                                                                 
                                                                 [alertController addAction:retryAction];
                                                                 [alertController addAction:closeAction];
                                                                 
                                                                 [self presentViewController:alertController animated:YES completion:nil];
                                                             } else {
                                                                 NSLog(@"Success: Made donation.");
                                                                 [self.delegate didFinishWithSender:self];
                                                             }
                                                         }];
}

#pragma UI

- (void) setUpFeedbackUI
{
    // Status label
    self.swiperStatusLabel.text = @"";
    
    // Submit button
    [self.submitButton setHidden:YES];
    
    // Donation field
    [self.donationField addTarget:self
                           action:@selector(donationFieldDidChange)
                 forControlEvents:UIControlEventEditingChanged];
}

- (void) resetFeedbackUI
{
    [self.donationField setEnabled:YES];
    [self.activityIndicator stopAnimating];
    [self.submitButton setHidden:NO];
    self.swiperStatusLabel.text = @"";
}

#pragma mark Checks

- (BOOL) isDonationFieldValid
{
    NSScanner *scanner = [NSScanner scannerWithString:self.donationField.text];
    
    return [scanner scanInteger:NULL] && [scanner isAtEnd];
}

@end
