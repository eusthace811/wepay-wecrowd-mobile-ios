//
//  WCUserModel.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCUserModel.h"

@interface WCUserModel ()

@property (strong, nonatomic, readwrite) NSString* userID;
@property (strong, nonatomic, readwrite) NSString* email;
@property (strong, nonatomic, readwrite) NSString* token;

@end


#pragma mark - Implementation

@implementation WCUserModel

#pragma mark - Initialization

- (id) initWithUserID:(NSString *) userID
                email:(NSString *) email
                token:(NSString *) token
{
    if (self = [super init]) {
        self.userID = userID;
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
