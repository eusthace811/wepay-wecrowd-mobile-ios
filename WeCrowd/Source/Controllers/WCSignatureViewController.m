//
//  WCSignatureViewController.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/15/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCSignatureViewController.h"
#import "WCWePayManager.h"
#import "WCDonationManager.h"

@interface WCSignatureViewController () <WPCheckoutDelegate>

// Explicit reference
@property (strong, nonatomic) IBOutlet PPSSignatureView *signatureView;

@end

@implementation WCSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.signatureView.layer setBorderWidth:2];
    [self.signatureView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
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


- (IBAction) submitSignatureAction:(id) sender
{
    [[WCWePayManager sharedInstance] storeSignatureImage:self.signatureView.signatureImage
                                           forCheckoutID:[WCDonationManager sharedManager].checkoutID
                                       signatureDelegate:self];
}

- (void) didStoreSignature:(NSString *) signatureUrl forCheckoutId:(NSString *) checkoutId
{
    NSLog(@"Success: SignatureViewController: Stored signature at URL %@.", signatureUrl);
}

- (void) didFailToStoreSignatureImage:(UIImage *) image
                        forCheckoutId:(NSString *) checkoutId
                            withError:(NSError *) error
{
    NSLog(@"Error: SignatureViewController: %@.", [error localizedDescription]);
}

@end
