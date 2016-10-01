//
//  EventsViewController.h
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    IBOutlet UITableView *eventsTable;
    IBOutlet UISegmentedControl *daycontrol;
    IBOutlet UISearchBar *eventsSearchBar;
    
    NSArray *eventsArray;
    NSMutableArray *searchedEventsArray;
}

- (IBAction)eventsSegmentSwitch:(id)sender;


@end
