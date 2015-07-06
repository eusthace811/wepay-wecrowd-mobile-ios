//
//  WCWePayManager.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCWePayManager.h"

@interface WCWePayManager ()

@property (nonatomic, strong, readwrite) WePay *wepay;

@end

@implementation WCWePayManager

+ (instancetype) sharedInstance
{
    static WCWePayManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        WPConfig *config;
        
        // Use the example app client ID suitable for testing
        config = [[WPConfig alloc] initWithClientId:@"58670" // Prod: @"119400"
                                        environment:kWPEnvironmentStage];
        instance = [WCWePayManager new];
        instance.wepay = [[WePay alloc] initWithConfig:config];
    });
    
    return instance;
}

@end
