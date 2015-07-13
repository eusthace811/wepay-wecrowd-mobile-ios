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
FOUNDATION_EXPORT NSString* const kAPIUserIDKey;
FOUNDATION_EXPORT NSString* const kAPIUserTokenKey;
FOUNDATION_EXPORT NSString* const kAPIEmailKey;
FOUNDATION_EXPORT NSString* const kAPIPasswordKey;

// Parameters - Campaign
FOUNDATION_EXPORT NSString* const kAPICampaignIDKey;
FOUNDATION_EXPORT NSString* const kAPICampaignNameKey;
FOUNDATION_EXPORT NSString* const kAPICampaignGoalKey;
FOUNDATION_EXPORT NSString* const kAPICampaignProgressKey;
FOUNDATION_EXPORT NSString* const kAPICampaignDescriptionKey;
FOUNDATION_EXPORT NSString* const kAPICampaignImageURLKey;

// Parameters - Donation
FOUNDATION_EXPORT NSString* const kAPIDonationIDKey;
FOUNDATION_EXPORT NSString* const kAPIDonationAmountKey;
FOUNDATION_EXPORT NSString* const kAPIDonationNameKey;
FOUNDATION_EXPORT NSString* const kAPIDonationEmailKey;
FOUNDATION_EXPORT NSString* const kAPIDonationCreditCardTokenKey;

// Parameters - General
FOUNDATION_EXPORT NSString* const kAPIParameterErrorCode;
FOUNDATION_EXPORT NSString* const kAPIParameterErrorMessage;

#pragma mark - Interface Builder

// Segues
FOUNDATION_EXPORT NSString* const kIBSegueEntryToCampaignFeed;
FOUNDATION_EXPORT NSString* const kIBSegueCampaignFeedToCampaignDetail;
FOUNDATION_EXPORT NSString* const kIBSeguePaymentMethodToPaymentStatus;

// Storyboards
FOUNDATION_EXPORT NSString* const kIBStoryboardPaymentFlow;
FOUNDATION_EXPORT NSString* const kIBStoryboardCampaignFlow;

// Navigation Controllers
FOUNDATION_EXPORT NSString* const kIBPaymentNavigationControllerIdentifier;
