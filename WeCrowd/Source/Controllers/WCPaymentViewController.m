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
        self.statusBarNotification = [CWStatusBarNotification new];
    } else {
        // Do nothing
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
