//
//  EasterEggViewController.m
//  TechTatva '16
//
//  Created by YASH on 10/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EasterEggViewController.h"
#import "AudioController.h"

@interface EasterEggViewController ()

@property (strong, nonatomic) AudioController *audioController;

@end

@implementation EasterEggViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logoImage.image = [UIImage imageNamed:@"linuxtux.png"];
    self.backgroundImage.image = [UIImage imageNamed:@"devimg.png"];
    
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isInternetAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

- (IBAction)gitButtonPressed:(id)sender
{
    if ([self isInternetAvailable])
    {
        [self loadGit];
    }
    else
    {
        UIAlertView *noNetAlert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Data connection unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noNetAlert show];
    }
}

- (IBAction)facebookButtonPressed:(id)sender
{
    if ([self isInternetAvailable])
    {
        [self loadFacebook];
    }
    else
    {
        UIAlertView *noNetAlert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Data connection unavailable" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noNetAlert show];
    }
}

- (void) loadFacebook
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/groups/lug2016/"]];
    [self.audioController pauseAudio];
}

- (void) loadGit
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/LUGM"]];
    [self.audioController pauseAudio];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
