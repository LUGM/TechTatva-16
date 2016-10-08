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

@implementation AboutUsTableViewController{
    Reachability *reachability;
}

- (void)openURLWithString:(NSString *)URLString backupURLString:(NSString *)backupURLString {
    reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLString]])
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        else
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:backupURLString]];
    }
    else {
        SVHUD_FAILURE(@"No connection!");
    }
}


- (IBAction)facebookAction:(id)sender {
    [self openURLWithString:@"https://www.facebook.com/MITtechtatva/" backupURLString:@"https://www.facebook.com/MITtechtatva/"];
}

- (IBAction)twitterAction:(id)sender {
    [self openURLWithString:@"twitter://user?screen_name=mittechtatva/" backupURLString:@"https://www.twitter.com/mittechtatva/"];
}

- (IBAction)instagramAction:(id)sender {
    [self openURLWithString:@"instagram://user?username=mittechtatva" backupURLString:@"https://www.instagram.com/mittechtatva/"];
}

- (IBAction)youtubeAction:(id)sender {
    [self openURLWithString:@"youtube://www.youtube.com/user/TechTatva" backupURLString:@"https://www.youtube.com/user/TechTatva"];
}

- (IBAction)snapchatAction:(id)sender {
    [self openURLWithString:@"snapchat://add/mittt16" backupURLString:@"http://www.snapchat.com/add/mittt16/"];
}

- (IBAction)simonGoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
