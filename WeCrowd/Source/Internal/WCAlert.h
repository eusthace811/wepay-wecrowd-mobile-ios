//
//  WCAlert.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAlert : NSObject

+ (void) showSimpleAlertFromViewController:(UIViewController *) viewController
                                 withTitle:(NSString *) title
                                   message:(NSString *) message
                                completion:(void (^) ()) completion;

+ (void) showAlertWithOptionFromViewController:(UIViewController *) viewController
                                     withTitle:(NSString *) title
                                       message:(NSString *) message
                                   optionTitle:(NSString *) optionTitle
                              optionCompletion:(void (^) ()) optionCompletion
                               closeCompletion:(void (^) ()) closeCompletion;

+ (void) showTimeoutAlertFromViewController:(UIViewController *) viewController
                        fromActionWithTitle:(NSString *) title
                            retryCompletion:(void (^) ()) retryCompletion
                            closeCompletion:(void (^) ()) closeCompletion;

@end
