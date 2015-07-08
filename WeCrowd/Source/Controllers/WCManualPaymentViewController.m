//
//  WCManualPaymentViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCManualPaymentViewController.h"

#import <WePay/WePay.h>
#import "WCWePayManager.h"
#import "WCDonationManager.h"
#import "WCLoginManager.h"
#import "WCCreditCardInfoEntryView.h"
#import "WCCreditCardModel.h"
#import "WCModelProcessor.h"
#import "WCConstants.h"
#import "WCAlerts.h"

@interface WCManualPaymentViewController () <WPTokenizationDelegate>

@property (weak, nonatomic) IBOutlet WCCreditCardInfoEntryView *cardInfoEntryView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *submitFormButton;

@property (nonatomic, strong, readwrite) WCCreditCardModel *creditCardModel;
@property (nonatomic, strong, readwrite) NSString *donationAmount;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation WCManualPaymentViewController

#pragma mark Interface Builder

- (IBAction) submitInformationAction:(id) sender
{
    // Fill in data members
    [self setupCreditCardModel];
    [self setupDonation];
    
    [self executeDonation];
}

- (IBAction) swipeDownAction:(id) sender
{
    [self.delegate didFinishWithSender:self];
}


- (IBAction) cancelAction:(id) sender
{
    [self.delegate didFinishWithSender:self];
}

#pragma mark - WPTokenizationDelegate

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didTokenize:(WPPaymentToken *) paymentToken
{
    [[WCDonationManager sharedManager] makeDonationForCampaignWithAmount:self.donationAmount
                                                                    name:self.creditCardModel.fullName
                                                                   email:self.email
                                                            creditCardID:paymentToken.tokenId
                                                         completionBlock:^(NSError *error) {
                                                             if (!error) {
                                                                 [self.activityIndicator stopAnimating];
                                                                 [self.statusBarNotification displayNotificationWithMessage:@"Donation Processed!"
                                                                                                                forDuration:2.5f];
                                                                 [self.delegate didFinishWithSender:self];
                                                             } else {
                                                                 [WCAlerts showAlertWithOptionFromViewController:self
                                                                                                       withTitle:@"Unable to complete donation"
                                                                                                         message:@"There was a server error. Please try again."
                                                                                                     optionTitle:@"Try Again"
                                                                                                optionCompletion:^{ [self executeDonation]; }
                                                                                                 closeCompletion:nil];
                                                             }
                                                             
                                                             [self shouldDisplayPaymentFeedback:NO];
                                                         }];
}

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didFailTokenization:(NSError *) error
{
    NSString *message;
    
    [WCAlerts showSimpleAlertFromViewController:self
                                      withTitle:@"Unable to process information"
                                        message:message
                                     completion:nil];
    
    [self shouldDisplayPaymentFeedback:NO];
}

#pragma mark - Helper Methods

- (void) setupCreditCardModel
{
    #ifdef DEBUG
    self.creditCardModel = [WCModelProcessor createCreditCardModelFromFirstName:@"WeCrowd-iOS"
                                                                       lastName:@"Demo"
                                                                     cardNumber:@"5496198584584769"
                                                                            cvv:@"123"
                                                                        zipCode:@"94306"
                                                                expirationMonth:@"04"
                                                                 expirationYear:@"2020"];
    #else
    self.creditCardModel = [WCModelProcessor createCreditCardModelFromFirstName:self.cardInfoEntryView.firstNameField.text
                                                                       lastName:self.cardInfoEntryView.lastNameField.text
                                                                     cardNumber:self.cardInfoEntryView.cardNumberField.text
                                                                            cvv:self.cardInfoEntryView.cardCVVField.text
                                                                        zipCode:self.cardInfoEntryView.expiryZipField.text
                                                                expirationMonth:self.cardInfoEntryView.expiryMonthField.text
                                                                 expirationYear:self.cardInfoEntryView.expiryYearField.text];
    #endif
}

- (void) setupDonation
{
    #ifdef DEBUG
    self.donationAmount = @"50";
    self.email = @"wp.ios.example@wepay.com";
    
    #else
    self.donationAmount = self.cardInfoEntryView.donationAmountField.text;
    self.email = self.cardInfoEntryView.emailField.text;
    #endif
}

- (void) executeDonation
{
    [[WCWePayManager sharedInstance] tokenizeCreditCardWithInfo:self.creditCardModel
                                                 isMerchantUser:[WCLoginManager userType]
                                                          email:self.email
                                                       delegate:self];
    
    
    [self shouldDisplayPaymentFeedback:YES];
}

- (void) shouldDisplayPaymentFeedback:(BOOL) display
{
    if (display) {
        [self.activityIndicator startAnimating];
        [self.submitFormButton setHidden:YES];
    } else {
        [self.activityIndicator stopAnimating];
        [self.submitFormButton setHidden:NO];
    }
}

@end
