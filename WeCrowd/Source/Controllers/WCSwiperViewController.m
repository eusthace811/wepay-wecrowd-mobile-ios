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
#import "WCAlert.h"
#import "WCConstants.h"

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

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpFeedbackUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
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

#pragma mark - Interface Builder

- (IBAction) submitAction:(id) sender
{
    [self.swiperStatusLabel setHidden:NO];
    [self toggleWaitingActivity:YES];
    
    // Kick off the swiping payment sequence
    [[WCWePayManager sharedInstance] startCardReadTokenizationWithReaderDelegate:self
                                                            tokenizationDelegate:self];
}

- (IBAction) cancelAction:(id) sender
{
    if ([[WCDonationManager sharedManager] donationStatus] == WCDonationStatusNone) {
        [self.delegate didFinishWithSender:self];
    }
}


- (IBAction) tapAction:(id) sender
{
    // Dismiss the keyboard
    [self.view endEditing:YES];
}


- (void) cardReaderDidChangeStatus:(id) status
{
    if (status == kWPCardReaderStatusNotConnected) {
        self.swiperStatusLabel.text = @"Please connect the card reader to your device.";
        [self.activityIndicator stopAnimating];
    } else if (status == kWPCardReaderStatusConnected) {
        self.swiperStatusLabel.text = @"Card reader connected.";
    } else if (status == kWPCardReaderStatusWaitingForSwipe) {
        self.swiperStatusLabel.text = @"Waiting for swipe...";
        [self.activityIndicator stopAnimating];
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
    [self updateFeedbackUI];
}

#pragma mark - WPCardReaderDelegate

- (void) didReadPaymentInfo:(WPPaymentInfo *) paymentInfo
{
    // Don't need to do anything with the payment info
    self.swiperStatusLabel.text = @"Payment info has been read";
}

- (void) didFailToReadPaymentInfoWithError:(NSError *) error
{
    NSString *message;
    
    message = [NSString stringWithFormat:@"There was an error processing the card: %@. Please try again.", [error localizedDescription]];
    
    [WCAlert showSimpleAlertFromViewController:self
                                      withTitle:@"Unable to read card"
                                       message:message
                                     completion:nil];
    
    [self.donationField setEnabled:YES];
    [self.activityIndicator stopAnimating];
    [self.submitButton setHidden:NO];
    
    NSLog(@"Error: Card reader: %@.", [error localizedDescription]);
}


#pragma mark - WPTokenizationDelegate

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didTokenize:(WPPaymentToken *) paymentToken
{
    [self executeDonationWithPaymentToken:paymentToken];
    self.swiperStatusLabel.text = @"Processing donation...";
    
    NSLog(@"Success: Tokenization: Did tokenize.");
}

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didFailTokenization:(NSError *) error
{
    NSString *message;
    
    message = [NSString stringWithFormat:@"There was a payment service error: %@. Please try again.", [error localizedDescription]];
    
    [WCAlert showSimpleAlertFromViewController:self
                                      withTitle:@"Unable to complete tokenization"
                                        message:message
                                     completion:nil];
    
    [self.submitButton setHidden:YES];
    
    NSLog(@"Error: Tokenization: %@.", [error localizedDescription]);
}

#pragma mark - Internal Methods

- (void) executeCardRead
{
    // Configure UI
    [self.donationField setEnabled:NO];
    [self.submitButton setHidden:YES];
    [self.swiperStatusLabel setHidden:NO];
}

- (void) executeDonationWithPaymentToken:(WPPaymentToken *) paymentToken
{
    [self toggleWaitingActivity:YES];
    
    [[WCDonationManager sharedManager] makeDonationForCampaignWithAmount:self.donationField.text
                                                                    name:nil
                                                                   email:nil
                                                            creditCardID:paymentToken.tokenId
                                                         completionBlock:^(NSError *error) {
                                                             if (error) {
                                                                 NSString *message;
                                                                 
                                                                 message = [NSString stringWithFormat:@"There was a server error: %@ Please try again.", [error localizedDescription]];
                                                                 
                                                                 [WCAlert showAlertWithOptionFromViewController:self
                                                                                                       withTitle:@"Unable to complete donation"
                                                                                                         message:message
                                                                                                     optionTitle:@"Try Again"
                                                                                                optionCompletion:^{ [self executeCardRead]; }
                                                                                                 closeCompletion:^{ [self resetFeedbackUI]; }];
                                                             } else {
                                                                 [self.statusBarNotification displayNotificationWithMessage:@"Donation Processed!"
                                                                                                                forDuration:3.f];
                                                                 [self pushSignatureView];
                                                             }
                                                         }];
    
    [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(donationDidTimeout)
                                   userInfo:nil
                                    repeats:NO];
}

#pragma mark UI

- (void) setUpFeedbackUI
{
    self.swiperStatusLabel.text = @"Swiper Status";
    
    [self.instructionLabel setHidden:YES];
    
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

- (void) toggleWaitingActivity:(BOOL) waiting
{
    if (waiting) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
    
    [self.submitButton setHidden:waiting];
}

- (void) updateFeedbackUI
{
    BOOL isValid = [self isDonationFieldValid];
    
    [self.submitButton setHidden:!isValid];
    [self.swiperStatusLabel setHidden:!isValid];
    [self.instructionLabel setHidden:isValid];
}

- (void) pushSignatureView
{
    [self performSegueWithIdentifier:kIBSeguePaymentViewtoSignatureView sender:self];
}

#pragma mark Checks

- (BOOL) isDonationFieldValid
{
    NSScanner *scanner = [NSScanner scannerWithString:self.donationField.text];
    
    return [scanner scanInteger:NULL] && [scanner isAtEnd];
}

#pragma mark Helpers

- (void) donationDidTimeout
{
    [WCAlert showTimeoutAlertFromViewController:self fromActionWithTitle:@"Donation"
                                retryCompletion:^{ [self executeCardRead]; }
                                closeCompletion:^ { [self resetFeedbackUI]; }];
}

@end
