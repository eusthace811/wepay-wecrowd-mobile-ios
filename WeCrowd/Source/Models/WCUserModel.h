//
//  WCUserModel.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 6/11/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Interface

@interface WCUserModel : NSObject

@property (strong, nonatomic, readonly) NSString* userID;
@property (strong, nonatomic, readonly) NSString* email;
@property (strong, nonatomic, readonly) NSString* token;

- (id) initWithUserID:(NSString *) userID
                email:(NSString *) email
                token:(NSString *) token;

- (void) setUserID:(NSString *)userID
             email:(NSString *)email
             token:(NSString *)token;

@end
