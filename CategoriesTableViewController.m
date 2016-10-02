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

@interface CategoriesTableViewController()  {
    NSArray *categoriesArray ;
    NSArray *array;
}

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CategoriesTableViewController

-(void)viewDidLoad  {
    categoriesArray = [[NSArray alloc] init];
    categoriesArray = @[@"Categories",@"Hello",@"Hi",@"IOS",@"TT'16",@"AppDev"];
    
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
    
    [tableView beginUpdates];
    if (!([indexPath compare:self.selectedIndexPath] == NSOrderedSame))
        self.selectedIndexPath = indexPath;
    else
        self.selectedIndexPath = nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView endUpdates];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"categoriesCell";
    CategoriesTableViewCell *cell = (CategoriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CategoriesTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    if (cell == nil) {
        cell = [[CategoriesTableViewCell alloc] init];
    }
    
    
    cell.nameLabel1.text = [[array objectAtIndex:indexPath.row] catName];
    //cell.nameLabel2.text = [label2Array objectAtIndex:indexPath.row];
    cell.categoryInfo.text = [[array objectAtIndex:indexPath.row] catDesc];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath compare:self.selectedIndexPath] == NSOrderedSame)
        return 265.f;
    return 90.f;
}


@end
