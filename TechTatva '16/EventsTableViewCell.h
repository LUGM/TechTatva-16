//
//  EventsTableViewCell.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *eventName;

@property (weak, nonatomic) IBOutlet UITextView *eventDesc;

@end
