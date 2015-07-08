//
//  WCPaymentViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/6/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCPaymentViewController.h"

@interface WCPaymentViewController ()

@property (nonatomic, strong, readwrite) CWStatusBarNotification *statusBarNotification;

@end

@implementation WCPaymentViewController

- (instancetype) initWithCoder:(NSCoder *) aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpStatusBarNotification];
    } else {
        // Do nothing
    }
    
    return self;
}

- (void) setUpStatusBarNotification
{
    UIColor *backgroundColor;
    
    backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithString:@"0.337 0.8 0.38"]];
    
    self.statusBarNotification = [CWStatusBarNotification new];
    
    self.statusBarNotification.notificationLabelTextColor = [UIColor whiteColor];
    self.statusBarNotification.notificationLabelBackgroundColor = backgroundColor;
}

@end
