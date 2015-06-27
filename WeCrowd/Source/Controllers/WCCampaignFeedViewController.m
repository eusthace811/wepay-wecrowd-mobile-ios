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

// UITableViewCell identifiers
static NSString* const kCampaignCellReuseIdentifier = @"CampaignCell";

@interface WCCampaignFeedViewController ()

@property (nonatomic, strong, readwrite) NSArray *campaigns;
@property (nonatomic, weak, readwrite) NSString *selectedCampaignID;

@end

@implementation WCCampaignFeedViewController

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    WCUserModel *currentUser = [WCLoginManager currentUser];
    
    // Fetch the campaigns for the logged in user if it exists,
    // otherwise fetch all the campaigns for the anonymous user
    if (currentUser) {
        [WCClient fetchAllCampaignsForUser:currentUser.userID
                                 withToken:currentUser.token
                           completionBlock:^(NSArray *campaigns, NSError *error) {
                               if (error) {
                                   // TODO: alert the user that campaign fetching failed
                               } else {
                                   self.campaigns = campaigns;
                                   
                                   // Force a refresh of the table since we can't guarantee
                                   // when the request will finish until this block
                                   [self.tableView reloadData];
                               }
                           }];
    } else {
        [WCClient fetchAllCampaigns:^(NSArray *campaigns, NSError *error) {
            if (error) {
                // TODO: alert the user that campaign fetching failed
            } else {
                self.campaigns = campaigns;
                
                // Force a refresh of the table since we can't guarantee
                // when the request will finish until this block
                [self.tableView reloadData];
            }
        }];
    }
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
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kIBSegueEntryToCampaignFeed]) {
        self.delegate = [segue destinationViewController];
        
        [self.delegate campaignFeedViewController:self
                          didSelectCampaignWithID:self.selectedCampaignID];
    }
}

@end
