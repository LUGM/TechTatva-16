//
//  CategoriesTableViewController.m
//  TechTatva '16
//
//  Created by Apple on 14/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoriesTableViewCell.h"
#import "CategoriesJSONModel.h"
#import "EventsViewController.h"

@interface CategoriesTableViewController()
{
    NSArray *categoriesArray ;
    NSArray *array;
}

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CategoriesTableViewController

-(void)viewDidLoad
{
    [self loadFromApi];
}

- (void) loadFromApi
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            
            NSURL *custumUrl = [[NSURL alloc]initWithString:@"http://api.mitportals.in/categories/"];
            NSData *mydata = [NSData dataWithContentsOfURL:custumUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [CategoriesJSONModel getArrayFromJson:requiredArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (array.count == 0)
        return 0;
    return array.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"eventListNav"];
    EventsViewController *destController = [navController viewControllers][0];
    CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
    destController.title = model.catName;
    destController.categoryID = model.catId;
    [self presentViewController:navController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"categoriesCell";
    CategoriesTableViewCell *cell = (CategoriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoriesTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    if (cell == nil)
    {
        cell = [[CategoriesTableViewCell alloc] init];
    }
    CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.catName;
    cell.categoryImage = nil;
    return cell;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:model.catName message:model.catDesc delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectZero];
    return blankView;
}

@end
