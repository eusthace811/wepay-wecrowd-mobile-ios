//
//  WCWelcomeViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCWelcomeViewController.h"
#import "WCLoginManager.h"
#import "WCConstants.h"

@interface WCWelcomeViewController ()

@end

@implementation WCWelcomeViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Logout whenever this view is presented
    [WCLoginManager logoutWithCompletionBlock:^(NSError *error) {
        if (!error) {
            // Don't need to do anything
        }
    }];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) viewCampaigns:(id) sender {
    [self performSegueWithIdentifier:kIBSegueEntryToCampaignFeed sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
