//
//  WCUser.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCUser.h"

@interface WCUser ()

@property (strong, nonatomic, readwrite) NSString* userID;
@property (strong, nonatomic, readwrite) NSString* email;
@property (strong, nonatomic, readwrite) NSString* usernameCanonical;
@property (strong, nonatomic, readwrite) NSString* password;

@end


#pragma mark - Implementation

@implementation WCUser

#pragma mark - Initialization

- (id) initWithUserID:(NSString *) userID
                email:(NSString *) email
    usernameCanonical:(NSString *) usernameCanonical
{
    if (self = [super init]) {
        self.userID = userID;
        self.email = email;
        self.usernameCanonical = usernameCanonical;
    } else {
        // unable to initialize objects
    }
    
    return self;
}

@end
