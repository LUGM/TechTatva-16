//
//  FeedbackTableViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 06/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "FeedbackTableViewController.h"

@interface FeedbackTableViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;


@end

@implementation FeedbackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favCount = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (sender == self.backButton) {
        return;
    }
}


- (IBAction)submitButton:(UIButton *)sender
{
    
}

- (IBAction)star1Pressed:(id)sender
{
    self.star1.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star2.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star3.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star4.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star5.imageView.image = [UIImage imageNamed:@"star.png"];
    self.favCount = 1;
}

-(IBAction)star2Pressed:(id)sender
{
    self.star1.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star2.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star3.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star4.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star5.imageView.image = [UIImage imageNamed:@"star.png"];
    self.favCount = 2;

}

-(IBAction)star3Pressed:(id)sender
{
    self.star1.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star2.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star3.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star4.imageView.image = [UIImage imageNamed:@"star.png"];
    self.star5.imageView.image = [UIImage imageNamed:@"star.png"];
    self.favCount = 3;

}

-(IBAction)star4Pressed:(id)sender
{
    self.star1.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star2.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star3.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star4.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star5.imageView.image = [UIImage imageNamed:@"star.png"];
    self.favCount = 4;

}

-(IBAction)star5Pressed:(id)sender
{
    self.star1.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star2.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star3.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star4.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.star5.imageView.image = [UIImage imageNamed:@"filledstar.png"];
    self.favCount = 5;

}

@end
