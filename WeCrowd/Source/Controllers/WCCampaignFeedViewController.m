//
//  WCCampaignFeedViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/22/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCCampaignFeedViewController.h"
#import "WCCampaignHeaderModel.h"

static NSInteger const CAMPAIGN_FEED_SECTION_COUNT = 1;

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
                                                          endDate:nil donationTarget:0
                                                   donationAmount:0];
    testheaderModel = [[WCCampaignHeaderModel alloc] initWithCampaignBaseModel:testBaseModel
                                                                thumbnailImage:nil];
    self.campaigns = [NSMutableArray array];
    [self.campaigns addObject:testheaderModel];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return CAMPAIGN_FEED_SECTION_COUNT;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [self.campaigns count];
}

- (UITableViewCell *)tableView:(UITableView *) tableView
         cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CampaignCell" forIndexPath:indexPath];
    
    WCCampaignHeaderModel* headerModel = [self.campaigns objectAtIndex:indexPath.row];
    
    ((UILabel *) [cell viewWithTag:100]).text = headerModel.baseModel.title;
    
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

@end
