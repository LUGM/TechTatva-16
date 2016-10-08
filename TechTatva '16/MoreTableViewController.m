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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"moreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell.textLabel.text = [labelArray objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.row == 0) {
        UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"onlineNav"];
        [self presentViewController:dest animated:YES completion:nil];
    }
    else if (indexPath.row == 1) {
        UINavigationController *dest = [storyboard instantiateViewControllerWithIdentifier:@"registerNav"];
        [self presentViewController:dest animated:YES completion:nil];
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
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectZero];
    return blankView;
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
