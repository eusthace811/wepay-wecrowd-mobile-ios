//
//  WCAlert.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCAlert.h"

@implementation WCAlert

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

+ (void) showAlertWithOptionFromViewController:(UIViewController *) viewController
                                     withTitle:(NSString *) title
                                       message:(NSString *) message
                                   optionTitle:(NSString *) optionTitle
                              optionCompletion:(void (^) ()) optionCompletion
                               closeCompletion:(void (^) ()) closeCompletion
{
    UIAlertController *alertController;
    UIAlertAction *alternateAction, *closeAction;
    
    alertController = [UIAlertController alertControllerWithTitle:title
                                                          message:message
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    alternateAction = [UIAlertAction actionWithTitle:optionTitle
                                               style:UIAlertActionStyleDefault
                                             handler:optionCompletion];
    closeAction = [UIAlertAction actionWithTitle:@"Close"
                                           style:UIAlertActionStyleCancel
                                         handler:closeCompletion];
    
    [alertController addAction:alternateAction];
    [alertController addAction:closeAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void) showTimeoutAlertFromViewController:(UIViewController *) viewController
                        fromActionWithTitle:(NSString *) title
                            retryCompletion:(void (^) ()) retryCompletion
                            closeCompletion:(void (^) ()) closeCompletion
{
    NSString *alertTitle, *message;
    
    alertTitle = [title stringByAppendingString:@" timed out"];
    message = [NSString stringWithFormat:@"The process timed out. Please check your connection and try again"];
    
    [self showAlertWithOptionFromViewController:viewController
                                      withTitle:alertTitle
                                        message:message
                                    optionTitle:@"Retry"
                               optionCompletion:retryCompletion
                                closeCompletion:closeCompletion];
}


@end
