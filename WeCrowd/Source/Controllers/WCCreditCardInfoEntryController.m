//
//  WCCreditCardInfoEntryView.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCreditCardInfoEntryController.h"
#import "WCCreditCardModel.h"

@interface WCCreditCardInfoEntryController ()

@property (weak, nonatomic) IBOutlet UITextField *donationAmountField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cardCVVField;
@property (weak, nonatomic) IBOutlet UITextField *expiryMonthField;
@property (weak, nonatomic) IBOutlet UITextField *expiryYearField;
@property (weak, nonatomic) IBOutlet UITextField *expiryZipField;

@property (nonatomic, strong, readwrite) WCCreditCardModel *creditCardModel;
@property (nonatomic, strong, readwrite) NSString *donationAmount;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation WCCreditCardInfoEntryController

- (void) fillInModels
{
    // Extract the date from the given fields
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    NSDate *expiration;
    
    dateComponents.year = [self.expiryYearField.text integerValue];
    dateComponents.month = [self.expiryMonthField.text integerValue];
    
    expiration = [calendar dateFromComponents:dateComponents];
    
    
    self.creditCardModel = [[WCCreditCardModel alloc] initWithName:self.nameField.text
                                                        cardNumber:self.cardNumberField.text
                                                         cvvNumber:self.cardCVVField.text
                                                           zipCode:self.expiryZipField.text
                                                    expirationDate:expiration];
    
    self.donationAmount = self.donationAmountField.text;
    self.email = self.emailField.text;
}

@end
