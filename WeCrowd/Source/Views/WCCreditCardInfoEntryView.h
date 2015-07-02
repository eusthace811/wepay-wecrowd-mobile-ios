//
//  WCCreditCardInfoEntryView.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCCreditCardInfoEntryView : UIView

@property (weak, nonatomic) IBOutlet UITextField *donationAmountField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cardCVVField;
@property (weak, nonatomic) IBOutlet UITextField *expiryMonthField;
@property (weak, nonatomic) IBOutlet UITextField *expiryYearField;
@property (weak, nonatomic) IBOutlet UITextField *expiryZipField;

@end
