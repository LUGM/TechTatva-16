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
    self.favbtnIndex = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favBtnPressed:(UIButton *)sender
{
    if (self.favbtnIndex == 0) {
        self.favbtnIndex = 1;
        [sender setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.favbtnIndex = 0;
        [sender setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        
    }
}

@end
