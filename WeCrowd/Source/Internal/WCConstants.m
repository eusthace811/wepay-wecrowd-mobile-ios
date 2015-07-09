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
NSString* const kAPIParameterUserID    = @"user_id";
NSString* const kAPIParameterUserToken = @"token";
NSString* const kAPIParameterEmail     = @"user_email";
NSString* const kAPIParameterPassword  = @"password";

// Parameters - Campaign
NSString* const kAPIParameterCampaignID          = @"campaign_id";
NSString* const kAPIParameterCampaignName        = @"campaign_name";
NSString* const kAPIParameterCampaignGoal        = @"campaign_goal";
NSString* const kAPIParameterCampaignProgress    = @"campaign_progress";
NSString* const kAPIParameterCampaignDescription = @"campaign_description";

// Parameters - Donation
NSString* const kAPIParameterDonationID              = @"campaign_id";
NSString* const kAPIParameterDonationAmount          = @"amount";
NSString* const kAPIParameterDonationName            = @"user_name";
NSString* const kAPIParameterDonationEmail           = @"user_email";
NSString* const kAPIParameterDonationCreditCardToken = @"credit_card_id";

// Parameters - General
NSString* const kAPIParameterErrorCode    = @"error_code";
NSString* const kAPIParameterErrorMessage = @"error_message";

#pragma mark - Interface Builder

// Segues
NSString* const kIBSegueEntryToCampaignFeed          = @"entryViewToFeedViewSegue";
NSString* const kIBSegueCampaignFeedToCampaignDetail = @"campaignFeedToCampaignDetailSegue";
NSString* const kIBSeguePaymentMethodToPaymentStatusSegue = @"paymentMethodToPaymentStatusSegue";

// Storyboards
NSString* const kIBStoryboardPaymentFlow  = @"PaymentFlow";
NSString* const kIBStoryboardCampaignFlow =  @"CampaignFlow";
