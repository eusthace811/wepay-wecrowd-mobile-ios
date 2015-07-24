//
//  WePay.h
//  WePay
//
//  Created by Chaitanya Bagaria on 10/30/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "WPAddress.h"
#import "WPConfig.h"
#import "WPPaymentInfo.h"
#import "WPPaymentToken.h"

@class WePay_CardReader;

@class WPConfig;
@class WPPaymentInfo;
@class WPPaymentToken;

// Environments
extern NSString * const kWPEnvironmentStage;
extern NSString * const kWPEnvironmentProduction;

// Payment Methods
extern NSString * const kWPPaymentMethodSwipe;
extern NSString * const kWPPaymentMethodManual;

// Card Reader status
extern NSString * const kWPCardReaderStatusNotConnected;
extern NSString * const kWPCardReaderStatusConnected;
extern NSString * const kWPCardReaderStatusWaitingForSwipe;
extern NSString * const kWPCardReaderStatusSwipeDetected;
extern NSString * const kWPCardReaderStatusTokenizing;
extern NSString * const kWPCardReaderStatusStopped;


/** \protocol WPTokenizationDelegate
 *  This delegate protocol has to be adopted by any class that handles tokenization responses.
 */
@protocol WPTokenizationDelegate <NSObject>

/**
 *  Called when a tokenization call succeeds.
 *
 *  @param paymentInfo  The payment token to be used for completing the transaction.
 *  @param paymentToken The payment token representing the payment info.
 */
- (void) paymentInfo:(WPPaymentInfo *)paymentInfo
         didTokenize:(WPPaymentToken *)paymentToken;

/**
 *  Called when a tokenization call fails.
 *
 *  @param paymentInfo The payment info that was provided while making the tokenization call.
 *  @param error       The error which caused the failure.
 */
- (void) paymentInfo:(WPPaymentInfo *)paymentInfo
 didFailTokenization:(NSError *)error;

@end


/** \protocol WPCardReaderDelegate
 *  This delegate protocol has to be adopted by any class that handles Card Reader responses.
 */
@protocol WPCardReaderDelegate <NSObject>

/**
 *  Called when payment info is successfully obtained from a card.
 *
 *  @param paymentInfo The payment info.
 */
- (void) didReadPaymentInfo:(WPPaymentInfo *)paymentInfo;

/**
 *  Called when an error occurs while reading a card.
 *
 *  @param error The error which caused the failure.
 */
- (void) didFailToReadPaymentInfoWithError:(NSError *)error;

/**
 *  Called when the card reader changes status.
 *
 *  @param status Current status of the card reader, one of (kWPCardReaderStatusNotConnected, kWPCardReaderStatusConnected, kWPCardReaderStatusWaitingForSwipe, kWPCardReaderStatusSwipeDetected, kWPCardReaderStatusTokenizing, kWPCardReaderStatusStopped).
 */
- (void) cardReaderDidChangeStatus:(id)status;


@end


/** \protocol WPCheckoutDelegate
 *  This delegate protocol has to be adopted by any class that handles Checkout responses.
 */
@protocol WPCheckoutDelegate <NSObject>

/**
 *  Called when a signature is successfully stored for the given checkout id.
 *
 *  @param signatureUrl The url for the signature image.
 *  @param checkoutId   The checkout id associated with the signature.
 */
- (void) didStoreSignature:(NSString *)signatureUrl
             forCheckoutId:(NSString *)checkoutId;

/**
 *  Called when an error occurs while storing a signature.
 *
 *  @param image        The signature image to be stored.
 *  @param checkoutId   The checkout id associated with the signature.
 *  @param error        The error which caused the failure.
 */
- (void) didFailToStoreSignatureImage:(UIImage *)image
                        forCheckoutId:(NSString *)checkoutId
                            withError:(NSError *)error;


@end


/**
 *  Main Class containing all public endpoints.
 */
@interface WePay : NSObject

/**
 *  Your WePay config
 */
@property (nonatomic, strong, readonly) WPConfig *config;

/** @name Initialization
 */
///@{

/**
 *  The designated intializer. Use this to initialize the SDK.
 *
 *  @param config A \ref WPConfig instance.
 *
 *  @return A \ref WePay instance, which can be used to access most of the functionality of this sdk.
 */
- (instancetype) initWithConfig:(WPConfig *)config;

///@}

#pragma mark -
#pragma mark Tokenization


/** @name Tokenization
 */
///@{

