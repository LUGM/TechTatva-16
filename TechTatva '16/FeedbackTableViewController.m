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
    [self set_stars:1];
    self.favCount = 1;
}

-(IBAction)star2Pressed:(id)sender
{
    [self set_stars:2];
    self.favCount = 2;

}

-(IBAction)star3Pressed:(id)sender
{
    [self set_stars:3];
    self.favCount = 3;

}

-(IBAction)star4Pressed:(id)sender
{
    [self set_stars:4];
    self.favCount = 4;

}

-(IBAction)star5Pressed:(id)sender
{
    [self set_stars:5];
    self.favCount = 5;

}

-(void)set_stars:(int)num
{
    if(num == 1)
    {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    }
    
    else if(num == 2)
    {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];

    }
    else if(num == 3)
    {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        
    }
    else if(num == 4)
    {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        
    }
    else if(num == 5)
    {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        
    }
}

@end
