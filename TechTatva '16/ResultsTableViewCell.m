//
//  ResultsTableViewCell.m
//  TechTatva '16
//
//  Created by Apple on 17/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "ResultsTableViewCell.h"

@implementation ResultsTableViewCell
@synthesize nameLabel1 = _nameLabel1;
@synthesize nameLabel2 = _nameLabel2;
@synthesize thumbnailImageView = _thumbnailImageView;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
