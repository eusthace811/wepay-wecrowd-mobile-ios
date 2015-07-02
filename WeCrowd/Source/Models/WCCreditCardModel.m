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

@property (nonatomic, strong, readwrite) NSString *firstName;
@property (nonatomic, strong, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSString *fullName;
@property (nonatomic, strong, readwrite) NSString* cardNumber;
@property (nonatomic, strong, readwrite) NSString* cvvNumber;
@property (nonatomic, strong, readwrite) NSString* zipCode;
@property (nonatomic, strong, readwrite) NSDate* expirationDate;

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
