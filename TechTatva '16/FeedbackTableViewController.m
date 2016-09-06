//
//  FeedbackTableViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 06/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "FeedbackTableViewController.h"

@interface FeedbackTableViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation FeedbackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (sender == self.backButton) {
        return;
    }
}


- (IBAction)submitButton:(UIButton *)sender {
}
@end
