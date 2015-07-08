//
//  WCPaymentViewController.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/6/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStatusBarNotification.h"

@class WCPaymentViewController;

@protocol PaymentViewDelegate <NSObject>

- (void) didFinishWithSender:(WCPaymentViewController *) sender;

@end

@interface WCPaymentViewController : UIViewController

@property (nonatomic, weak, readwrite) id<PaymentViewDelegate> delegate;
@property (nonatomic, strong, readonly) CWStatusBarNotification *statusBarNotification;

@end
