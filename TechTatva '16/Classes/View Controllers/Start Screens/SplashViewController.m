//
//  SplashViewController.m
//  TechTatva '16
//
//  Created by YASH on 08/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height == 568.0) && ((IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale) || !IS_OS_8_OR_LATER))
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)

#import "SplashViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface SplashViewController ()
{
    MPMoviePlayerController *mMoviePlayer;
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:mMoviePlayer];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSString *stringPath;
    stringPath = [[NSBundle mainBundle] pathForResource:@"launchvideo" ofType:@"mp4"];
    NSURL *fileUrl = [NSURL fileURLWithPath:stringPath];
    mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
    [mMoviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    [mMoviePlayer.view setFrame:self.view.frame];
    [mMoviePlayer setFullscreen:YES];
    [mMoviePlayer setScalingMode:MPMovieScalingModeFill];
    [mMoviePlayer setControlStyle:MPMovieControlStyleNone];
    [self.view addSubview:mMoviePlayer.view];
    [mMoviePlayer play];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)playbackFinished
{
    UITabBarController *tabBarC = [self.storyboard instantiateViewControllerWithIdentifier:@"initTabBar"];
    
    [self presentViewController:tabBarC animated:YES completion:^{
        // Prevent unnecessary dismissals
        self.view.window.rootViewController = tabBarC;
    }];
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
