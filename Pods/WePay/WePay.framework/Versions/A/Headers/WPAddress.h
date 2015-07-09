//
//  WPAddress.h
//  WePay
//
//  Created by Chaitanya Bagaria on 4/28/15.
//  Copyright (c) 2015 WePay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  An instance of this class represents a physical address.
 */
@interface WPAddress : NSObject

/**
 *  The first line of the street address.
 */
@property (nonatomic, strong, readonly) NSString *address1;

/**
 *  The second line of the street address.
 */
@property (nonatomic, strong, readonly) NSString *address2;

/**
 *  The city.
 */
@property (nonatomic, strong, readonly) NSString *city;

/**
 *  The 2-letters ISO-3166-1 country code.
 */
@property (nonatomic, strong, readonly) NSString *country;

/**
 *  The postcode. Only for non-US addresses when available.
 */
@property (nonatomic, strong, readonly) NSString *postcode;

/**
 *  The region. Only for non-US addresses when available.
 */
@property (nonatomic, strong, readonly) NSString *region;

/**
 *  The 2-letters US state code. Only for US addresses.
 */
@property (nonatomic, strong, readonly) NSString *state;

/**
 *  The US zip or zip-plus code. Only for US addresses.
 */
@property (nonatomic, strong, readonly) NSString *zip;

/**
 *  Initializes a US Address with just a zip.
 *
 *  @param zip The US zip or zip-plus code.
 *
 *  @return The address.
 */
- (instancetype) initWithZip:(NSString *)zip;

/**
 *  Initializes a US Address.
 *
 *  @param address1 The first line of the street address.
 *  @param address2 The second line of the street address.
 *  @param city     The city.
 *  @param state    The 2-letters US state code.
 *  @param zip      The US zip or zip-plus code.
 *
 *  @return The address.
 */
- (instancetype) initWithAddress1:(NSString *)address1
                         address2:(NSString *)address2
                             city:(NSString *)city
                            state:(NSString *)state
                              zip:(NSString *)zip;
/**
 *  Initializes a non-US Address.
 *
 *  @param address1 The first line of the street address.
 *  @param address2 The second line of the street address.
 *  @param city     The city.
 *  @param region   The region. Only for non-US addresses when available.
 *  @param postcode The postcode. Only for non-US addresses when available.
 *  @param country  The 2-letters ISO-3166-1 country code.
 *
 *  @return The address.
 */
- (instancetype) initWithAddress1:(NSString *)address1
                         address2:(NSString *)address2
                             city:(NSString *)city
                           region:(NSString *)region
                         postcode:(NSString *)postcode
                          country:(NSString *)country;
/** \internal
 *  Converts the address into a dictionary representation.
 *
 *  @return The NSDictionary representing the address.
 */
- (NSDictionary *) toDict;

@end
