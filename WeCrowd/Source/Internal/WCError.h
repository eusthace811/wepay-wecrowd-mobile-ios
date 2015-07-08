//
//  WCError.h
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

// Constants
FOUNDATION_EXPORT NSString* const WCAPIErrorDomain;

@interface WCError : NSObject

+ (NSError *) APIErrorWithDescription:(NSString *) description
                        serverMessage:(NSString *) serverMessage
                                 code:(NSInteger) code;

@end
