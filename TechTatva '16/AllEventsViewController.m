//
//  AllEventsViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 01/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "AllEventsViewController.h"
#import "AllEventsTableViewCell.h"
#import "Favourite+CoreDataClass.h"
#import "Favourite+CoreDataProperties.h"
#import "ScheduleJsonDataModel.h"
#import "FeedbackTableViewController.h"

@interface AllEventsViewController () <UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;

@end

@implementation AllEventsViewController
{
    NSArray *fetchArray;
    NSMutableArray *favouritesArray;
    NSMutableArray *filteredEvents;
    NSArray *array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    favouritesArray = [NSMutableArray new];
    filteredEvents = [NSMutableArray new];
    allEventsSegmentControl.selectedSegmentIndex = 0;
	allEventsSegmentControl.tintColor = GLOBAL_TINT_RED;
    
    [self loadFromApi];
    
    allEventsArray = [[NSArray alloc]initWithArray:fetchArray];
    searchedAllEventsArray = [[NSMutableArray alloc]initWithArray:allEventsArray];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
	
	[allEventsTableView registerNib:[UINib nibWithNibName:@"AllEventsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AllEveCell"];
    
    [self setupSearchController];
	
	[self.navigationController.navigationBar setTranslucent:NO];
	[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"TransparentPixel"]];
	[self.navigationController.navigationBar setBackgroundColor:GLOBAL_BACK_COLOR];
//	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Pixel"] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
	UITextField *tfield = [self.searchController.searchBar valueForKey:@"_searchField"];
	tfield.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    self.searchController.searchBar.delegate = self;
	self.searchController.searchBar.showsScopeBar = NO;
	self.searchController.searchBar.scopeButtonTitles = @[@"DAY 1", @"DAY 2", @"DAY 3", @"DAY 4"];
    self.searchController.searchBar.backgroundColor = GLOBAL_BACK_COLOR;
    self.searchController.searchBar.tintColor = GLOBAL_TINT_RED;
	self.searchController.searchBar.barTintColor = GLOBAL_BACK_COLOR;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    allEventsTableView.tableHeaderView = self.searchController.searchBar;
}

- (void) loadFromApi
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            
            NSURL *custumUrl = [[NSURL alloc]initWithString:@"http://api.mitportals.in/schedule/"];
            NSData *mydata = [NSData dataWithContentsOfURL:custumUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [ScheduleJsonDataModel getArrayFromJson:requiredArray];
                NSLog(@"ARRAYCOUNT %li", array.count);
//                filteredEvents = [array mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self filterEventsForSelectedSegmentTitle:[allEventsSegmentControl titleForSegmentAtIndex:allEventsSegmentControl.selectedSegmentIndex]];
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });
}

