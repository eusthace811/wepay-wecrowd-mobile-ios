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

// UITableViewCell tags
static NSInteger const kCampaignCellTitleTag          = 100;
static NSInteger const kCampaignCellTimeRemainingTag  = 101;
static NSInteger const kCampaignCellPledgeGoalTag     = 102;
static NSInteger const kCampaignCellThumbnailImageTag = 103;

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
    
    WCUser *currentUser = [WCLoginManager currentUser];
    
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

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section
{
    return [self.campaigns count];
}

- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCampaignCellReuseIdentifier
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell withModel:[self.campaigns objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    WCCampaignHeaderModel *selectedCampaign = (WCCampaignHeaderModel *) [self.campaigns objectAtIndex:indexPath.row];
    
    self.selectedCampaignID = selectedCampaign.campaignID;
    
    [self performSegueWithIdentifier:kIBSegueCampaignFeedToCampaignDetail sender:self];
}

#pragma mark - Internal Helpers

- (void) configureCell:(UITableViewCell *) cell
             withModel:(WCCampaignHeaderModel *) model
{
    NSDateFormatter* standardDateFormat = [NSDateFormatter new];
    NSString* timeRemaining, *pledgeProgress;
    CGFloat pledgeProgressNum = model.donationAmount > 0 ? model.donationTargetAmount / model.donationAmount : 0;
    
    // format the view information
    [standardDateFormat setDateStyle:NSDateFormatterShortStyle];
    // TODO: use end date from server
    timeRemaining = [NSString stringWithFormat:@"Ends %@", [standardDateFormat stringFromDate:[NSDate date]]];
    pledgeProgress = [NSString stringWithFormat:@"%.f", pledgeProgressNum];
    pledgeProgress = [pledgeProgress stringByAppendingString:@"%"];
    
    // configure the display information within the view
    ((UILabel *) [cell viewWithTag:kCampaignCellTitleTag]).text = model.title;
    ((UILabel *) [cell viewWithTag:kCampaignCellTimeRemainingTag]).text = timeRemaining;
    ((UILabel *) [cell viewWithTag:kCampaignCellPledgeGoalTag]).text = pledgeProgress;
    ((UIImageView *) [cell viewWithTag:kCampaignCellThumbnailImageTag]).image = model.thumbnailImage;
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:]) {
        self.delegate = [segue destinationViewController];
        
        [self.delegate campaignFeedViewController:self
                          didSelectCampaignWithID:self.selectedCampaignID];
    }
}

@end
