//
//  WPConfig.h
//  WePay
//
//  Created by Chaitanya Bagaria on 11/7/14.
//  Copyright (c) 2014 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The configuration object used for initializing a \ref WePay instance.
 */
@interface WPConfig : NSObject

/**
 *  Your WePay clientId for the specified environment
 */
@property (nonatomic, strong, readonly) NSString *clientId;

/**
 *  The environment to be used, one of (staging, production)
 */
@property (nonatomic, strong, readonly) NSString *environment;

/**
 *  Determines if we should use location services. Defaults to NO.
 */
@property (nonatomic, assign) BOOL useLocation;

/**
 *  Determines if the card reader should automatically restart after a successful read. Defaults to NO.
 */
@property (nonatomic, assign) BOOL restartCardReaderAfterSuccess;

/**
 *  Determines if the card reader should automatically restart after a general error (domain:kWPErrorCategoryCardReader, errorCode:WPErrorCardReaderGeneralError). Defaults to YES.
 */
@property (nonatomic, assign) BOOL restartCardReaderAfterGeneralError;

/**
 *  Determines if the card reader should automatically restart after an error other than general error. Defaults to NO.
 */
@property (nonatomic, assign) BOOL restartCardReaderAfterOtherErrors;

/**
 *  A convenience initializer
 *
 *  @param clientId    Your WePay clientId.
 *  @param environment The environment to be used, one of (kWPEnvironmentStage, kWPEnvironmentProduction).
 *
 *  @return A \ref WPConfig instance which can be used to initialize a \ref WePay instance.
 */
- (instancetype) initWithClientId:(NSString *)clientId
                      environment:(NSString *)environment;

/**
 *  The designated initializer
 *
 *  @param clientId                             Your WePay clientId.
 *  @param environment                          The environment to be used, one of (kWPEnvironmentStage, kWPEnvironmentProduction).
 *  @param useLocation                          Flag to determine if we should use location services.
 *  @param restartCardReaderAfterSuccess        Flag to determine if the card reader should automatically restart after a successful read.
 *  @param restartCardReaderAfterGeneralError   Flag to determine if the card reader should automatically restart after a general error (domain:kWPErrorCategoryCardReader, errorCode:WPErrorCardReaderGeneralError).
 *  @param restartCardReaderAfterOtherErrors    Flag to determine if the card reader should automatically restart after an error other than general error.
 *
 *  @return A \ref WPConfig instance which can be used to initialize a \ref WePay instance.
 */
- (instancetype) initWithClientId:(NSString *)clientId
                      environment:(NSString *)environment
                      useLocation:(BOOL)useLocation
    restartCardReaderAfterSuccess:(BOOL)restartCardReaderAfterSuccess
restartCardReaderAfterGeneralError:(BOOL)restartCardReaderAfterGeneralError
restartCardReaderAfterOtherErrors:(BOOL)restartCardReaderAfterOtherErrors;

@end
