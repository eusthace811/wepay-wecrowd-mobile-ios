//
//  WCPaymentViewController.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/6/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStatusBarNotification.h"
#import "WCPaymentFlowDelegate.h"

@interface WCPaymentViewController : UITableViewController

@property (nonatomic, weak, readwrite) id<PaymentFlowDelegate> delegate;
@property (nonatomic, strong, readonly) CWStatusBarNotification *statusBarNotification;

- (void) pushSignatureView;

@end
