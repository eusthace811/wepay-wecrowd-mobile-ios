//
//  WCCreditCardInfoEntryView.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCCreditCardModel;

@interface WCCreditCardInfoEntryController : NSObject

// TODO: Do these properties belong here?
@property (nonatomic, weak, readonly) NSString *donationAmount;
@property (nonatomic, weak, readonly) NSString *email;
// end

@property (nonatomic, strong, readonly) WCCreditCardModel *creditCardModel;

@end
