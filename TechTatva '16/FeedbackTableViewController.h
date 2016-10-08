//
//  FeedbackTableViewController.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 06/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *categoryName;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UITextView *commentsTextArea;

@property (strong, nonatomic) IBOutlet UIButton *star1;
@property (strong, nonatomic) IBOutlet UIButton *star2;
@property (strong, nonatomic) IBOutlet UIButton *star3;
@property (strong, nonatomic) IBOutlet UIButton *star4;
@property (strong, nonatomic) IBOutlet UIButton *star5;
@property (nonatomic) NSInteger favCount;   //to check no of stars selected

- (IBAction)star1Pressed:(id)sender;
- (IBAction)star2Pressed:(id)sender;
- (IBAction)star3Pressed:(id)sender;
- (IBAction)star4Pressed:(id)sender;
- (IBAction)star5Pressed:(id)sender;

-(void)set_stars:(int)num;

@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) NSString *nameOfEvent;
@property (strong, nonatomic) NSString *nameOfCategory;

@end
