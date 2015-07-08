//
//  WCAlerts.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAlerts : NSObject

+ (void) showSimpleAlertFromViewController:(UIViewController *) viewController
                                 withTitle:(NSString *) title
                                   message:(NSString *) message
                                completion:(void (^) ()) completion;

+ (void) showAlertWithOptionsFromViewController:(UIViewController *) viewController
                                      withTitle:(NSString *) title
                                        message:(NSString *) message
                           alternateOptionTitle:(NSString *) alternateTitle
                            alternateCompletion:(void (^) ()) alternateCompletion
                                closeCompletion:(void (^) ()) closeCompletion;
@end
