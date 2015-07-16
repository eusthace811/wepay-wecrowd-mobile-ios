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
#import "WCConstants.h"
#import "WCAlert.h"

#pragma mark - Interface

@interface WCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField* emailField;
@property (weak, nonatomic) IBOutlet UITextField* passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end


#pragma mark - Implementation

@implementation WCLoginViewController

- (void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    
    self.loginButton.userInteractionEnabled = YES;
}

#pragma mark - IBOutlets

- (IBAction) login:(id) sender {
    NSString *username, *password;
    
    username = self.emailField.text;
    password = self.passwordField.text;

    [WCLoginManager loginMerchantWithUsername:username
                                     password:password
                              completionBlock:^(NSError *error)
    {
        if (error) {
            NSString *message;
            
            message = [NSString stringWithFormat:@"Unable to log you in: %@. Please check your information and try again.", [error localizedDescription]];
            
            // Notify the user of the error
            [WCAlert showSimpleAlertFromViewController:self
                                              withTitle:@"Please try again"
                                                message:message
                                             completion:nil];
        } else {
            // Disable the control and push the next view
            if ([sender respondsToSelector:@selector(setUserInteractionEnabled:)]) {
                ((UIControl *) sender).userInteractionEnabled = NO;
            }
            
            [self performSegueWithIdentifier:kIBSegueEntryToCampaignFeed sender:self];
        }
    }];
}

#pragma mark - UIResponder

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
