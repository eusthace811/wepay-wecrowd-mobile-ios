//
//  WCManualPaymentViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/30/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCManualPaymentViewController.h"
#import "WCWePayManager.h"

@interface WCManualPaymentViewController ()

@property (weak, nonatomic) IBOutlet UITextField *donationAmountField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *expiryMonthField;
@property (weak, nonatomic) IBOutlet UITextField *expiryYearField;
@property (weak, nonatomic) IBOutlet UITextField *expiryZipField;


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
    
}

@end
