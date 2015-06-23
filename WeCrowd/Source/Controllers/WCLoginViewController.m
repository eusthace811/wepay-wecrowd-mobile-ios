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


@interface WCLoginViewController ()

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
    NSDictionary* loginInformation = @{ @"email"    : self.emailField.text,
                                        @"password" : self.passwordField.text };
    
    [WCClient makePostRequestToEndPoint:[WCClient apiURLWithEndpoint:@"/login"]
                                 values:loginInformation
                            accessToken:nil
                           successBlock:^(NSDictionary *returnData) {
                               NSLog(@"Do something with the return data");
                           } errorHandler:^(NSError *error) {
                               NSLog(@"Error: don't know how to handle it yet");
                           }
     ];
}


@end
