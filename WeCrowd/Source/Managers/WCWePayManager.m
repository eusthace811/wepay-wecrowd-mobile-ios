//
//  WCWePayManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCWePayManager.h"
#import "WCCreditCardModel.h"

#import <WePay/WePay.h>

@interface WCWePayManager ()

@property (nonatomic, strong, readwrite) WePay *wepay;

@end

@implementation WCWePayManager

#pragma mark - Interface Methods

+ (instancetype) sharedInstance
{
    static WCWePayManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        WPConfig *config;
        
        // Use the example app client ID suitable for testing
        config = [[WPConfig alloc] initWithClientId:@"58670" // Prod: @"119400"
                                        environment:kWPEnvironmentStage];
        instance = [WCWePayManager new];
        instance.wepay = [[WePay alloc] initWithConfig:config];
    });
    
    return instance;
}

- (void) tokenizeCreditCardWithInfo:(WCCreditCardModel *) info
                     isMerchantUser:(BOOL) isMerchantUser
                              email:(NSString *) email
                           delegate:(id) delegate
{
    WPPaymentInfo *paymentInfo;
    WPAddress *address;
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSString *month, *year;

    // Extract the needed parameters from the credit card model
    address = [[WPAddress alloc] initWithZip:info.zipCode];

    formatter.dateFormat = @"MM";
    month = [formatter stringFromDate:info.expirationDate];
    formatter.dateFormat = @"yyyy";
    year = [formatter stringFromDate:info.expirationDate];

    paymentInfo = [[WPPaymentInfo alloc] initWithFirstName:info.firstName
                                                  lastName:info.lastName
                                                     email:email
                                            billingAddress:address
                                           shippingAddress:nil
                                                cardNumber:info.cardNumber
                                                       cvv:info.cvvNumber
                                                  expMonth:month
                                                   expYear:year
                                           virtualTerminal:isMerchantUser];
    
    [self.wepay tokenizePaymentInfo:paymentInfo tokenizationDelegate:delegate];
}

@end
