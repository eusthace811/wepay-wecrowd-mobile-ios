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

+ (void) showAlertWithOptionsFromViewController:(UIViewController *) viewController
                                      withTitle:(NSString *) title
                                        message:(NSString *) message
                           alternateOptionTitle:(NSString *) alternateTitle
                            alternateCompletion:(void (^) ()) alternateCompletion
                                closeCompletion:(void (^) ()) closeCompletion
{
    UIAlertController * alertController;
    UIAlertAction *alternateAction, *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:title
                                                          message:message
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    alternateAction = [UIAlertAction actionWithTitle:alternateTitle
                                               style:UIAlertActionStyleDefault
                                             handler:alternateCompletion];
    closeAction = [UIAlertAction actionWithTitle:@"Close"
                                           style:UIAlertActionStyleCancel
                                         handler:closeCompletion];
    
    [alertController addAction:alternateAction];
    [alertController addAction:closeAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


@end
