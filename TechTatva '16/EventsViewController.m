//
//  EventsViewController.m
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsPopupView.h"

@interface EventsViewController ()
{
    UIView *overlay;
    EventsPopupView *Event;     //object of main xib class
}
    
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    eventsArray = [[NSArray alloc]init];
    
    //added to set default selection
    
    [Event segmentController:Event.eventsAndInfoSegmentedview];

    daycontrol.selectedSegmentIndex = 0;
    if (daycontrol.selectedSegmentIndex == 0) {
        eventsArray = @[@"one", @"two"];
    }
    if (daycontrol.selectedSegmentIndex == 1) {
        eventsArray = @[@"two", @"one"];
    }
    [eventsTable reloadData];
}

-(IBAction)segmentSwitch{
    if (daycontrol.selectedSegmentIndex == 0) {
        eventsArray = @[@"one", @"two"];
    }
    if (daycontrol.selectedSegmentIndex == 1) {
        eventsArray = @[@"two", @"one"];
    }
    [eventsTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return eventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [eventsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *customView = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"EventsPopupView" owner:nil options:nil] objectAtIndex:0];
    
    [eventsTable addSubview:customView];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
