//
//  CategoriesTableViewController.m
//  TechTatva '16
//
//  Created by Apple on 14/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "CategoriesTableViewCell.h"

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


/*-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    
    cell.textLabel.text = [categoriesArray objectAtIndex:indexPath.row];

    
    return cell;
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"categoriesCell";
    CategoriesTableViewCell *cell = (CategoriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoriesTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    if (cell == nil) {
        cell = [[CategoriesTableViewCell alloc] init];
    }
    
    cell.nameLabel1.text = [categoriesArray objectAtIndex:indexPath.row];
    //cell.nameLabel2.text = [label2Array objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"thumb_IMG_7632_1024.jpg"];
    cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2;
    cell.thumbnailImageView.clipsToBounds = YES;
    
    
    
    return cell;
}



@end
