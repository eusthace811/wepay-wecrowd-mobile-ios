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

@interface WCManualPaymentViewController ()

@property (weak, nonatomic) IBOutlet WCCreditCardInfoEntryView *cardInfoEntryView;

@property (nonatomic, strong, readwrite) WCCreditCardModel *creditCardModel;
@property (nonatomic, strong, readwrite) NSString *donationAmount;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation WCManualPaymentViewController

#pragma mark Interface Builder

- (IBAction) submitInformationAction:(id) sender
{
    WPPaymentInfo *paymentInfo;
    
    // Fill in the data
    [self setupCreditCardModel];
    [self setupDonation];
    
    // Tokenize the card using the entered information
    // TODO: perform check with login manager to see if merchant/payer is logged in
    paymentInfo = [[WPPaymentInfo alloc] initWithFirstName:self.creditCardModel.name
                                                  lastName:nil
                                                     email:self.email
                                            billingAddress:nil
                                           shippingAddress:nil
                                                cardNumber:self.creditCardModel.cardNumber
                                                       cvv:self.creditCardModel.cvvNumber
                                                  expMonth:nil
                                                   expYear:nil
                                           virtualTerminal:YES];
}

#pragma mark - Helper Methods

- (void) setupCreditCardModel
{
    // Extract the date from the given fields
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    NSDate *expiration;
    
    dateComponents.year = [self.cardInfoEntryView.expiryYearField.text integerValue];
    dateComponents.month = [self.cardInfoEntryView.expiryMonthField.text integerValue];
    
    expiration = [calendar dateFromComponents:dateComponents];
    
    
    self.creditCardModel = [[WCCreditCardModel alloc] initWithName:self.cardInfoEntryView.nameField.text
                                                        cardNumber:self.cardInfoEntryView.cardNumberField.text
                                                         cvvNumber:self.cardInfoEntryView.cardCVVField.text
                                                           zipCode:self.cardInfoEntryView.expiryZipField.text
                                                    expirationDate:expiration];
    
}

- (void) setupDonation
{
    self.donationAmount = self.cardInfoEntryView.donationAmountField.text;
    self.email = self.cardInfoEntryView.emailField.text;
}

@end
