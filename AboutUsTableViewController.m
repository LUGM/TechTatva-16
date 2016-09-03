//
//  AboutUsTableViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 03/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "AboutUsTableViewController.h"

@interface AboutUsTableViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation AboutUsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
