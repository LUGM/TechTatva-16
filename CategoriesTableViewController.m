//
//  CategoriesTableViewController.m
//  TechTatva '16
//
//  Created by Apple on 14/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoriesCell.h"

@interface CategoriesTableViewController(){
NSArray *categoriesArray ;
}

@end

@implementation CategoriesTableViewController
-(void)viewDidLoad{
    categoriesArray = [[NSArray alloc] init];
    categoriesArray = @[@"Categories",@"Hello",@"Hi",@"IOS",@"TT'16",@"AppDev"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return categoriesArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    
    cell.textLabel.text = [categoriesArray objectAtIndex:indexPath.row];

    
    return cell;
}




@end
