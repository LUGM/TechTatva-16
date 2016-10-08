//
//  DevelopersViewController.h
//  TechTatva '16
//
//  Created by YASH on 08/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+Animations.h"

@interface DevelopersViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *devTable;
@property (assign, nonatomic) UITableViewAnimation animationTableView;

@end
