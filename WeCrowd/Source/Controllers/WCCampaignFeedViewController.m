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

// UITableViewDataSource
static NSInteger const kCampaignFeedSectionCount = 1;

// UITableViewCell tags
static NSInteger const kCampaignCellTitleTag          = 100;
static NSInteger const kCampaignCellTimeRemainingTag  = 101;
static NSInteger const kCampaignCellPledgeGoalTag     = 102;
static NSInteger const kCampaignCellThumbnailImageTag = 103;

// UITableViewCell identifiers
static NSString* const kCampaignCellReuseIdentifier = @"CampaignCell";

@interface WCCampaignFeedViewController ()

@property (nonatomic, strong) NSArray *campaigns;

@end

@implementation WCCampaignFeedViewController

#pragma mark - UITableViewController

- (id) initWithCoder:(NSCoder *) aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        WCUser *currentUser = [WCLoginManager currentUser];
        
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
    }
    
    return self;
}

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
    return kCampaignFeedSectionCount;
}

- (NSInteger) tableView:(UITableView *) tableView
  numberOfRowsInSection:(NSInteger) section
{
    return [self.campaigns count];
}

- (UITableViewCell *) tableView:(UITableView *) tableView
          cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCampaignCellReuseIdentifier
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell withModel:[self.campaigns objectAtIndex:indexPath.row]];
    
    
    return cell;
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

@end
