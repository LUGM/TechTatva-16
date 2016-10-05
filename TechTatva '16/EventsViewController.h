//
//  EventsViewController.h
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController 
{
    IBOutlet UITableView *eventsTable;
    
    NSArray *eventsArray;
    NSMutableArray *searchedEventsArray;
}

@property (strong, nonatomic) NSString *categoryID;

@end
