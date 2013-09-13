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
    [super viewDidLoad];
    
    // ----------------------------- BackGround ImageView --------------------------
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
    bgImageView.image = [UIImage imageNamed:@"main_bg.png"];
    
    [self.view addSubview: bgImageView];
    
    // ----------------------------- BPM Count  --------------------------
    bpmCount = [[UILabel alloc] initWithFrame:CGRectMake(76, 200, 150, 80)];
    bpmCount.textColor = [UIColor whiteColor];
    bpmCount.alpha = 0.8;
    bpmCount.backgroundColor = [UIColor clearColor];
    [bpmCount setFont:[UIFont fontWithName:@"ProximaNova-Light" size:70.0]];
    bpmCount.text = @"078";
    
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
    

   
    
    
    double p1 = 7.5;
    dispatch_time_t progress1 = dispatch_time(DISPATCH_TIME_NOW, p1 * NSEC_PER_SEC);
    dispatch_after(progress1, dispatch_get_main_queue(), ^(void){
         [self setProgressFrom:0.0 to:0.4 andDuration:4.0];
         
    });
    
    double p2 = 12;
    dispatch_time_t progress2 = dispatch_time(DISPATCH_TIME_NOW, p2 * NSEC_PER_SEC);
    dispatch_after(progress2, dispatch_get_main_queue(), ^(void){
        [self setProgressFrom:0.4 to:1.0 andDuration:6.0];
    });
    
    
    // ----------------------------- HELP VIEW --------------------------
    HelpView *helpView = [[HelpView alloc] initWithFrame: CGRectMake(0, 0, 320, 548)];
    [self.view addSubview: helpView];
    
    //--------------------------------------------------- TODO: TEST HIDE
    double delayInSeconds = 6.5;
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
    });
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
	[session setSessionPreset:AVCaptureSessionPreset640x480];
	
	// Add the input and output
	[session addInput:cameraInput];
	[session addOutput:videoOutput];
	
	// Start the session
	[session startRunning];		
}

- (void)setProgressFrom: (float)from to: (float)to andDuration: (float)time {
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = time; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:from];
    drawAnimation.toValue   = [NSNumber numberWithFloat:to];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor redColor].CGColor;
    
    circle.strokeEnd = to;
    
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
    
    /*********************** CONVERTING/SAVING IMAGE ***************************/
    /*Create a CGImageRef from the CVImageBufferRef*/
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(buf, width, height, 8, bprow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    /*We release some components*/
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image= [UIImage imageWithCGImage:newImage scale:1.0 orientation:UIImageOrientationRight];
           
    /*********************** CONVERTING/SAVING IMAGE ***************************/
    
    
    
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
        static float lastSat = 0;
        static float lastVal = 0;

        float highPassValue=h-lastH;
        float satDifference = s - lastSat;
        float valDifference = v - lastVal;
    
        image = [self drawText:[@"" stringByAppendingFormat:@"HUE = %f, SAT=%f, VAL=%f, HUE_DIFF=%f, SAT_DIFF=%f, VAL_DIFF=%f", h, s, v,highPassValue,satDifference,valDifference] inImage:image atPoint:CGPointMake(10, 10)];
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *docs = [paths objectAtIndex:0];
        NSString* path =  [docs stringByAppendingFormat:@"/image_%d.jpg",imageIndex];
    
        NSData* imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    
    
        NSError *writeError = nil;
        [imageData writeToFile:path options:NSDataWritingAtomic error:&writeError];
    
        if(writeError!=nil) {
            NSLog(@"%@: Error saving image: %@", [self class], [writeError localizedDescription]);
        }

    
        lastH=h;
        lastSat = s;
        lastVal = v;
        float lastHighPassValue=0;
        float lowPassValue=(lastHighPassValue+highPassValue)/2;
        lastHighPassValue=highPassValue;


        // send the point to the chart to be displayed
        //	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
        @autoreleasepool {
            [simpleChart performSelectorOnMainThread:@selector(addPoint:) withObject:[NSNumber numberWithFloat:lowPassValue] waitUntilDone:NO];
        }
	

    
        imageIndex++;
    }


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
