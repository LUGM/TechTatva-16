//
//  EasterEggViewController.h
//  TechTatva '16
//
//  Created by YASH on 10/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EasterEggViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
- (IBAction)gitButtonPressed:(id)sender;
- (IBAction)facebookButtonPressed:(id)sender;

@end
