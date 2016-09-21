//
//  MoreTableViewCell.m
//  TechTatva '16
//
//  Created by Apple on 17/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
