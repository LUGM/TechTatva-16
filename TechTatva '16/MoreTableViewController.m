//
//  MoreTableViewController.m
//  TechTatva '16
//
//  Created by Apple on 17/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "MoreTableViewController.h"
#import "OnlineEventsViewController.h"
#import "AboutUsTableViewController.h"
#import "RegistrationPageViewController.h"
#import "FavouritesTableViewController.h"

@interface MoreTableViewController ()
{
    NSArray *labelArray;
    Reachability *reachability;
    
    NSString *onlineeventsUrl;
    NSString *registerUrl;
}

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    labelArray = [[NSArray alloc] init];
    labelArray = @[@"Online Events", @"Registration", @"Favourites", @"About Us", @"Trending", @"Developers"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.remoteConfig = [FIRRemoteConfig remoteConfig];
    FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
    self.remoteConfig.configSettings = remoteConfigSettings;
    
    reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable)
        [self fetchUrl];
    else
        [self useLocal];
}

- (void) fetchUrl
{
    SVHUD_SHOW;
    [self.remoteConfig fetchWithExpirationDuration:0 completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *error) {
        if (status == FIRRemoteConfigFetchStatusSuccess) {
            NSLog(@"Config fetched!");
            [self.remoteConfig activateFetched];
            dispatch_async(dispatch_get_main_queue(), ^{
                onlineeventsUrl = [NSString stringWithFormat:@"%@", self.remoteConfig[@"onlineevents"].stringValue];
                registerUrl = [NSString stringWithFormat:@"%@", self.remoteConfig[@"register"].stringValue];
                SVHUD_HIDE;
                [[NSUserDefaults standardUserDefaults] setObject:onlineeventsUrl forKey:@"onlineevents"];
                [[NSUserDefaults standardUserDefaults] setObject:registerUrl forKey:@"register"];
            });
        }
        else {
            NSLog(@"Config not fetched");
            NSLog(@"Error %@", error.localizedDescription);
            NSString *lastOnlineUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"onlineevents"];
            if (lastOnlineUrl.length > 0)
                onlineeventsUrl = lastOnlineUrl;
            else
                lastOnlineUrl = @"onlineevents.techtatva.in";
            NSString *lastRegisterUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"register"];
            if (lastRegisterUrl.length > 0)
                registerUrl = lastRegisterUrl;
            else
                registerUrl = @"register.mitportals.in";
        }
    }];
}

- (void) useLocal
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SVHUD_FAILURE(@"No Internet Connection!");
    });
    NSString *lastOnlineUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"onlineevents"];
    if (lastOnlineUrl.length > 0)
        onlineeventsUrl = lastOnlineUrl;
    else
        lastOnlineUrl = @"onlineevents.techtatva.in";
    NSString *lastRegisterUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"register"];
    if (lastRegisterUrl.length > 0)
        registerUrl = lastRegisterUrl;
    else
        registerUrl = @"register.mitportals.in";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return labelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell.textLabel.text = [labelArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.row == 0) {
        if (reachability.isReachable)
        {
            UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"onlineNav"];
            [self presentViewController:dest animated:YES completion:nil];
        }
    }
    else if (indexPath.row == 1) {
        if (reachability.isReachable)
        {
            UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"registerNav"];
            [self presentViewController:dest animated:YES completion:nil];
        }
    }
    else if (indexPath.row == 2) {
        UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"favouritesNav"];
        [self presentViewController:dest animated:YES completion:nil];
    }
    else if (indexPath.row == 3) {
        UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"aboutUsNav"];
        [self presentViewController:dest animated:YES completion:nil];
    }
    else if (indexPath.row == 4) {
        if ([self checkTheDate])
        {
            UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"trendingNav"];
            [self presentViewController:dest animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Early!" message:@"TechTatva 16 has not yet started. No categories are trending. Check back later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if (indexPath.row == 5) {
        UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"developersNav"];
        [self presentViewController:dest animated:YES completion:nil];
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (BOOL) checkTheDate
{
    NSDate *now = [NSDate date];
    NSString *dateString = @"12.10.2016";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSDate *startTT = [formatter dateFromString:dateString];
    NSComparisonResult result = [now compare:startTT];
    if (result == NSOrderedAscending)
        return false;
    else
        return true;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
