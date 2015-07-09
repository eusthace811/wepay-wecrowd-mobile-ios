//
//  WPPaymentInfo.h
//  WePay
//
//  Created by Chaitanya Bagaria on 11/5/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPAddress.h"
/** 
 *  An instance of this class represents the payment information obtained from the user via any of the supported payment methods. It is used as input for tokenization operations.
 */
@interface WPPaymentInfo : NSObject

/**
 *  First name of the payer.
 */
@property (nonatomic, strong, readonly) NSString *firstName;

/**
 *  Last name of the payer.
 */
@property (nonatomic, strong, readonly) NSString *lastName;

/**
 *  Email address of the payer.
 */
@property (nonatomic, strong, readonly) NSString *email;

/**
 *  Masked representation of the payment instrument. e.g. 4242XXXXXXXX1234
 */
@property (nonatomic, strong, readonly) NSString *paymentDescription;

/**
 *  Determines if the card was obtained in virtual terminal mode.
 */
@property (nonatomic, readonly) BOOL isVirtualTerminal;

/**
 *  Billing address.
 */
@property (nonatomic, strong, readonly) WPAddress *billingAddress;

/**
 *  Shipping address.
 */
@property (nonatomic, strong, readonly) WPAddress *shippingAddress;

/**
 *  The payment method used, one of (kWPPaymentMethodManual, kWPPaymentMethodSwipe).
 */
@property (nonatomic, strong, readonly) id paymentMethod;

/**
 *  Additional info obtained by using the Swipe payment method.
 */
@property (nonatomic, strong, readonly) id swiperInfo;

/**
 *  Additional info obtained by using the Manual payment method.
 */
@property (nonatomic, strong, readonly) id manualInfo;

/** \internal
 *  Intializes a \ref WPPaymentInfo instance with card info obtained from the swiper.
 *
 *  @param swipedInfo Card info obtained from the swiper.
 *
 *  @return A \ref WPPaymentInfo object initialized with card info obtained from the swiper.
 */
- (instancetype) initWithSwipedInfo:(id)swipedInfo;

/**
 *  Initializes a WPPaymentInfo instance of type \ref kWPPaymentMethodManual.
 *
 *  @param firstName       First name of the payer.
 *  @param lastName        Last name of the payer.
 *  @param email           Email address of the payer.
 *  @param billingAddress  Billing address.
 *  @param shippingAddress Shipping address.
 *  @param cardNumber      The card number.
 *  @param cvv             The cvv code.
 *  @param expMonth        The 2-digit expiration month on the credit card.
 *  @param expYear         The 4-digit expiration year on the credit card.
 *  @param virtualTerminal The virtual terminal flag - should be false if payment info was collected on the payer's device.
 *
 *  @return A \ref WPPaymentInfo object initialized with manually obtained card info.
 */
- (instancetype) initWithFirstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                             email:(NSString *)email
                    billingAddress:(WPAddress *)billingAddress
                   shippingAddress:(WPAddress *)shippingAddress
                        cardNumber:(NSString *)cardNumber
                               cvv:(NSString *)cvv
                          expMonth:(NSString *)expMonth
                           expYear:(NSString *)expYear
                   virtualTerminal:(BOOL)virtualTerminal;

/**
 *  Allows adding an email if one is not already present. The call will be ignored if an email is already present.
 *
 *  @param email the email address to be added
 */
- (void) addEmail:(NSString *)email;


@end
