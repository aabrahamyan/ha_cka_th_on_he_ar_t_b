//
//  HistoryTableViewCell.m
//  HeartBeatAnalyzer
//
//  Created by Armen Abrahamyan on 9/14/13.
//  Copyright (c) 2013 Sourcio. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) constructStructure {
    rateLabel = [[UILabel alloc] init];
	rateLabel.backgroundColor = [UIColor clearColor];
	rateLabel.textColor = [UIColor whiteColor];
	rateLabel.frame = CGRectMake(10, 10, 130, 20);
	rateLabel.numberOfLines = 1;
	rateLabel.font = [UIFont boldSystemFontOfSize:20];
	[self.contentView addSubview:rateLabel];
    
    dateLabel = [[UILabel alloc] init];
	dateLabel.backgroundColor = [UIColor clearColor];
	dateLabel.textColor = [UIColor whiteColor];
	dateLabel.frame = CGRectMake(130, 30, 170, 13);
	dateLabel.numberOfLines = 1;
	dateLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:dateLabel];
    
    deceaseLabel = [[UILabel alloc] init];
	deceaseLabel.backgroundColor = [UIColor clearColor];
	deceaseLabel.textColor = [UIColor whiteColor];
	deceaseLabel.frame = CGRectMake(130, 10, 200, 15);
	deceaseLabel.numberOfLines = 2;
	deceaseLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:deceaseLabel];
}

- (void) constructData: (NSDictionary *) dic {
    NSString * rate = [dic objectForKey:@"rate_result"];
    rateLabel.text = [rate stringByAppendingFormat:@" %@",@"BPM"];
    dateLabel.text = [dic objectForKey:@"date"];
    deceaseLabel.text = [dic objectForKey:@"dcease"];
}

@end
