//
//  WCSignatureViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/15/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCSignatureViewController.h"
#import <WePay/WePay.h>

@interface WCSignatureViewController () <WPCheckoutDelegate>

// Explicit reference
@property (strong, nonatomic) IBOutlet PPSSignatureView *signatureView;

@end

@implementation WCSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Storyboard

- (IBAction) clearSignatureAction:(id) sender
{
    [self.signatureView erase];
}


- (IBAction)submitSignatureAction:(id) sender
{

}

- (void) didStoreSignature:(NSString *) signatureUrl forCheckoutId:(NSString *) checkoutId
{
    
}

- (void) didFailToStoreSignatureImage:(UIImage *) image
                        forCheckoutId:(NSString *) checkoutId
                            withError:(NSError *) error
{
    
}

@end
