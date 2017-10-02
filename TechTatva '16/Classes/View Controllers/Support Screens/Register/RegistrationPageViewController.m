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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.co.in"]]; // Enter the link here.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [registrationWebView loadRequest:request];
    self.title = @"Register";
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
