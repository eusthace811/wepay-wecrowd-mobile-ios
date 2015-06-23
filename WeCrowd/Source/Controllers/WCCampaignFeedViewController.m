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
static NSInteger const kCampaignCellTitleTag = 100;

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
    return kCampaignFeedSectionCount;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [self.campaigns count];
}

- (UITableViewCell *)tableView:(UITableView *) tableView
         cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCampaignCellReuseIdentifier
                                                            forIndexPath:indexPath];
    
    WCCampaignHeaderModel* headerModel = [self.campaigns objectAtIndex:indexPath.row];
    
    ((UILabel *) [cell viewWithTag:kCampaignCellTitleTag]).text = headerModel.baseModel.title;
    
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
