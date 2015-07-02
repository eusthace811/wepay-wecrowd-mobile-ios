//
//  WCCreditCardModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCreditCardModel.h"


#pragma mark - Interface

@interface WCCreditCardModel ()

@property (strong, nonatomic, readwrite) NSString *firstName;
@property (strong, nonatomic, readwrite) NSString *lastName;
@property (strong, nonatomic, readwrite) NSString *fullName;
@property (strong, nonatomic, readwrite) NSString* cardNumber;
@property (strong, nonatomic, readwrite) NSString* cvvNumber;
@property (strong, nonatomic, readwrite) NSString* zipCode;
@property (strong, nonatomic, readwrite) NSDate* expirationDate;

@end


#pragma mark - Implementation

@implementation WCCreditCardModel

#pragma mark - Initialization

- (instancetype) initWithFirstName:(NSString *) firstName
                          lastName:(NSString *) lastName
                        cardNumber:(NSString *) cardNumber
                         cvvNumber:(NSString *) cvvNumber
                           zipCode:(NSString *) zipCode
                    expirationDate:(NSDate *) expirationDate
{
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.fullName = [firstName stringByAppendingString:[NSString stringWithFormat:@" %@", lastName]];
        self.cardNumber = cardNumber;
        self.cvvNumber = cvvNumber;
        self.zipCode = zipCode;
        self.expirationDate = expirationDate;
    } else {
        // Do nothing
    }
    
    return self;
}

@end
