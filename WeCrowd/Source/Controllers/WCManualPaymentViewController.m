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

@interface WCManualPaymentViewController ()

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
    // TODO: perform check with login manager to see if merchant/payer is logged in
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
    
    // Feedback for completing the request
    [self.activityIndicator startAnimating];
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
