//
//  EventsTableViewCell.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsTableViewCell.h"

@implementation EventsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (IBAction)segmentChange:(UISegmentedControl *)sender {
//    
//    UIView * view1 = [[[NSBundle mainBundle] loadNibNamed:@"EventsDetailsView" owner:self options:nil ]objectAtIndex:0];
//    UIView * view2 = [[[NSBundle mainBundle] loadNibNamed:@"InfoDetailsView" owner:self options:nil ]objectAtIndex:0];
//    if(self.eventsAndInfoSegView.selectedSegmentIndex==0)
//    {
//        [view2 removeFromSuperview];
//        [self.eventsAndInfoView addSubview:view1];
//    }
//    else
//    {
//        [view1 removeFromSuperview];
//        [self.eventsAndInfoView addSubview:view2];
//    }
//    
//}

@end
