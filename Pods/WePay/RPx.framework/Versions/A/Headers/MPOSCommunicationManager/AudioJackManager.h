//
//  AudioJackManager.h
//  AudioJackDriver_iTMP
//
//  Created by HuangGuoqiang on 13-03-12.
//  Copyright (c) 2013年 Landi. All rights reserved.
//

/****************************************************************************
 *  2013-12-03 14:14:41 Edited by Robert.
 *  verion 1.1.3.1203
 *  Fix up bugs in the first round of testing
 *  add AUDIOJACK exist check.
 *  fix bug about cancelExchange/closeDevice block long time and abnormal resend.
 *  fix bug about closeDevice or closeAudioResource with collapse.
 *  fix bug about CMD2WAV/WAV2CMD's stop function which wait may deadlock.
 *  Optimize the system volume controll.
 *  Unify the ACK timeout and resend times.
 *  version 1.1.4.1219
 *  fix up the system volume save and restore wrong.
 *  version 1.1.5.1220
 *  fix up the openDevice hasHeadset return -4 loss _mSendingLock unlock.
 *  version 1.1.6.1224
 *  fix up release bugs about boot device fail!
 *  version 1.1.7.1225
 *  optimize stop sending while exchangeData is timeout.
 *  version 1.1.8.1226
 *  fix up sine wave encode bug.
 *  version 1.1.9.0102
 *  fix up the dead lock because there is a calling while sending.
 *  version 1.1.10.0630
 *  update audio system sdk api to support arm64
 *  version 1.2.3.0916
 *  fix bug about setVolume method,update system volume every time.
 ****************************************************************************/


#import "CommunicationCallBack.h"
#import "CommunicationManagerBase.h"

@interface AudioJackManager : CommunicationManagerBase

+(AudioJackManager*)sharedInstance;
+(NSString*)getLibVersion;
-(int)openDevice;
-(int)openDevice:(NSString*) identifier;
-(int)openDevice:(NSString *)identifier timeout:(long)timeout;
-(void)closeDevice;
-(void)closeResource;
-(void)closeAudioResource;
-(int)exchangeData:(NSData*) data timeout:(long)timeout cb:(id<CommunicationCallBack>)cb;
-(int)cancelExchange;
-(BOOL)isConnected;
+ (BOOL)hasHeadset;

@end


