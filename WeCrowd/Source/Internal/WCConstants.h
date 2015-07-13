//
//  WCConstants.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - API

// Endpoints
FOUNDATION_EXPORT NSString* const kAPIEndpointLogin;
FOUNDATION_EXPORT NSString* const kAPIEndpointCampaigns;
FOUNDATION_EXPORT NSString* const kAPIEndpointUsers;
FOUNDATION_EXPORT NSString* const kAPIEndpointDonate;
FOUNDATION_EXPORT NSString* const kAPIEndpointFeaturedCampaigns;

// Parameters - User
FOUNDATION_EXPORT NSString* const kAPIParameterUserID;
FOUNDATION_EXPORT NSString* const kAPIParameterUserToken;
FOUNDATION_EXPORT NSString* const kAPIParameterEmail;
FOUNDATION_EXPORT NSString* const kAPIParameterPassword;

// Parameters - Campaign
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignID;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignName;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignGoal;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignProgress;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignDescription;
FOUNDATION_EXPORT NSString* const kAPICampaignImageURLKey;

// Parameters - Donation
FOUNDATION_EXPORT NSString* const kAPIParameterDonationID;
FOUNDATION_EXPORT NSString* const kAPIParameterDonationAmount;
FOUNDATION_EXPORT NSString* const kAPIParameterDonationName;
FOUNDATION_EXPORT NSString* const kAPIParameterDonationEmail;
FOUNDATION_EXPORT NSString* const kAPIParameterDonationCreditCardToken;

// Parameters - General
FOUNDATION_EXPORT NSString* const kAPIParameterErrorCode;
FOUNDATION_EXPORT NSString* const kAPIParameterErrorMessage;

#pragma mark - Interface Builder

// Segues
FOUNDATION_EXPORT NSString* const kIBSegueEntryToCampaignFeed;
FOUNDATION_EXPORT NSString* const kIBSegueCampaignFeedToCampaignDetail;
FOUNDATION_EXPORT NSString* const kIBSeguePaymentMethodToPaymentStatusSegue;

// Storyboards
FOUNDATION_EXPORT NSString* const kIBStoryboardPaymentFlow;
FOUNDATION_EXPORT NSString* const kIBStoryboardCampaignFlow;
