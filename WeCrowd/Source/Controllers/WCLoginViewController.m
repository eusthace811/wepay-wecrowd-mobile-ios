//
//  WCLoginViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCLoginViewController.h"
#import "WCLoginManager.h"
#import "WCCampaignFeedViewController.h"


#pragma mark - Interface

@interface WCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField* emailField;
@property (weak, nonatomic) IBOutlet UITextField* passwordField;

@end


#pragma mark - Implementation

@implementation WCLoginViewController

#pragma mark - IBOutlets

- (IBAction) login:(id) sender {
    NSString *username, *password;
    
    #ifdef DEBUG
    username = @"zachv+3@wepay.com";
    password = @"password";
    #else
    username = self.emailField.text;
    password = self.passwordField.text;
    #endif

    [WCLoginManager loginUserWithUsername:username
                                 password:password
                          completionBlock:^(NSError *error)
    {
        if (error) {
            // Notify the user of the error
            [[[UIAlertView alloc] initWithTitle:@"Please try again"
                                        message:@"Unable to log you in. Please check your\
              information and try again."
                                       delegate:self
                              cancelButtonTitle:@"Close"
                              otherButtonTitles:nil] show];
        } else {
            // Disable the control and push the next view
            ((UIControl *) sender).userInteractionEnabled = false;
            
            [self performSegueWithIdentifier:@"entryViewToFeedViewSegue" sender:self];
        }
    }];
}

@end
