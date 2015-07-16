//
//  WCPaymentFlowDelegate.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/15/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#ifndef WeCrowd_WCPaymentFlowDelegate_h
#define WeCrowd_WCPaymentFlowDelegate_h

@protocol PaymentFlowDelegate <NSObject>

- (void) didFinishWithSender:(id) sender;

@end

#endif
