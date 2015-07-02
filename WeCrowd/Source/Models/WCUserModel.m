//
//  WCUserModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCUserModel.h"

@interface WCUserModel ()

@property (nonatomic, strong, readwrite) NSString* userID;
@property (nonatomic, strong, readwrite) NSString* displayName;
@property (nonatomic, strong, readwrite) NSString* canonicalName;
@property (nonatomic, strong, readwrite) NSString* email;
@property (nonatomic, strong, readwrite) NSString* token;

@end

#pragma mark - Implementation

@implementation WCUserModel

#pragma mark - Initialization

- (id) initWithUserID:(NSString *) userID
          displayName:(NSString *) displayName
                email:(NSString *) email
                token:(NSString *) token
{
    if (self = [super init]) {
        self.userID = userID;
        self.displayName = displayName;
        self.canonicalName = [displayName lowercaseString];
        self.email = email;
        self.token = token;
    } else {
        // do nothing
    }
    
    return self;
}

- (void) setUserID:(NSString *)userID
             email:(NSString *)email
             token:(NSString *)token
{
    self.userID = userID;
    self.email = email;
    self.token = token;
}

@end
