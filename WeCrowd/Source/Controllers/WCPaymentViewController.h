//
//  WCPaymentViewController.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/6/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCPaymentViewController;

@protocol PaymentViewDelegate <NSObject>

- (void) didFinishPaymentWithSender:(WCPaymentViewController *) sender;

@end

@interface WCPaymentViewController : UIViewController

@property (nonatomic, weak, readwrite) id<PaymentViewDelegate> delegate;

@end
