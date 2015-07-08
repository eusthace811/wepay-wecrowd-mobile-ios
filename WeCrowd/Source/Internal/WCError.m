//
//  WCError.m
//  WeCrowd
//
//  Created by Zach Vega-Perkins on 7/8/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import "WCError.h"
#import "WCConstants.h"

// Constants
NSString* const WCAPIErrorDomain = @"WeCrowd API Domain";

@implementation WCError

+ (NSError *) APIErrorWithDescription:(NSString *) description
                        serverMessage:(NSString *) serverMessage
                             codeData:(NSDictionary *) codeData
{
    NSDictionary *userInfo;
    NSString *fullDescription, *suggestion;
    NSInteger errorCode;
    
    fullDescription = [description stringByAppendingString:[NSString stringWithFormat:@" %@", serverMessage]];
    suggestion = @"Consult the API documentation.";
    errorCode = [(NSString *) [codeData objectForKey:kAPIParameterErrorCode] integerValue];
    
    userInfo = @{ NSLocalizedDescriptionKey             : NSLocalizedString(fullDescription, nil),
                  NSLocalizedRecoverySuggestionErrorKey : NSLocalizedString(suggestion, nil) };
    
    return [NSError errorWithDomain:WCAPIErrorDomain code:errorCode userInfo:userInfo];
}

@end
