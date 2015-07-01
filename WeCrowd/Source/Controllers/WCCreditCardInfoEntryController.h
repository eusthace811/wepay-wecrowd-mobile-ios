//
//  WCCreditCardInfoEntryView.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCCreditCardModel;

@interface WCCreditCardInfoEntryController : UIView

@property (nonatomic, strong, readonly) WCCreditCardModel *creditCardModel;

// TODO: Do these properties belong here?
@property (nonatomic, strong, readonly) NSString *donationAmount;
@property (nonatomic, strong, readonly) NSString *email;
// end

- (void) fillInModels;

@end
