//
//  RUA.h
//  RUA
//
//  Created by Russell Kondaveti on 10/9/13.
//  Copyright (c) 2013 ROAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RUADeviceManager.h"

#define RUA_DEBUG 1

#ifdef RUA_DEBUG
#define RUA_DEBUG_LOG(...) NSLog(__VA_ARGS__)
#else
#define RUA_DEBUG_LOG(...)
#endif


@interface RUA : NSObject

/**
 Enables RUA log messages
 @param enable, TRUE to enable logging
 */
+ (void)enableDebugLogMessages:(BOOL)enable;


/**
 Returns true if RUA log messages are enabled
 */
+ (BOOL)debugLogEnabled;

/**
 Returns the list of roam device types that are supported by the RUA
 <p>
 Usage: <br>
 <code>
 NSArray *supportedDevices = [RUA getSupportedDevices];
 </code>
 </p>
 @return NSArray containing the enumerations of reader types that are supported.
 @see RUADeviceType
 */
+ (NSArray *)getSupportedDevices;

/**
 Returns an instance of the device manager for the device type specified.
 <p>
 Usage: <br>
 <code>
 id<RUADeviceManager> mRP750xReader = [RUA getDeviceManager:RUADeviceTypeRP750x];
 </code>
 </p>
 @param RUADeviceType roam reader type enumeration
 @return RUADeviceManager device manager for the device type specified
 @see RUADeviceType
 */
+ (id <RUADeviceManager> )getDeviceManager:(RUADeviceType)type;

/**
 Returns an version of ROAMReaderUnifiedAPI (RUA)
 @return RUADeviceManager device manager for the device type specified
 */
+ (NSString *) versionString;


@end
