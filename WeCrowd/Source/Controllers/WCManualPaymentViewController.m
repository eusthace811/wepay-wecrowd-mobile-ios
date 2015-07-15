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
#import "WCCreditCardModel.h"
#import "WCModelProcessor.h"
#import "WCConstants.h"
#import "WCAlert.h"

@interface WCManualPaymentViewController () <WPTokenizationDelegate>

@property (weak, nonatomic) IBOutlet UITextField *donationField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *expiryMonthField;
@property (weak, nonatomic) IBOutlet UITextField *expiryYearField;
@property (weak, nonatomic) IBOutlet UITextField *cvvField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeField;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *submitFormButton;

@property (nonatomic, strong, readwrite) WCCreditCardModel *creditCardModel;
@property (nonatomic, strong, readwrite) NSString *donationAmount;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation WCManualPaymentViewController

- (IBAction) tapAction:(id) sender
{
    // Dismiss the keyboard if there is one
    [self.view endEditing:YES];
}

#pragma mark Interface Builder

- (IBAction) submitInformationAction:(id) sender
{
    // Fill in data members
    [self setupCreditCardModel];
    [self setupDonation];
    
    [self executeDonation];
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
                                                                                                                forDuration:3.f];
                                                                 [self pushSignatureView];
//                                                                 [self.delegate didFinishWithSender:self];
                                                             } else {
                                                                 [WCAlert showAlertWithOptionFromViewController:self
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
    NSString *message = [NSString stringWithFormat:@"Could not complete donation. %@", [error localizedDescription]];
    
    [WCAlert showSimpleAlertFromViewController:self
                                      withTitle:@"Unable to process information"
                                        message:message
                                     completion:nil];
    
    [self shouldDisplayPaymentFeedback:NO];
}

#pragma mark - Helper Methods

- (void) setupCreditCardModel
{
    self.creditCardModel = [WCModelProcessor createCreditCardModelFromFirstName:self.firstNameField.text
                                                                       lastName:self.lastNameField.text
                                                                     cardNumber:self.cardNumberField.text
                                                                            cvv:self.cvvField.text
                                                                        zipCode:self.zipCodeField.text
                                                                expirationMonth:self.expiryMonthField.text
                                                                 expirationYear:self.expiryYearField.text];
}

- (void) setupDonation
{
    self.donationAmount = self.donationField.text;
    self.email = self.emailField.text;
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
