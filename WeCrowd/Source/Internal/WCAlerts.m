//
//  WCAlerts.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCAlerts.h"

@implementation WCAlerts

+ (void) showSimpleAlertFromViewController:(UIViewController *) viewController
                                 withTitle:(NSString *) title
                                   message:(NSString *) message
                                completion:(void (^)()) completion
{
    UIAlertController *alertController;
    UIAlertAction *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:title
                                                          message:message
                                                   preferredStyle:UIAlertControllerStyleAlert];
    closeAction = [UIAlertAction actionWithTitle:@"Close"
                                           style:UIAlertActionStyleCancel
                                         handler:nil];
    
    [alertController addAction:closeAction];
    
    [viewController presentViewController:alertController animated:YES completion:completion];
}

@end
