//
//  EventsViewController.m
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsTableViewCell.h"
#import "EventsDetailsJSONModel.h"
#import "DADataManager.h"

@interface EventsViewController () <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource>

{
    NSArray *array;
    NSMutableArray *filteredEvents;
    Reachability *reachability;
}
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *searchBarTopConstraint;

@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupSearchController];
	
	[eventsTable registerNib:[UINib nibWithNibName:@"EventsTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventsCell"];
	
    reachability = [Reachability reachabilityForInternetConnection];
    if (reachability.isReachable) {
		  SVHUD_SHOW;
        [self loadFromApi];
	} else {
        [self loadFromCache];
	}

}

- (void) loadFromCache
{
	id jsonData = [[DADataManager sharedManager] fetchJSONFromDocumentsFileName:@"catevents.dat"];
	id requiredArray = [jsonData valueForKey:@"data"];
	array = [EventsDetailsJSONModel getArrayFromJson:requiredArray];
	[self saveLocalData:jsonData];
	filteredEvents = [[array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"categoryEventId == %@", self.categoryID]] mutableCopy];
	array = [filteredEvents copy];
	[eventsTable reloadData];
    SVHUD_HIDE;
}

- (void) saveLocalData:(id)jsonData {
	[[DADataManager sharedManager] saveObject:jsonData toDocumentsFile:@"catevents.dat"];
}

- (void) setupSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    // Get the searchbar's text field via KVO and set color
    UITextField *tfield = [self.searchController.searchBar valueForKey:@"_searchField"];
    tfield.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchController.searchBar.delegate = self;
	self.searchController.searchBar.barTintColor = GLOBAL_BACK_COLOR;
	self.searchController.searchBar.tintColor = GLOBAL_TINT_RED;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    eventsTable.tableHeaderView = self.searchController.searchBar;
}

- (void) loadFromApi
{
    SVHUD_SHOW;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try
        {
            NSURL *myUrl = [[NSURL alloc]initWithString:@"http://api.mitportals.in/events/"];
            NSData *mydata = [NSData dataWithContentsOfURL:myUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
				[self saveLocalData:jsonData];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [EventsDetailsJSONModel getArrayFromJson:requiredArray];
				filteredEvents = [[array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"categoryEventId == %@", self.categoryID]] mutableCopy];
                array = [filteredEvents copy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    SVHUD_HIDE;
                    [eventsTable reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(array.count == 0)
        return 0;
    return filteredEvents.count;
}

- (IBAction)dismissVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventsTableViewCell *cell = (EventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    if (cell == nil)
    {
        cell = [[EventsTableViewCell alloc] init];
    }
    EventsDetailsJSONModel *demoModel = [filteredEvents objectAtIndex:indexPath.row];
    cell.eventName.text = demoModel.eventName;
    cell.eventDesc.text = demoModel.eventDescription;
    if ([demoModel.cntctno isEqualToString:@" "])
        cell.contactNumber.text = @"Contact Info Unavailable";
    else
        cell.contactNumber.text = [NSString stringWithFormat:@"Call : %@",demoModel.cntctno];
    if ([demoModel.cntctname isEqualToString:@" "])
        cell.contactName.text = @"No Contact Person Listed";
    else
        cell.contactName.text = [NSString stringWithFormat:@"Contact : %@", demoModel.cntctname];
    cell.maxTeamSize.text = [NSString stringWithFormat:@"Maximum Team Size : %@", demoModel.eventMaxTeamSize];
    if ([demoModel.day isEqualToString:@"0"])
        cell.day.text = @"Online";
    else
        cell.day.text = [NSString stringWithFormat:@"On day(s): %@", demoModel.day];
    cell.categoryName.text = [NSString stringWithFormat:@"Category : %@", demoModel.categoryEventName];
    [cell.callButton addTarget:self action:@selector(callEventHead:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) callEventHead:(id)sender
{
	NSIndexPath *indexPath = [eventsTable indexPathForRowAtPoint:[sender convertPoint:CGPointZero toView:eventsTable]];
    EventsDetailsJSONModel *event = [filteredEvents objectAtIndex:indexPath.row];
	NSString *URLString = [NSString stringWithFormat:@"telprompt://+91%@", event.cntctno];
	NSURL *URL = [NSURL URLWithString:[URLString stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [[UIApplication sharedApplication] openURL:URL];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath compare:self.selectedIndexPath] == NSOrderedSame)
        return 255.f;
    return 46.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return  [UIView new];
}


# pragma mark - Search

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    UISearchBar *searchBar = searchController.searchBar;
    if (searchBar.text.length > 0)
    {
        [self filterEventsForSearchString:searchBar.text andScopeBarTitle:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
    } else {
        filteredEvents = [NSMutableArray arrayWithArray:array];
        [eventsTable reloadData];
    }
}

- (void)filterEventsForSearchString:(NSString *)searchString andScopeBarTitle:(NSString *)scopeTitle
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"eventName contains[cd] %@ OR categoryEventName contains[cd] %@ OR hs1 contains[cd] %@ OR hs2 contains[cd] %@", searchString, searchString, searchString, searchString]];
    [eventsTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    if (searchBar.text.length > 0)
        [self filterEventsForSearchString:searchBar.text andScopeBarTitle:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
    else
        [self searchBarCancelButtonClicked:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    [eventsTable reloadData];
}

- (void)didPresentSearchController:(UISearchController *)searchController {
//    [UIView animateWithDuration:0.3 animations:^{
        self.searchBarTopConstraint.constant = -20.f;
//    }];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
//    [UIView animateWithDuration:0.3 animations:^{
        self.searchBarTopConstraint.constant = -64.f;
//    }];
}

@end
