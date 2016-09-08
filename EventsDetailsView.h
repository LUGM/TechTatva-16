//
//  EventsDetailsView.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 23/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsDetailsView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *locationImage;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *timeImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *dateImage;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *maxpplImage;

@property (weak, nonatomic) IBOutlet UILabel *maxpplLabel;

@property (weak, nonatomic) IBOutlet UIImageView *contactImage;

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;

@end
