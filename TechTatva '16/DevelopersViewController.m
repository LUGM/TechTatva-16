//
//  DevelopersViewController.m
//  TechTatva '16
//
//  Created by YASH on 08/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "DevelopersViewController.h"
#import "DevViewTableViewCell.h"

@interface DevelopersViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *namesArray;
    NSArray *jobsArray;
    NSArray *imagesArray;
}

@end

@implementation DevelopersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAnimationTableView:AnimationRightToLeft];
    [self setData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UI Table View Data Source Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return namesArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    DevViewTableViewCell *cell = (DevViewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DevViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    cell.nameLabel.text = [namesArray objectAtIndex:indexPath.row];
    cell.jobLabel.text = [jobsArray objectAtIndex:indexPath.row];
    cell.devImage.layer.masksToBounds = YES;
    cell.devImage.layer.cornerRadius = 45;
    cell.devImage.image = [UIImage imageNamed:[namesArray objectAtIndex:indexPath.row]];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_devTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) setData
{
    
    namesArray = @[@"Anuraag Baishya", @"Yash Kumar Lal", @"Vinayak Agarwal", @"Anurag Chaudhary", @"Gautham Vinod", @"Abhishek Vora", @"Naman Yadav", @"Manas Dresswalla", @"Shubham Singhal", @"Ayush Agarwal"];
    
    jobsArray = @[@"Category Head", @"Category Head", @"Category Head", @"Android Developer", @"Windows Developer", @"iOS Developer", @"Android Developer", @"iOS Developer", @"Graphic Designer", @"Android Developer"];
    
    [_devTable reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_devTable performAnimation:self.animationTableView finishBlock:^(bool finished) {
        }];
    });
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectZero];
    return blankView;
    
}

- (IBAction)simonGoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
