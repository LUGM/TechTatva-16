//
//  EventsPopupViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 22/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsPopupViewController.h"

@interface EventsPopupViewController ()

@end

@implementation EventsPopupViewController

@synthesize eventsAndInfoSegmentedview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)eventsAndInfoSegmentedview:(id)sender {
    if (eventsAndInfoSegmentedview.selectedSegmentIndex == 0)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EventsDetailsView" owner:self options:nil];
    }
    else if(eventsAndInfoSegmentedview.selectedSegmentIndex == 1)
    {
         [[NSBundle mainBundle] loadNibNamed:@"InfoDetailsView" owner:self options:nil];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[NSBundle mainBundle]
                     loadNibNamed:@"EventsPopupViewController"
                     owner:self options:nil]
                    firstObject];
    return view;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}

@end
