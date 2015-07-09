//
//  WPPaymentToken.h
//  WePay
//
//  Created by Chaitanya Bagaria on 11/7/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A \ref WPPaymentToken represents payment information that was obtained from the user and is stored on WePay's servers. This token can be used to complete the payment transaction via WePay's web APIs.
 */
@interface WPPaymentToken : NSObject

/**
 *  The token's id.
 */
@property (nonatomic, strong, readonly) NSString* tokenId;

/**
 *  Initialzes a \ref WPPaymentToken with the Id provided.
 *
 *  @param tokenId The Id of the token.
 *
 *  @return A \ref WPPaymentToken object initialized with the Id provided.
 */
- (instancetype) initWithId:(NSString* )tokenId;


@end
