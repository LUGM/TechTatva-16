//
//  OnlineEventsViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 01/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "OnlineEventsViewController.h"

@interface OnlineEventsViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation OnlineEventsViewController
@synthesize onlineEventsWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Online Events";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.in"]]; //Enter the link here.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [onlineEventsWebView loadRequest:request];
}

- (IBAction)simonGoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
