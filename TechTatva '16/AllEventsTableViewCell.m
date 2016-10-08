//
//  AllEventsTableViewCell.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 10/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "AllEventsTableViewCell.h"

@implementation AllEventsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)drawRect:(CGRect)rect {
	
	[super drawRect:rect];
	
	UIBezierPath *beizerPath = [UIBezierPath bezierPath];
	[beizerPath moveToPoint:CGPointMake(16, self.bounds.size.height - 0.5)];
	[beizerPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 0.5)];
	[beizerPath setLineWidth:0.5];
	[beizerPath setLineCapStyle:kCGLineCapButt]; // Hue hue
	[beizerPath setLineJoinStyle:kCGLineJoinRound];
	
	[GLOBAL_TINT_BLACK setStroke];
	
	[beizerPath stroke];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
