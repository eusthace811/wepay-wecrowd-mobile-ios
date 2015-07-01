//
//  WCCreditCardModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Interface

@interface WCCreditCardModel : NSObject

@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *cardNumber;
@property (strong, nonatomic, readonly) NSString *cvvNumber;
@property (strong, nonatomic, readonly) NSString *zipCode;
@property (strong, nonatomic, readonly) NSDate *expirationDate;

- (instancetype) initWithFirstName:(NSString *) firstName
                          lastName:(NSString *) lastName
                        cardNumber:(NSString *) cardNumber
                         cvvNumber:(NSString *) cvvNumber
                           zipCode:(NSString *) zipCode
                    expirationDate:(NSDate *) expirationDate;

@end
