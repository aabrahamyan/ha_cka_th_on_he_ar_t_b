//
//  SampleHeartRateAppViewController.m
//  SampleHeartRateApp
//
//  Created by Chris Greening on 25/11/2010.
//  Copyright 2010 CMG Research. All rights reserved.
//

#import "SampleHeartRateAppViewController.h"
#import "SimpleChart.h"
#import "HelpView.h"

#define HEART_ANIMATION 0.7

@implementation SampleHeartRateAppViewController {
    UILabel *bpmCount;
    UIImageView *heartImageView;
    CAShapeLayer *circleBG;
    CAShapeLayer *circle;
}

@synthesize simpleChart;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    heartCounter = 1;
    previousHue = 0;
    timerTimes = 1;
    timerDone = NO;
    globalCounter = 1;
    previousSlope = 0;
    
    circleAnimationCounter = 0;
    
    // ----------------------------- BackGround ImageView --------------------------
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    bgImageView.image = [UIImage imageNamed:@"main_bg.png"];
    
    [self.view addSubview: bgImageView];
    
    // ----------------------------- BPM Count  --------------------------
    bpmCount = [[UILabel alloc] initWithFrame:CGRectMake(60 , 200, 130, 80)];
    bpmCount.textColor = [UIColor whiteColor];
    bpmCount.alpha = 0.8;
    bpmCount.backgroundColor = [UIColor clearColor];
    [bpmCount setFont:[UIFont fontWithName:@"ProximaNova-Light" size:16.0]];
   [bpmCount setTextAlignment:NSTextAlignmentRight];
    bpmCount.text = @"Detecting Pulse...";
    
    [self.view addSubview: bpmCount];
    
    // ----------------------------- BPM Text  --------------------------
    UILabel *bpmText = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 120, 70)];
    bpmText.textColor = [UIColor whiteColor];
    bpmText.alpha = 0.8;
    bpmText.backgroundColor = [UIColor clearColor];
    [bpmText setFont:[UIFont fontWithName:@"ProximaNova-Light" size:16.0]];
    bpmText.font = [UIFont boldSystemFontOfSize: 16.0];
    bpmText.text = @"BPM";
    
    [self.view addSubview: bpmText];
    
    // ----------------------------- Create Heart Beat --------------------------
    
    NSArray *imageNames = @[@"3.png", @"4.png", @"5.png", @"6.png",@"7.png", @"8.png", @"9.png", @"9.png", @"8.png", @"7.png", @"6.png", @"5.png",@"4.png", @"3.png"];
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:6];
    
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(186, 198, 60, 53)];
    heartImageView.image = [UIImage imageNamed:@"3.png"];
    heartImageView.animationImages = images;
    heartImageView.animationDuration = HEART_ANIMATION;
    
    [self.view addSubview: heartImageView];
    
    [heartImageView startAnimating];
            
    // Set up the shape of the circle
    int radius = 120;
    
    circleBG = [CAShapeLayer layer];
    
    // Make a circular shape
    circleBG.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 40, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    
    // Center the shape in self.view
    circleBG.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circleBG.fillColor = [UIColor clearColor].CGColor;
    circleBG.strokeColor = [UIColor whiteColor].CGColor;
    circleBG.opacity = 0.3;
    circleBG.lineWidth = 10;
    
    // Add to parent layer
    [self.view.layer addSublayer:circleBG];
    
    
    
    circle = [CAShapeLayer layer];
    
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 40, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor clearColor].CGColor;
    circle.opacity = 0.4;
    circle.lineWidth = 10;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    

   
    
    
    /*double p1 = 7.5;
    dispatch_time_t progress1 = dispatch_time(DISPATCH_TIME_NOW, p1 * NSEC_PER_SEC);
    dispatch_after(progress1, dispatch_get_main_queue(), ^(void){
         [self setProgressFrom:0.0 to:0.4 andDuration:4.0];
         
    });*/
    
    /*double p2 = 12;
    dispatch_time_t progress2 = dispatch_time(DISPATCH_TIME_NOW, p2 * NSEC_PER_SEC);
    dispatch_after(progress2, dispatch_get_main_queue(), ^(void){
        [self setProgressFrom:0.4 to:1.0 andDuration:6.0];
    }); */
    
    
    // ----------------------------- HELP VIEW --------------------------
    HelpView *helpView = [[HelpView alloc] initWithFrame: CGRectMake(0, 0, 320, 548)];
    //[self.view addSubview: helpView];
    
    //--------------------------------------------------- TODO: TEST HIDE
/*    double delayInSeconds = 6.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [helpView hideHelpView];
    });
    //---------------------------------------------------
    
    //--------------------------------------------------- TODO: TEST SHOW
    double delayInSeconds2 = 8.5;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        // [helpView showHelpView];
    });*/
    //---------------------------------------------------    
    
    
    imageIndex = 0;

	// start capturing frames
	// Create the AVCapture Session
	session = [[AVCaptureSession alloc] init];
	
	// create a preview layer to show the output from the camera
	//	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	//	previewLayer.frame = previewView.frame;
	//	[previewView.layer addSublayer:previewLayer];
	
	// Get the default camera device
	AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if([camera isTorchModeSupported:AVCaptureTorchModeOn]) {
		[camera lockForConfiguration:nil];
		camera.torchMode=AVCaptureTorchModeOn;
		//	camera.exposureMode=AVCaptureExposureModeLocked;
		[camera unlockForConfiguration];
	}
	// Create a AVCaptureInput with the camera device
	NSError *error=nil;
	AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
	if (cameraInput == nil) {
		NSLog(@"Error to create camera capture:%@",error);
	}
	
	// Set the output
	AVCaptureVideoDataOutput* videoOutput = [[AVCaptureVideoDataOutput alloc] init];
	
	// create a queue to run the capture on
	dispatch_queue_t captureQueue=dispatch_queue_create("catpureQueue", NULL);
	
	// setup our delegate
	[videoOutput setSampleBufferDelegate:self queue:captureQueue];
	
	// configure the pixel format
	videoOutput.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], (id)kCVPixelBufferPixelFormatTypeKey,
															 nil];
	videoOutput.minFrameDuration=CMTimeMake(1, 10);
	// and the size of the frames we want
	[session setSessionPreset:AVCaptureSessionPresetLow];
	
	// Add the input and output
	[session addInput:cameraInput];
	[session addOutput:videoOutput];
	
	// Start the session
	[session startRunning];		
}

