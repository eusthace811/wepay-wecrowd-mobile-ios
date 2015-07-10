//
//  WPApplePayPaymentRequest.h
//  WePay
//
//  Created by Chaitanya Bagaria on 11/7/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  An instance of this class contains all the information required for process an Apple Pay transaction.
 */
@interface WPApplePayPaymentRequest : NSObject

/**
 *  The designated initializer
 *
 *  @param transactionInfo All the info required to process an Apple Pay transaction.
 *
 *  @return An instance of \ref WPApplePayPaymentRequest, that can be used to initiate an Apple Pay transaction.
 */
- (instancetype) initWithInfo:(id)transactionInfo;

@end