/**
 *  Creates a payment token from a WPPaymentInfo object.
 *
 *  @param paymentInfo          The payment info obtained from the user in any form.
 *  @param tokenizationDelegate The delegate class which will receive the tokenization response(s) for this call.
 */
- (void) tokenizePaymentInfo:(WPPaymentInfo *)paymentInfo
        tokenizationDelegate:(id<WPTokenizationDelegate>)tokenizationDelegate;

///@}

#pragma mark -
#pragma mark Card Reader

/** @name Card Reader related methods
 */
///@{

/**
 *  Initializes the card reader for reading card info.
 *
 *  The card reader will wait 60 seconds for a card, and then return a timout error if a card is not detected.
 *  The card reader will automatically stop waiting for card if:
 *  - a timeout occurs
 *  - a card is successfully detected
 *  - an unexpected error occurs
 *  - stopCardReader is called
 *
 *  However, if a general error (domain:kWPErrorCategoryCardReader, errorCode:WPErrorCardReaderGeneralError) occurs while reading, after a few seconds delay, the card reader will automatically start waiting again for another 60 seconds. At that time, WPCardReaderDelegate's cardReaderDidChangeStatus: method will be called with kWPCardReaderStatusWaitingForSwipe, and the user can try to use the card reader again. This behavior can be configured with \ref WPConfig.
 *
 *  WARNING: When this method is called, a (normally inaudible) signal is sent to the headphone jack of the phone, where the card reader is expected to be connected. If headphones are connected instead of the card reader, they may emit a very loud audible tone on receiving this signal. This method should only be called when the user intends to use the card reader.
 *
 *  @param cardReaderDelegate   The delegate class which will receive the response(s) for this call.
 */
- (void) startCardReaderForReadingWithCardReaderDelegate:(id<WPCardReaderDelegate>) cardReaderDelegate;

/**
 *  The card reader will wait 60 seconds for a card, and then return a timout error if a card is not detected.
 *  The card reader will automatically stop waiting for card if:
 *  - a timeout occurs
 *  - a card is successfully detected
 *  - an unexpected error occurs
 *  - stopCardReader is called
 *
 *  However, if a general error (domain:kWPErrorCategoryCardReader, errorCode:WPErrorCardReaderGeneralError) occurs while reading, after a few seconds delay, the card reader will automatically start waiting again for another 60 seconds. At that time, WPCardReaderDelegate's cardReaderDidChangeStatus: method will be called with kWPCardReaderStatusWaitingForSwipe, and the user can try to use the card reader again. This behavior can be configured with \ref WPConfig.
 *
 *  WARNING: When this method is called, a (normally inaudible) signal is sent to the headphone jack of the phone, where the card reader is expected to be connected. If headphones are connected instead of the card reader, they may emit a very loud audible tone on receiving this signal. This method should only be called when the user intends to use the card reader.
 *
 *  @param cardReaderDelegate   The delegate class which will receive the response(s) for this call.
 *  @param tokenizationDelegate The delegate class which will receive the tokenization response(s) for this call.
 */
- (void) startCardReaderForTokenizingWithCardReaderDelegate:(id<WPCardReaderDelegate>) cardReaderDelegate
                                       tokenizationDelegate:(id<WPTokenizationDelegate>) tokenizationDelegate;

/**
 *  Stops the card reader. In response, WPCardReaderDelegate's cardReaderDidChangeStatus: method will be called with kWPCardReaderStatusStopped.
 *  Any tokenization in progress will not be stopped, and its result will be delivered to the WPTokenizationDelegate.
 */
- (void) stopCardReader;

///@}

#pragma mark -
#pragma mark Checkout

/** @name Checkout related methods
 */
///@{

/**
 *  Stores a signature image associated with a checkout id on WePay's servers.
 *  The signature can be retrieved via a server-to-server call that fetches the checkout object.
 *  The aspect ratio (width:height) of the image must be between 1:4 and 4:1.
 *  If needed, the image will internally be scaled to fit inside 256x256 pixels, while maintaining the original aspect ratio.
 *
 *  @param image                The signature image to be stored.
 *  @param checkoutId           The checkout id associated with this transaction.
 *  @param checkoutDelegate     The delegate class which will receive the response(s) for this call.
 */
- (void) storeSignatureImage:(UIImage *)image
               forCheckoutId:(NSString *)checkoutId
            checkoutDelegate:(id<WPCheckoutDelegate>) checkoutDelegate;

///@}

@end
