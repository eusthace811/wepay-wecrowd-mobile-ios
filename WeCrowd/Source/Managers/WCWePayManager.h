//
//  WCWePayManager.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WePay/WePay.h>

@interface WCWePayManager : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic, strong, readonly) WePay *wepay;

@end
