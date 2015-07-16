//
//  WCSignatureViewController.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/15/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSSignatureView.h"
#import "WCPaymentFlowDelegate.h"

@interface WCSignatureViewController : UITableViewController

@property (nonatomic, weak, readwrite) id<PaymentFlowDelegate> delegate;

@end
