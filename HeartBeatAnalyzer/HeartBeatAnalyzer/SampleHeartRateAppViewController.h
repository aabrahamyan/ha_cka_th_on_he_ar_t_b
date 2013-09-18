#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RNFrostedSidebar.h"

@class SimpleChart;
@class HistoryTBViewController;

@interface SampleHeartRateAppViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate, RNFrostedSidebarDelegate> {
	AVCaptureSession *session;
	SimpleChart *simpleChart;
    float previousHueDiff;
    float previousHue;
    NSInteger imageIndex;
    UILabel * heartRateLabel;
    NSInteger heartCounter;
    NSTimer * timer;
    NSInteger timerTimes;
    BOOL timerDone;
    NSInteger globalCounter;
    CGFloat circleAnimationCounter;
    
    //------- Peak Detection ---------//
    float previousSlope;
    NSArray * arrs;
    HistoryTBViewController * historyTBVC;
    
}

@property (nonatomic, retain) IBOutlet SimpleChart *simpleChart;

@end

