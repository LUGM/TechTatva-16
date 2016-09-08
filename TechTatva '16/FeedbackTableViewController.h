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
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButton:(UIButton *)sender;

@end
