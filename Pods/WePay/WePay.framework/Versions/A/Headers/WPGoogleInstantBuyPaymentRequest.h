//
//  WPGoogleInstantBuyPaymentRequest.h
//  WePay
//
//  Created by Chaitanya Bagaria on 11/7/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  An instance of this class contains all the information required to process a Google Instant Buy transaction.
 */
@interface WPGoogleInstantBuyPaymentRequest : NSObject

/**
 *  The designated initializer
 *
 *  @param transactionInfo All the info required to process a Google Instant Buy transaction.
 *
 *  @return An instance of \ref WPGoogleInstantBuyPaymentRequest, that can be used to initiate a Google Instant Buy transaction.
 */
- (instancetype) initWithInfo:(id)transactionInfo;

@end
