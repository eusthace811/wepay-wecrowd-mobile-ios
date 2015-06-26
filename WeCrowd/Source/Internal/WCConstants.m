//
//  WCConstants.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/26/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCConstants.h"

#pragma mark - API

#pragma mark Endpoints
NSString* const kAPIEndpointLogin     = @"/login";
NSString* const kAPIEndpointCampaigns = @"/campaigns";
NSString* const kAPIEndpointUsers     = @"/users";

#pragma mark Parameters
NSString* const kAPIParameterUserID    = @"user_id";
NSString* const kAPIParameterUserToken = @"token";
NSString* const kAPIParameterEmail     = @"user_email";
NSString* const kAPIParameterPassword  = @"password";

NSString* const kAPIParameterCampaignID          = @"campaign_id";
NSString* const kAPIParameterCampaignName        = @"campaign_name";
NSString* const kAPIParameterCampaignGoal        = @"campaign_goal";
NSString* const kAPIParameterCampaignProgress    = @"campaign_progress";
NSString* const kAPIParameterCampaignDescription = @"campaign_description";

NSString* const kAPIParameterErrorCode = @"error_code";
