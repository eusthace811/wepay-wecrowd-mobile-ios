//
//  WCSwiperViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/29/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCSwiperViewController.h"
#import "MBProgressHUD.h"

@interface WCSwiperViewController ()

@property (weak, nonatomic) IBOutlet UILabel *swiperStatusLabel;

@end

@implementation WCSwiperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Test
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
