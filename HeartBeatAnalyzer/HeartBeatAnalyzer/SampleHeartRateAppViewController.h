//
//  SampleHeartRateAppViewController.h
//  SampleHeartRateApp
//
//  Created by Chris Greening on 25/11/2010.
//  Copyright 2010 CMG Research. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class SimpleChart;

@interface SampleHeartRateAppViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate> {
	AVCaptureSession *session;
	SimpleChart *simpleChart;
    NSInteger imageIndex;
    
}

@property (nonatomic, retain) IBOutlet SimpleChart *simpleChart;

@end

