//
//  WCConstants.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCConstants.h"

#pragma mark - API

// Endpoints
NSString* const kAPIEndpointLogin             = @"/login";
NSString* const kAPIEndpointCampaigns         = @"/campaigns";
NSString* const kAPIEndpointUsers             = @"/users";
NSString* const kAPIEndpointDonate            = @"/donate";
NSString* const kAPIEndpointFeaturedCampaigns = @"/featured_campaigns";

// Parameters - User
NSString* const kAPIUserIDKey    = @"user_id";
NSString* const kAPIUserTokenKey = @"token";
NSString* const kAPIEmailKey     = @"user_email";
NSString* const kAPIPasswordKey  = @"password";

// Parameters - Campaign
NSString* const kAPICampaignIDKey          = @"campaign_id";
NSString* const kAPICampaignNameKey        = @"campaign_name";
NSString* const kAPICampaignGoalKey        = @"campaign_goal";
NSString* const kAPICampaignProgressKey    = @"campaign_progress";
NSString* const kAPICampaignDescriptionKey = @"campaign_description";
NSString* const kAPICampaignImageURLKey    = @"campaign_image_url";

// Parameters - Donation
NSString* const kAPIDonationIDKey              = @"campaign_id";
NSString* const kAPIDonationAmountKey          = @"amount";
NSString* const kAPIDonationNameKey            = @"user_name";
NSString* const kAPIDonationEmailKey           = @"user_email";
NSString* const kAPIDonationCreditCardTokenKey = @"credit_card_id";

// Parameters - General
NSString* const kAPIParameterErrorCode    = @"error_code";
NSString* const kAPIParameterErrorMessage = @"error_message";

#pragma mark - Interface Builder

// Segues
NSString* const kIBSegueEntryToCampaignFeed          = @"entryViewToFeedViewSegue";
NSString* const kIBSegueCampaignFeedToCampaignDetail = @"campaignFeedToCampaignDetailSegue";
NSString* const kIBSeguePaymentViewtoSignatureView   = @"paymentToSignatureSegue";
NSString* const kIBSegueSetPaymentRootSwipe          = @"setPaymentRootSwipeSegue";
NSString* const kIBSegueSetPaymentRootManual         = @"setPaymentRootManualSegue";

// Storyboards
NSString* const kIBStoryboardPaymentFlow  = @"PaymentFlow";
NSString* const kIBStoryboardCampaignFlow =  @"CampaignFlow";

// Navigation Controllers
NSString* const kIBPaymentNavigationControllerIdentifier = @"PaymentNavigationController";
