#import <UIKit/UIKit.h>


@interface SimpleChart : UIView {
	NSMutableArray *points;
}

@property (nonatomic, retain) NSMutableArray *points;

-(void) addPoint:(NSNumber *) newPoint;

@end
