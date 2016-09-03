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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.in"]]; //Enter the link here.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [onlineEventsWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.backButton) {
        return;
    }
}

@end
