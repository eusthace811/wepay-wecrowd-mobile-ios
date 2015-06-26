//
//  WCConstants.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - API

#pragma mark Endpoints
FOUNDATION_EXPORT NSString* const kAPIEndpointLogin;
FOUNDATION_EXPORT NSString* const kAPIEndpointCampaigns;
FOUNDATION_EXPORT NSString* const kAPIEndpointUsers;

#pragma mark Parameters
FOUNDATION_EXPORT NSString* const kAPIParameterUserID;
FOUNDATION_EXPORT NSString* const kAPIParameterUserToken;
FOUNDATION_EXPORT NSString* const kAPIParameterEmail;
FOUNDATION_EXPORT NSString* const kAPIParameterPassword;

FOUNDATION_EXPORT NSString* const kAPIParameterCampaignID;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignName;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignGoal;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignProgress;
FOUNDATION_EXPORT NSString* const kAPIParameterCampaignDescription;

FOUNDATION_EXPORT NSString* const kAPIParameterErrorCode;
