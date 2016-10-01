//
//  AllEventsViewController.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 01/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllEventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
{
    IBOutlet UISearchBar *eventsSearchBar;
    
    NSArray *allEventsArray;
    NSMutableArray *searchedAllEventsArray;
    IBOutlet UITableView *allEventsTableView;
    IBOutlet UISegmentedControl *allEventsSegmentControl;
    
    
}

- (IBAction)allEventsSegmentChange:(id)sender;


@end
