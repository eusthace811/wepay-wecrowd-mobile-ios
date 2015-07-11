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
#import "WCAlerts.h"

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
            // Notify the user of the error
            [WCAlerts showSimpleAlertFromViewController:self
                                              withTitle:@"Please try again"
                                                message:@"Unable to log you in. Please check your information and try again."
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

@end
