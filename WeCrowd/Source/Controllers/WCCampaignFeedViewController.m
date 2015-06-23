//
//  WCCampaignFeedViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/22/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignFeedViewController.h"
#import "WCCampaignHeaderModel.h"

// UITableViewDataSource
static NSInteger const kCampaignFeedSectionCount = 1;

// UITableViewCell tags
static NSInteger const kCampaignCellTitleTag         = 100;
static NSInteger const kCampaignCellTimeRemainingTag = 101;
static NSInteger const kCampaignCellPledgeGoalTag    = 102;
static NSInteger const kCampaignCellHeaderImageTag   = 103;

// UITableViewCell identifiers
static NSString* const kCampaignCellReuseIdentifier = @"CampaignCell";

@interface WCCampaignFeedViewController ()

@property (nonatomic, strong) NSMutableArray* campaigns;

@end

@implementation WCCampaignFeedViewController

#pragma mark - UIViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    WCCampaignBaseModel* testBaseModel;
    WCCampaignHeaderModel* testheaderModel;
    
    testBaseModel = [[WCCampaignBaseModel alloc] initWithCampaign:@"ID"
                                                            title:@"Title Test"
                                                          endDate:nil
                                                   donationTarget:100
                                                   donationAmount:10];
    // TODO: use thumbnail image from server
    testheaderModel = [[WCCampaignHeaderModel alloc] initWithCampaignBaseModel:testBaseModel
                                                                thumbnailImage:[UIImage imageNamed:@"Logo"]];
    self.campaigns = [NSMutableArray array];
    [self.campaigns addObject:testheaderModel];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return kCampaignFeedSectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Configuration Methods

- (void) configureCell:(UITableViewCell *) cell
             withModel:(WCCampaignHeaderModel *) model
{
    NSDateFormatter* standardDateFormat = [NSDateFormatter new];
    NSString* timeRemaining, *pledgeProgress;
    
    // format the view information
    [standardDateFormat setDateStyle:NSDateFormatterShortStyle];
    // TODO: use end date from server
    timeRemaining = [NSString stringWithFormat:@"Ends %@", [standardDateFormat stringFromDate:[NSDate date]]];
    pledgeProgress = [NSString stringWithFormat:@"%.f", model.baseModel.donationTargetAmount / model.baseModel.donationAmount];
    pledgeProgress = [pledgeProgress stringByAppendingString:@"%"];
    
    
    // configure the display information within the view
    ((UILabel *) [cell viewWithTag:kCampaignCellTitleTag]).text = model.baseModel.title;
    ((UILabel *) [cell viewWithTag:kCampaignCellTimeRemainingTag]).text = timeRemaining;
    ((UILabel *) [cell viewWithTag:kCampaignCellPledgeGoalTag]).text = pledgeProgress;
    ((UIImageView *) [cell viewWithTag:kCampaignCellHeaderImageTag]).image = model.thumbnailImage;
}
    

@end
