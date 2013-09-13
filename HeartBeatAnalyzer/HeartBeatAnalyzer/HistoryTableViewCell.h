//
//  HistoryTableViewCell.h
//  HeartBeatAnalyzer
//
//  Created by Armen Abrahamyan on 9/14/13.
//  Copyright (c) 2013 Sourcio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell<UITableViewDelegate> {
    UILabel * rateLabel;
    UILabel * dateLabel;
    UILabel * deceaseLabel;
}

- (void) constructStructure;
- (void) constructData: (NSDictionary *) dic;

@end
