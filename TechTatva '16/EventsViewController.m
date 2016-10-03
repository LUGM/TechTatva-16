//
//  EventsViewController.m
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"
#import "EventsDetailsView.h"
#import "EventsDetailsJSONModel.h"

@interface EventsViewController ()
{
    NSArray *array;
}
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            
            NSURL *custumUrl = [[NSURL alloc]initWithString:@"api.mitportals.in/events/"];
            NSData *mydata = [NSData dataWithContentsOfURL:custumUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [EventsDetailsJSONModel getArrayFromJson:requiredArray];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [eventsTable reloadData];
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });
    
    eventsArray = [[NSArray alloc] initWithObjects:@"one",@"two",@"three", nil];
    searchedEventsArray = [[NSMutableArray alloc]initWithArray:eventsArray];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)keyBoardShown:(NSNotification *)note{
    CGRect keyboardFrame;
    [[[note userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableviewFrame = eventsTable.frame;
    tableviewFrame.size.height -= keyboardFrame.size.height;
    [eventsTable setFrame:tableviewFrame];
}

-(void)keyBoardHidden:(NSNotification *)note{
    [eventsTable setFrame:self.view.bounds];
    
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        [searchedEventsArray removeAllObjects];
        [searchedEventsArray addObjectsFromArray:eventsArray];
    }
    else{
        [searchedEventsArray removeAllObjects];
        for(NSString *string in eventsArray)
        {
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [searchedEventsArray addObject:string];
            }
        }
    }
    [eventsTable reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [eventsSearchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(array.count == 0)
        return 5;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventsTableViewCell *cell = (EventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventsTableViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    if (cell == nil)
    {
        
        cell = [[EventsTableViewCell alloc] init];
        
    }
    
    EventsDetailsJSONModel *demoModel = [array objectAtIndex:indexPath.row];
    cell.eventDesc.text = demoModel.eventDescription;
    //cell.eventDesc.text = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] eventDescription]];
    //cell.eventName.text = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] eventName]];
    cell.contactNumber.text = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] contactNumber]];
    cell.contactName.text = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] cntctname]];
    cell.maxTeamSize.text = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] eventMaxTeamSize]];

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath compare:self.selectedIndexPath] == NSOrderedSame)
        return 295.f;
    return 60.f;
}


- (IBAction)eventsSegmentSwitch:(id)sender {
    if(daycontrol.selectedSegmentIndex == 0)
        NSLog(@"Day 1 selected.");
    else if(daycontrol.selectedSegmentIndex == 1)
        NSLog(@"Day 2 selected.");
    else if(daycontrol.selectedSegmentIndex == 2)
        NSLog(@"Day 3 selected.");
    else if(daycontrol.selectedSegmentIndex == 3)
        NSLog(@"Day 4 selected.");
}
@end
