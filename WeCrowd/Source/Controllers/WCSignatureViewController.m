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
#import "WCAlert.h"
#import "CWStatusBarNotification.h"

@interface WCSignatureViewController () <WPCheckoutDelegate>

@property (strong, nonatomic) IBOutlet PPSSignatureView *signatureView;

@property (nonatomic, strong, readwrite) CWStatusBarNotification *notification;

@end

@implementation WCSignatureViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpNotification];
    } else {
        // Do nothing
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];

    [self styleSignatureView];
}

- (void) didReceiveMemoryWarning {
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
    [self storeSignature];
}

#pragma mark - WPCheckoutDelegate

- (void) didStoreSignature:(NSString *) signatureUrl forCheckoutId:(NSString *) checkoutId
{
    [self.notification displayNotificationWithMessage:@"Signature Stored!" forDuration:3];
    
    [self.delegate didFinishWithSender:self];
    
    NSLog(@"Success: SignatureViewController: Stored signature at URL %@.", signatureUrl);
}

- (void) didFailToStoreSignatureImage:(UIImage *) image
                        forCheckoutId:(NSString *) checkoutId
                            withError:(NSError *) error
{
    [WCAlert showAlertWithOptionFromViewController:self
                                         withTitle:@"Unable to store signature."
                                           message:[NSString stringWithFormat:@"Storing the signature failed. %@", [error localizedDescription]]
                                       optionTitle:@"Try Again"
                                  optionCompletion:^{
                                      [self storeSignature];
                                  }
                                   closeCompletion:nil];
    
    NSLog(@"Error: SignatureViewController: %@.", [error localizedDescription]);
}

#pragma mark - Helpers

- (void) styleSignatureView
{
    UIColor *borderColor;
    
    borderColor = [UIColor colorWithCIColor:[CIColor colorWithString:@"0.4 0.737 0.894"]];
    
    [self.signatureView.layer setBorderWidth:1];
    [self.signatureView.layer setBorderColor:borderColor.CGColor];
}

- (void) storeSignature
{
    [[WCWePayManager sharedInstance] storeSignatureImage:self.signatureView.signatureImage
                                           forCheckoutID:[WCDonationManager sharedManager].checkoutID
                                       signatureDelegate:self];
}

- (void) setUpNotification
{
    UIColor *backgroundColor;
    
    backgroundColor = [UIColor colorWithCIColor:[CIColor colorWithString:@"0.337 0.8 0.38"]];
    
    self.notification = [CWStatusBarNotification new];
    
    self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
    self.notification.notificationLabelFont = [UIFont systemFontOfSize:26];
    self.notification.notificationLabelTextColor = [UIColor whiteColor];
    self.notification.notificationLabelBackgroundColor = backgroundColor;
}

@end
