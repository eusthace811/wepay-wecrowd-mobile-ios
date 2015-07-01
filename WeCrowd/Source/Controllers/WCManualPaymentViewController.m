//
//  WCManualPaymentViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCManualPaymentViewController.h"
#import "WCWePayManager.h"
#import "WCCreditCardInfoEntryController.h"

@interface WCManualPaymentViewController ()

@property (weak, nonatomic) IBOutlet WCCreditCardInfoEntryController *creditCardInfoEntryController;

@end

@implementation WCManualPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitInformationAction:(id) sender
{
    [self.creditCardInfoEntryController fillInModels];
}

@end
