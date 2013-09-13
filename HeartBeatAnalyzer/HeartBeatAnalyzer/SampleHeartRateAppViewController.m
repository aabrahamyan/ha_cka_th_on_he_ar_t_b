//
//  SampleHeartRateAppViewController.m
//  SampleHeartRateApp
//
//  Created by Chris Greening on 25/11/2010.
//  Copyright 2010 CMG Research. All rights reserved.
//

#import "SampleHeartRateAppViewController.h"
#import "SimpleChart.h"

@implementation SampleHeartRateAppViewController

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