- (void)setProgressFrom {
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];

    drawAnimation.duration            = 1.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:circleAnimationCounter];
    circleAnimationCounter += 0.05;
    drawAnimation.toValue   = [NSNumber numberWithFloat:circleAnimationCounter];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor redColor].CGColor;
    
    circle.strokeEnd = circleAnimationCounter;
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}


- (void) startAnimatingHeart {
    [heartImageView startAnimating];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, HEART_ANIMATION * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [heartImageView stopAnimating];
    });
}


// r,g,b values are from 0 to 1 // h = [0,360], s = [0,1], v = [0,1] 
//	if s == 0, then h = -1 (undefined) 
void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v ) {
	float min, max, delta; 
	min = MIN( r, MIN(g, b )); 
	max = MAX( r, MAX(g, b )); 
	*v = max;
	delta = max - min; 
	if( max != 0 )
		*s = delta / max;
	else {
		// r = g = b = 0 
		*s = 0; 
		*h = -1; 
		return;
	}
	if( r == max )
		*h = ( g - b ) / delta; 
	else if( g == max )
		*h=2+(b-r)/delta;
	else 
		*h=4+(r-g)/delta; 
	*h *= 60;
	if( *h < 0 ) 
		*h += 360;
}

- (UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
	static int count=0;
	count++;
	// only run if we're not already processing an image
	// this is the image buffer
	CVImageBufferRef cvimgRef = CMSampleBufferGetImageBuffer(sampleBuffer);
	// Lock the image buffer
	CVPixelBufferLockBaseAddress(cvimgRef,0);
	// access the data
	int width=CVPixelBufferGetWidth(cvimgRef);
	int height=CVPixelBufferGetHeight(cvimgRef);
	// get the raw image bytes
	uint8_t *buf=(uint8_t *) CVPixelBufferGetBaseAddress(cvimgRef);
	size_t bprow=CVPixelBufferGetBytesPerRow(cvimgRef);
    
   
    
	float r=0,g=0,b=0;
	for(int y=0; y<height; y++) {
		for(int x=0; x<width*4; x+=4) {
			b+=buf[x];
			g+=buf[x+1];
			r+=buf[x+2];
			//			a+=buf[x+3];
		}
		buf+=bprow;
	}
	r/=255*(float) (width*height);
	g/=255*(float) (width*height);
	b/=255*(float) (width*height);
    
	float h,s,v;
	
	RGBtoHSV(r, g, b, &h, &s, &v);
    
    
    if(s >= 0.8999 && s <= 1.0000) {
        
        // simple highpass and lowpass filter - do not use this for anything important, it's rubbish...
        static float lastH=0;
        float highPassValue=h-lastH;
        lastH=h;
        float lastHighPassValue=0;
        float lowPassValue=(lastHighPassValue+highPassValue) / 2;
        lastHighPassValue=highPassValue;
        
        if(lowPassValue <= 0) {
            if(lowPassValue <= previousHue) {
                // send the point to the chart to be displayed
                @autoreleasepool {
                    
                    //NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
                    [simpleChart performSelectorOnMainThread:@selector(addPoint:) withObject:[NSNumber numberWithFloat:0] waitUntilDone:NO];
                }
                
            } else {
                [self performSelectorOnMainThread:@selector(startTimer) withObject:nil waitUntilDone:NO];
                
                //NSLog(@"lowPassValue = = %f", lowPassValue);
                // send the point to the chart to be displayed
                @autoreleasepool {
                    [simpleChart performSelectorOnMainThread:@selector(addPoint:) withObject:[NSNumber numberWithFloat:-0.2] waitUntilDone:NO];
                }
                
                [self performSelectorOnMainThread:@selector(incrementHeartBAndApply) withObject:nil waitUntilDone:NO];
            }
        } else {
            @autoreleasepool {
                // send the point to the chart to be displayed                
                [simpleChart performSelectorOnMainThread:@selector(addPoint:) withObject:[NSNumber numberWithFloat:0] waitUntilDone:NO];
            } 
        }
        
        previousHue = lowPassValue;
        
        imageIndex++;
        globalCounter++;
        NSLog(@"HAP");
    } else {
        NSLog(@"INVALIDATED = %@",timer);
        [timer invalidate];
        timer = nil;
        timerDone = YES;
    }
}


- (void) startTimer {
    if(!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatePulse) userInfo:nil repeats:YES];
    }
}

- (void) updatePulse {
    if(timerTimes == 21) {
        [timer invalidate];
        timer = nil;
        timerDone = YES;
        
        return;
    }
    
    if(heartCounter > 1) {
        [self setProgressFrom];
    }
    
    if(timerTimes >= 10) {
        [bpmCount setFont:[UIFont fontWithName:@"ProximaNova-Light" size:70.0]];
        int x = (60 * heartCounter) / timerTimes;
        bpmCount.text = [NSString stringWithFormat:@"%d", x];
    }
    
    timerTimes++;
    
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void) incrementHeartBAndApply {
    heartCounter++;
    //heartRateLabel.text = [NSString stringWithFormat:@"%d", heartCounter];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
