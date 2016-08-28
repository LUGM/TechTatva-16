//
//  EventsTableViewCell.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *categoryName;

@property (weak, nonatomic) IBOutlet UIView *eventName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *eventsAndInfoSegView;

- (IBAction)segmentChange:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UIView *eventsAndInfoView;

@end
