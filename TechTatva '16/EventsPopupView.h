//
//  EventsPopupView.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 23/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsPopupView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *eventLogo;

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *eventsAndInfoSegmentedview;

@property (weak, nonatomic) IBOutlet UIView *infoDisplayView;

- (IBAction)segmentController:(UISegmentedControl *)sender;

@end
