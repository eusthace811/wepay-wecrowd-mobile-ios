//
//  RUAApplicationIdentifier.h
//  ROAMreaderUnifiedAPI
//
//  Created by Russell Kondaveti on 10/18/13.
//  Copyright (c) 2013 ROAM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RUAApplicationIdentifier : NSObject

@property NSString *aid;

@property NSString *applicationLabel;

/**
 * The registered application provider identifier (RID)
 */
@property NSString *rid;

/**
 * The proprietary application identifier extension (PIX)
 */
@property NSString *pix;

/** The Terminal application version. */
@property NSString *terminalApplicationVersion;

/** The Lowest supported icc application version. */
@property NSString *lowestSupportedICCApplicationVersion;

/** The Priority index. */
@property NSString *priorityIndex;

/** The Application selection flags. */
@property NSString *applicationSelectionFlags;

@property NSString *CVMLimit;
@property NSString *FloorLimit;
@property NSString *TLVData;
@property NSString *TermCaps;
@property NSString *TxnLimit;
@property BOOL contactlessAID;


- (id)                           initWithRID:(NSString *)rid
                                     withPIX:(NSString *)pix
                                withAID:(NSString *)aid
                        withApplicationLabel:(NSString *)label
              withTerminalApplicationVersion:(NSString *)TerminalApplicationVersion
    withLowestSupportedICCApplicationVersion:(NSString *)LowestSupportedICCApplicationVersion
                           withPriorityIndex:(NSString *)priorityIndex
               withApplicationSelectionFlags:(NSString *)applicationSelectionFlags;

- (id)                           initWithRID:(NSString *)rid
                                     withPIX:(NSString *)pix
                                     withAID:(NSString *)aid
                        withApplicationLabel:(NSString *)label
              withTerminalApplicationVersion:(NSString *)TerminalApplicationVersion
    withLowestSupportedICCApplicationVersion:(NSString *)LowestSupportedICCApplicationVersion
                           withPriorityIndex:(NSString *)priorityIndex
               withApplicationSelectionFlags:(NSString *)applicationSelectionFlags
                                withCVMLimit:(NSString *)CVMLimit
                              withFloorLimit:(NSString *)FloorLimit
                                 withTLVData:(NSString *)TLVData
                                withTermCaps:(NSString *)TermCaps
                                withTxnLimit:(NSString *)TxnLimit;

- (NSString *)getFormattedString;

@end
