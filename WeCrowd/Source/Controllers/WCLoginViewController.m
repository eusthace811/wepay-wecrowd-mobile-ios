//
//  WCLoginViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCClient.h"

#pragma mark - Interface


@interface WCLoginViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField* emailField;
@property (weak, nonatomic) IBOutlet UITextField* passwordField;

@end


#pragma mark - Implementation

@implementation WCLoginViewController

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBOutlets

- (IBAction) login: (id)sender {
    // Make the login request to the server
    NSDictionary* loginInformation = @{ @"user_email"   : self.emailField.text,
                                        @"password"     : self.passwordField.text };
    
    [WCClient makePostRequestToEndPoint:[WCClient apiURLWithEndpoint:@"/login"]
                                 values:loginInformation
                            accessToken:nil
                           successBlock:^(NSDictionary *returnData) {
                               // check the status of the return data
                               if ([returnData objectForKey:@"error_code"]) {
                                   // Alert the user of the error
                                   UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"Unable to login"
                                                                                        message:@"Unable to log you in. Please check your email and password before trying again."
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"Close"
                                                                              otherButtonTitles:nil];
                                   [errorAlert show];
                               } else {
                                   // Disable the control and push the next view
                                   ((UIControl *) sender).userInteractionEnabled = false;
                                   
                                   #ifdef DEBUG
                                   NSLog(@"Success: Login complete.");
                                   #endif
                               }
                           }
                           errorHandler:^(NSError *error) {
                               // This means there was either a connection error or a parse error
                               // In either case, just prompt the user to try again
                               UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                                                    message:@"Unable to log you in. Please try again."
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"Close"
                                                                          otherButtonTitles:nil];
                               [errorAlert show];
                           }
     ];
}


@end
