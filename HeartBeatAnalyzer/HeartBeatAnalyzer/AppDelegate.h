//
//  AppDelegate.h
//  HeartBeatAnalyzer
//
//  Created by Armen Abrahamyan on 9/13/13.
//  Copyright (c) 2013 Sourcio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SampleHeartRateAppViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SampleHeartRateAppViewController *viewController;

@end
