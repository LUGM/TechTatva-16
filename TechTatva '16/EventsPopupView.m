//
//  EventsPopupView.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 23/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsPopupView.h"

@implementation EventsPopupView

@synthesize eventsAndInfoSegmentedview;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.eventsAndInfoSegmentedview.selectedSegmentIndex = 0;
        // Initialization code
        [self loadNib];
    }
    return self;
}

- (void) loadNib
{
    NSArray * subviewArray = [[NSBundle mainBundle] loadNibNamed:@"EventsPopupView" owner:self options:nil];
    UIView * mainView = [subviewArray objectAtIndex:0];
    eventsAndInfoSegmentedview.selectedSegmentIndex = 1;
    [self addSubview:mainView];
    
}

- (IBAction)closeButton:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)segmentController:(UISegmentedControl *)sender {
    if (eventsAndInfoSegmentedview.selectedSegmentIndex == 0) {
        NSArray * subviewArray1 = [[NSBundle mainBundle] loadNibNamed:@"EventsDetailsView" owner:self options:nil];
        UIView * view1 = [subviewArray1 objectAtIndex:0];
        [self.infoDisplayView addSubview:view1];
    }
    else
    {
        NSArray * subviewArray2 = [[NSBundle mainBundle] loadNibNamed:@"InfoDetailsView" owner:self options:nil];
        UIView * view2 = [subviewArray2 objectAtIndex:0];
        [self.infoDisplayView addSubview:view2];    }
}

@end