-(void)keyBoardShown:(NSNotification *)note
{
    CGRect keyboardFrame;
    [[[note userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableviewFrame = allEventsTableView.frame;
    tableviewFrame.size.height -= keyboardFrame.size.height;
    [allEventsTableView setFrame:tableviewFrame];
}

-(void)keyBoardHidden:(NSNotification *)note
{
    [allEventsTableView setFrame:self.view.bounds];
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        [searchedAllEventsArray removeAllObjects];
        [searchedAllEventsArray addObjectsFromArray:allEventsArray];
    }
    else{
        [searchedAllEventsArray removeAllObjects];
        for(NSString *string in allEventsArray)
        {
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound)
            {
                [searchedAllEventsArray addObject:string];
            }
        }
    }
    [allEventsTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [eventsSearchBar resignFirstResponder];
}

- (BOOL)checkIfFavorite:(NSString *)eventID
{
    NSFetchRequest *fetchFavourite = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    [fetchFavourite setPredicate:[NSPredicate predicateWithFormat:@"eventID == %@", eventID]];
    NSError *error = nil;
    fetchArray = [[Favourite managedObjectContext] executeFetchRequest:fetchFavourite error:&error];
    return (fetchArray.count > 0);
}

- (IBAction)allEventsSegmentChange:(id)sender
{
    if(allEventsSegmentControl.selectedSegmentIndex == 0)
    {
        NSLog(@"Day 1 selected.");
    }
    else if(allEventsSegmentControl.selectedSegmentIndex == 1)
    {
        NSLog(@"Day 2 selected.");
    }
    else if(allEventsSegmentControl.selectedSegmentIndex == 2)
    {
        NSLog(@"Day 3 selected.");
    }
    else if(allEventsSegmentControl.selectedSegmentIndex == 3)
    {
        NSLog(@"Day 4 selected.");
    }
    [self filterEventsForSelectedSegmentTitle:[allEventsSegmentControl titleForSegmentAtIndex:allEventsSegmentControl.selectedSegmentIndex]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (filteredEvents.count == 0)
        return 0;
    return filteredEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleJsonDataModel *event = [filteredEvents objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"AllEveCell";
    AllEventsTableViewCell *cell = (AllEventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[AllEventsTableViewCell alloc] init];
    }
    cell.eventName.text = [NSString stringWithFormat:@"%@ R%@", event.eventName, event.round];
    cell.categoryName.text = event.catName;
    cell.venue.text = event.place;
    cell.date.text = event.date;
    cell.time.text = [NSString stringWithFormat:@"%@ - %@", event.sTime, event.eTime];
    NSString *favImageName;
    if ([self checkIfFavorite:event.eventId])
        favImageName = @"FilledFavourites.png";
    else
        favImageName = @"Favourites.png";
    [cell.favouritesButton setBackgroundImage:[UIImage imageNamed:favImageName] forState:UIControlStateNormal];
    [cell.rateEvent addTarget:self action:@selector(rateEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell.favouritesButton addTarget:self action:@selector(switchFavourites:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (BOOL) checkTheDate
{
    NSDate *now = [NSDate date];
    NSString *dateString = @"12.10.2016";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yy"];
    NSDate *startTT = [formatter dateFromString:dateString];
    NSComparisonResult result = [now compare:startTT];
    if (result == NSOrderedAscending)
        return false;
    else
        return true;
}

- (void) rateEvent :(id) sender
{
    if ([self checkTheDate])
    {
        NSIndexPath *indexPath = [allEventsTableView indexPathForRowAtPoint:[sender convertPoint:CGPointZero toView:allEventsTableView]];
        ScheduleJsonDataModel *event = [filteredEvents objectAtIndex:indexPath.row];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController * navController = [storyboard instantiateViewControllerWithIdentifier:@"feedbackNav"];
        FeedbackTableViewController * destController = [navController viewControllers][0];
        destController.title = event.eventName;
        destController.nameOfEvent = event.eventName;
        destController.nameOfCategory = event.catName;
        destController.eventId = event.eventId;
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Early!" message:@"TechTatva 16 has not yet started. No categories are trending. Check back later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) switchFavourites:(id) someObject
{
    
    NSIndexPath *indexPath = [allEventsTableView indexPathForRowAtPoint:[someObject convertPoint:CGPointZero toView:allEventsTableView]];
    
    ScheduleJsonDataModel *event = [filteredEvents objectAtIndex:indexPath.row];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"eventID == %@", event.eventId]];
    NSError *error = nil;
    
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedArray.count > 0)
    {
//        UIAlertView *addedAlert = [[UIAlertView alloc]initWithTitle:@"Event Already Added!" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
//        [addedAlert show];
        
        // Remove from favs
        
        Favourite *favouriteEvent = fetchedArray.firstObject;
        NSLog(@"delete this %@", favouriteEvent.eventID);
        
        [[Favourite managedObjectContext] deleteObject:favouriteEvent];
        
        if (![[Favourite managedObjectContext] save:&error])
        {
            
            NSLog(@"%@",error);
            
        }
        
    }
    else
    {
//        AllEventsTableViewCell *allEvent = [allEventsTableView cellForRowAtIndexPath:indexPath];
        
        NSManagedObjectContext * context = [Favourite managedObjectContext];
        
        Favourite *favouriteEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:context];
        
        favouriteEvent.favourite = @"1";
        favouriteEvent.eventID = event.eventId;
		favouriteEvent.eventName = event.eventName;
		favouriteEvent.categoryID = event.catId;
		favouriteEvent.categoryName = event.catName;
		favouriteEvent.date = event.date;
		favouriteEvent.startTime = event.sTime;
		favouriteEvent.endTime = event.eTime;
		favouriteEvent.location = event.place;
		favouriteEvent.round = event.round;
        // CONTINUE
        
        if (![context save:&error])
        {
            
            NSLog(@"%@",error);
            
        }
        
    
    }
    
    [allEventsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
        return 235.f;
    return 66.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [UIView new];
}

#pragma mark - Filtering

- (void)filterEventsForSelectedSegmentTitle:(NSString *)segmentTitle
{
    filteredEvents = [array mutableCopy];
    if (allEventsSegmentControl.selectedSegmentIndex < 4)
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"day == %@", [NSString stringWithFormat:@"%li", allEventsSegmentControl.selectedSegmentIndex+1]]];
    [allEventsTableView reloadData];
}

- (void)filterEventsForSearchString:(NSString *)searchString andScopeBarTitle:(NSString *)scopeTitle
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    if (allEventsSegmentControl.selectedSegmentIndex != 4)
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"(eventName contains[cd] %@ OR catName contains[cd] %@) AND day == %@", searchString, searchString, [scopeTitle substringFromIndex:4]]];
    else
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"eventName contains[cd] %@  OR catName contains[cd] %@", searchString, searchString]];
    [allEventsTableView reloadData];
}

#pragma mark - Search controller results updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    UISearchBar *searchBar = searchController.searchBar;
    if (searchBar.text.length > 0) {
        if (searchBar.scopeButtonTitles.count > 0)
            [self filterEventsForSearchString:searchBar.text andScopeBarTitle:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
        else
            [self filterEventsForSearchString:searchBar.text andScopeBarTitle:[allEventsSegmentControl titleForSegmentAtIndex:allEventsSegmentControl.selectedSegmentIndex]];
    }
    else {
        [self filterEventsForSelectedSegmentTitle:[allEventsSegmentControl titleForSegmentAtIndex:allEventsSegmentControl.selectedSegmentIndex]];
    }
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if (searchBar.text.length > 0)
        [self filterEventsForSearchString:searchBar.text andScopeBarTitle:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
    else
        [self searchBarCancelButtonClicked:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self filterEventsForSelectedSegmentTitle:[allEventsSegmentControl titleForSegmentAtIndex:allEventsSegmentControl.selectedSegmentIndex]];
}

- (void)didPresentSearchController:(UISearchController *)searchController {
	self.tableViewTopConstraint.constant = 4.f;
}

- (void)didDismissSearchController:(UISearchController *)searchController {
	self.tableViewTopConstraint.constant = 0.f;
}

@end
