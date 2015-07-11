//
//  WCCampaignFeedViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/22/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignFeedViewController.h"
#import "WCCampaignHeaderModel.h"
#import "WCLoginManager.h"
#import "WCClient.h"
#import "WCConstants.h"
#import "WCCampaignTableViewCell.h"
#import "WCAlerts.h"

// UITableViewCell identifiers
static NSString* const kCampaignCellReuseIdentifier = @"CampaignCell";

@interface WCCampaignFeedViewController ()

@property (nonatomic, strong, readwrite) NSArray *campaigns;
@property (nonatomic, weak, readwrite) NSString *selectedCampaignID;

@property (nonatomic, weak, readwrite) id<CampaignDetailDelegate> delegate;

@end

@implementation WCCampaignFeedViewController

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self executeCampaignFetch];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section
{
    return [self.campaigns count];
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    WCCampaignTableViewCell *cell;
    WCCampaignHeaderModel *model;
    
    cell = (WCCampaignTableViewCell *) [tableView dequeueReusableCellWithIdentifier:kCampaignCellReuseIdentifier
                                                                       forIndexPath:indexPath];
    model = [self.campaigns objectAtIndex:indexPath.row];
    
    [cell configureForCampaignHeader:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    WCCampaignHeaderModel *selectedCampaign = (WCCampaignHeaderModel *) [self.campaigns objectAtIndex:indexPath.row];
    
    self.selectedCampaignID = selectedCampaign.campaignID;
    
    [self performSegueWithIdentifier:kIBSegueCampaignFeedToCampaignDetail sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *) segue sender:(id) sender
{
    if ([segue.identifier isEqualToString:kIBSegueCampaignFeedToCampaignDetail]) {
        self.delegate = [segue destinationViewController];
        
        [self.delegate campaignFeedViewController:self
                          didSelectCampaignWithID:self.selectedCampaignID];
    }
}

#pragma mark - Helper Methods

- (void) executeCampaignFetch
{
    [WCClient fetchFeaturedCampaigns:^(NSArray *campaigns, NSError *error) {
            if (error) {
                [self showCampaignFeedError];
            } else {
                if ([WCLoginManager userType] == WCLoginUserPayer) {
                    self.campaigns = campaigns;
                } else {
                    self.campaigns = [campaigns subarrayWithRange:NSMakeRange(0, campaigns.count / 3)];
                }
                
                // Force a refresh of the table since we can't guarantee
                // when the request will finish until this block
                [self.tableView reloadData];
            }
        }];
}

- (void) showCampaignFeedError
{
    [WCAlerts showAlertWithOptionFromViewController:self
                                          withTitle:@"Unable to fetch campaigns."
                                            message:@"Could not retrieve the campaigns from the server"
                                        optionTitle:@"Try Again"
                                   optionCompletion:^{ [self executeCampaignFetch]; }
                                    closeCompletion:nil];
}

@end
