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
    [self openURLWithString:@"https://www.facebook.com/mitrevels/" backupURLString:@"https://www.facebook.com/mitrevels/"];
}

- (IBAction)twitterAction:(id)sender {
    [self openURLWithString:@"twitter://user?screen_name=revelsmit/" backupURLString:@"https://www.twitter.com/revelsmit/"];
}

- (IBAction)instagramAction:(id)sender {
    [self openURLWithString:@"instagram://user?username=revelsmit" backupURLString:@"https://www.instagram.com/revelsmit/"];
}

- (IBAction)youtubeAction:(id)sender {
    [self openURLWithString:@"youtube://www.youtube.com/channel/UC9gwWd47a0q042qwEgutjWw" backupURLString:@"http://www.youtube.com/user/UC9gwWd47a0q042qwEgutjWw"];
}

- (IBAction)snapchatAction:(id)sender {
    [self openURLWithString:@"snapchat://add/revelsmit" backupURLString:@"http://www.snapchat.com/add/revelsmit/"];
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
