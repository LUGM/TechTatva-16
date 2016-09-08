//
//  RegistrationPageViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 03/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "RegistrationPageViewController.h"

@interface RegistrationPageViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;


@end

@implementation RegistrationPageViewController
@synthesize registrationWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.in"]]; //Enter the link here.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [registrationWebView loadRequest:request];

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
