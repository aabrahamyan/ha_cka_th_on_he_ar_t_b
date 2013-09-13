//
//  HelpView.m
//  HeartBeatAnalyzer
//
//  Created by Anatoli Petrosyants on 2013-09-13.
//  Copyright (c) 2013 Sourcio. All rights reserved.
//

#import "HelpView.h"

@implementation HelpView {
    UIImageView *fingerImageView;
    UIView *bg;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundColor = [UIColor redColor];
        
        // ------------------------------- BackGround -------------------------
        bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        //bg.backgroundColor = [UIColor blackColor];
        //bg.alpha = 0.2;
        
        [self addSubview: bg];
        
        // ------------------------------- Container --------------------------
        UIView *container = [[UIView alloc] initWithFrame: CGRectMake(20, 140, 280, 500)];
        container.layer.cornerRadius = 8;
        container.layer.masksToBounds = YES;
        container.backgroundColor = [UIColor whiteColor];
        
        [self addSubview: container];
        
        // --------------------------- Finger Text Label ----------------------
        UILabel *text1 = [[UILabel alloc] initWithFrame: CGRectMake(68, 20, 144, 30)];
        text1.font = [UIFont boldSystemFontOfSize: 20.0f];
        text1.textColor = [UIColor blackColor];
        text1.backgroundColor = [UIColor clearColor];
        text1.text = @"Finger Position";
        
        [container addSubview: text1];
        
        // --------------------------- Desc Text Label ----------------------
        UILabel *text2 = [[UILabel alloc] initWithFrame: CGRectMake(10, 50, 260, 60)];
        text2.font = [UIFont systemFontOfSize: 20.0f];
        text2.textColor = [UIColor blackColor];
        text2.lineBreakMode = NSLineBreakByWordWrapping;
        text2.numberOfLines = 2;
        text2.textAlignment = NSTextAlignmentCenter;
        text2.backgroundColor = [UIColor clearColor];
        text2.text = @"Please place the tip of your index finger gently on the camera lens";
        
        [container addSubview: text2];
        
        // ----------------------------- Phone ImageView --------------------------
        UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 130, 200, 400)];
        phoneImageView.image = [UIImage imageNamed:@"iPhone_big_info.png"];
        
        [container addSubview: phoneImageView];
        
        fingerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 400, 275)];
        fingerImageView.image = [UIImage imageNamed:@"finger_big_info.png"];
        
        [container addSubview: fingerImageView];
        
        [self animateFinger];
        
    }
    
    return self;
}

- (void)animateFinger {
    
    [UIView animateWithDuration:1
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         CGRect frame = fingerImageView.frame;
         frame.origin.x = (50);
         fingerImageView.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.5
                               delay:0.1
                             options: UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              fingerImageView.alpha = 0.5;
          }
                          completion:^(BOOL finished)
          {
              [UIView animateWithDuration:1.0
                                    delay:0.1
                                  options: UIViewAnimationOptionCurveEaseOut
                               animations:^
               {
                   fingerImageView.alpha = 1;
               }
                               completion:^(BOOL finished)
               {
                   [UIView animateWithDuration:1.5
                                         delay:0.1
                                       options: UIViewAnimationOptionCurveEaseOut
                                    animations:^
                    {
                        CGRect frame = fingerImageView.frame;
                        frame.origin.x = (200);
                        fingerImageView.frame = frame;
                    }
                                    completion:^(BOOL finished)
                    {
                        double delayInSeconds = 1.5;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self animateFinger];
                        });
                        
                    }];

               }];
              
              
          }];
     }];
}

- (void)hideHelpView {
    
    [UIView animateWithDuration:1.0
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         CGRect frame = self.frame;
         frame.origin.y = (600);
         self.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Help hide");
     }];
}

- (void)showHelpView {
    [UIView animateWithDuration:1.0
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         CGRect frame = self.frame;
         frame.origin.y = (0);
         self.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Help hide");
     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
