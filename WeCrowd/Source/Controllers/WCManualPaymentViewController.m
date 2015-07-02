//
//  WCManualPaymentViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCManualPaymentViewController.h"
#import "WCWePayManager.h"
#import "WCCreditCardInfoEntryView.h"
#import "WCCreditCardModel.h"
#import "WCModelProcessor.h"
#import "WCLoginManager.h"
#import "WCDonationManager.h"
#import "WCConstants.h"

@interface WCManualPaymentViewController () <WPTokenizationDelegate>

@property (weak, nonatomic) IBOutlet WCCreditCardInfoEntryView *cardInfoEntryView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong, readwrite) WCCreditCardModel *creditCardModel;
@property (nonatomic, strong, readwrite) NSString *donationAmount;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation WCManualPaymentViewController

#pragma mark Interface Builder

- (IBAction) submitInformationAction:(id) sender
{
    WPPaymentInfo *paymentInfo;
    WPAddress *address;
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSString *month, *year;
    
    // Fill in data members
    [self setupCreditCardModel];
    [self setupDonation];
    
    // Extract the needed parameters from the credit card model
    address = [[WPAddress alloc] initWithZip:self.creditCardModel.zipCode];
    
    formatter.dateFormat = @"MM";
    month = [formatter stringFromDate:self.creditCardModel.expirationDate];
    formatter.dateFormat = @"yyyy";
    year = [formatter stringFromDate:self.creditCardModel.expirationDate];
    
    // Tokenize the card using the entered information
    #ifdef DEBUG
    NSString *email = @"a+1@boss.com";
    
    self.donationAmount = @"10";
    self.email = email;
    paymentInfo = [[WPPaymentInfo alloc] initWithFirstName:@"WeCrowd-iOS"
                                                  lastName:@"Example"
                                                     email:email
                                            billingAddress:[[WPAddress alloc] initWithZip:@"94306"]
                                           shippingAddress:nil
                                                cardNumber:@"5496198584584769"
                                                       cvv:@"123"
                                                  expMonth:@"04"
                                                   expYear:@"2020"
                                           virtualTerminal:[WCLoginManager userType]];
    #else
    paymentInfo = [[WPPaymentInfo alloc] initWithFirstName:self.creditCardModel.firstName
                                                  lastName:self.creditCardModel.lastName
                                                     email:self.email
                                            billingAddress:address
                                           shippingAddress:nil
                                                cardNumber:self.creditCardModel.cardNumber
                                                       cvv:self.creditCardModel.cvvNumber
                                                  expMonth:month
                                                   expYear:year
                                           virtualTerminal:[WCLoginManager userType]];
    #endif

    [[WCWePayManager sharedInstance].wepay tokenizePaymentInfo:paymentInfo
                                          tokenizationDelegate:self];
    
    // Feedback for completing the request
    [self.activityIndicator startAnimating];
}

#pragma mark - WPTokenizationDelegate

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didTokenize:(WPPaymentToken *) paymentToken
{
    NSString *username;

    username = [self.creditCardModel.firstName stringByAppendingString:[NSString stringWithFormat:@" %@", self.creditCardModel.lastName]];
    
    [WCDonationManager makeDonationForCampaignWithID:nil
                                              amount:self.donationAmount
                                                name:username
                                               email:self.email
                                        creditCardID:paymentToken.tokenId
                                     completionBlock:^(NSError *error) {
                                         if (!error) {
                                             [self.activityIndicator stopAnimating];
                                             [self performSegueWithIdentifier:kIBSeguePaymentMethodToPaymentStatusSegue sender:self];
                                         }
                                     }];
}

- (void) paymentInfo:(WPPaymentInfo *) paymentInfo didFailTokenization:(NSError *) error
{
    UIAlertView *alert;
    NSString *message;
    
    [self.activityIndicator stopAnimating];
    
    // Notify the user of the failure
    message = [NSString stringWithFormat:@"Information invalid, received error: %@. Please Try again", [error localizedDescription]];
    alert = [[UIAlertView alloc] initWithTitle:@"Unable to process information"
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Helper Methods

- (void) setupCreditCardModel
{
    self.creditCardModel = [WCModelProcessor createCreditCardModelFromFirstName:self.cardInfoEntryView.firstNameField.text
                                                                       lastName:self.cardInfoEntryView.lastNameField.text
                                                                     cardNumber:self.cardInfoEntryView.cardNumberField.text
                                                                            cvv:self.cardInfoEntryView.cardCVVField.text
                                                                        zipCode:self.cardInfoEntryView.expiryZipField.text
                                                                expirationMonth:self.cardInfoEntryView.expiryMonthField.text
                                                                 expirationYear:self.cardInfoEntryView.expiryYearField.text];
}

- (void) setupDonation
{
    self.donationAmount = self.cardInfoEntryView.donationAmountField.text;
    self.email = self.cardInfoEntryView.emailField.text;
}

@end
