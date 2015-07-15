//
//  WCWePayManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WCCreditCardModel;

@interface WCWePayManager : NSObject

+ (instancetype) sharedInstance;

- (void) tokenizeCreditCardWithInfo:(WCCreditCardModel *) info
                     isMerchantUser:(BOOL) isMerchantUser
                              email:(NSString *) email
                           delegate:(id) delegate;

- (void) startCardReadTokenizationWithReaderDelegate:(id) readerDelegate
                                tokenizationDelegate:(id) tokenizationDelegate;

- (void) startCardReadWithDelegate:(id) readerDelegate;

- (void) storeSignatureImage:(UIImage *) signatureImage
               forCheckoutID:(NSString *) checkoutID
           signatureDelegate:(id) signatureDelegate;

@end
