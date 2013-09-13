//
//  SoundUtil.m
//  eyeTest
//
//  Created by Armen Mkrtchyan on 02/09/13.
//  Copyright (c) 2013 Armen Mkrtchyan. All rights reserved.
//

#import "SoundUtil.h"

@implementation SoundUtil

// Respond to a tap on the Alert Sound button.
+(void)playAlertSound:(SystemSoundID) soundFileObject {
    AudioServicesPlaySystemSound (soundFileObject);
}

+(SystemSoundID)createAudio:(NSString *)filename {
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: filename
                                                withExtension: @"wav"];
    
    // Store the URL as a CFURLRef instance
    CFURLRef soundFileURLRef = (__bridge CFURLRef)tapSound;
    SystemSoundID soundFileObject;
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    return soundFileObject;
}

// Respond to a tap on the Vibrate button. In the Simulator and on devices with no
//    vibration element, this method does nothing.
+(void)vibrate {
//    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}


@end