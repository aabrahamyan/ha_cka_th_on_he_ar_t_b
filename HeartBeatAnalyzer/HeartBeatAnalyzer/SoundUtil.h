//
//  SoundUtil.h
//  eyeTest
//
//  Created by Armen Mkrtchyan on 02/09/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface SoundUtil : NSObject

@property (readwrite)   CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID   soundFileObject;

+(SystemSoundID)createAudio:(NSString *)filename;
+(void)playAlertSound:(SystemSoundID) soundFileObject;
+(void)vibrate;

@end
