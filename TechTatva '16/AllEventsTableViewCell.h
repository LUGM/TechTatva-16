//
//  AllEventsTableViewCell.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 10/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllEventsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *categoryName;
@property (strong, nonatomic) IBOutlet UIImageView *venueImg;
@property (strong, nonatomic) IBOutlet UIImageView *contactImg;
@property (strong, nonatomic) IBOutlet UIImageView *maxTeamsImg;
@property (strong, nonatomic) IBOutlet UIImageView *timeImg;
@property (strong, nonatomic) IBOutlet UILabel *venue;
@property (strong, nonatomic) IBOutlet UILabel *contact;
@property (strong, nonatomic) IBOutlet UILabel *maxppl;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *favouritesButton;



//- (IBAction)favBtnPressed:(UIButton *)sender;

@end
