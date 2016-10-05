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
#import "FavouritesViewController.h"
#import "ScheduleJsonDataModel.h"


@interface AllEventsViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

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
    [self fetchFavourites];
    
    [self loadFromApi];
    
    allEventsArray = [[NSArray alloc]initWithArray:fetchArray];
    searchedAllEventsArray = [[NSMutableArray alloc]initWithArray:allEventsArray];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupSearchController];
}

- (void)setupSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
//    self.searchController.delegate = self;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchController.searchBar.tintColor = [UIColor blackColor];
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

- (void) fetchFavourites
{
    NSFetchRequest *fetchFavourite = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    fetchArray = [[Favourite managedObjectContext] executeFetchRequest:fetchFavourite error:&error];
}

- (IBAction)allEventsSegmentChange:(id)sender
{
    if(allEventsSegmentControl.selectedSegmentIndex == 0)
        NSLog(@"Day 1 selected.");
    else if(allEventsSegmentControl.selectedSegmentIndex == 1)
         NSLog(@"Day 2 selected.");
    else if(allEventsSegmentControl.selectedSegmentIndex == 2)
        NSLog(@"Day 3 selected.");
    else if(allEventsSegmentControl.selectedSegmentIndex == 3)
        NSLog(@"Day 4 selected.");
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
    if(array.count == 0)
        return 0;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScheduleJsonDataModel *event = [filteredEvents objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"AllEveCell";
    AllEventsTableViewCell *cell = (AllEventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllEventsTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    if (cell == nil)
    {
        cell = [[AllEventsTableViewCell alloc] init];
    }
    cell.eventName.text = [NSString stringWithFormat:@"%@ R%@", event.eventName, event.round];
    cell.categoryName.text = event.catName;
    cell.venue.text = event.place;
    cell.date.text = event.date;
    cell.time.text = [NSString stringWithFormat:@"%@ - %@", event.sTime, event.eTime];
    [cell.rateEvent addTarget:self action:@selector(rateEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell.favouritesButton addTarget:self action:@selector(switchFavourites:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) rateEvent :(id) sender
{
    
}

- (void) switchFavourites:(id) someObject
{
    FavouritesViewController *fav = [[FavouritesViewController alloc]init];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[someObject tag] inSection:0];
    NSLog(@"index is %ld",(long)indexPath.row);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    ScheduleJsonDataModel *event = [filteredEvents objectAtIndex:indexPath.row];
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    NSInteger eventAlreadyThere = 0;
    
    for (int i=0; i<fetchedArray.count; i++)
    {
        
        Favourite *checkForFav = [fetchedArray objectAtIndex:i];
        if ([checkForFav.eventID isEqualToString:event.eventId])
        {
            eventAlreadyThere = 1;
            UIAlertView *addedAlert = [[UIAlertView alloc]initWithTitle:@"Event Already Added!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [addedAlert show];
            break;
        }
        
    }
    
    if (eventAlreadyThere == 0)
    {
        AllEventsTableViewCell *allEvent = [[AllEventsTableViewCell alloc]init];
        NSManagedObjectContext * context = [Favourite managedObjectContext];
        
        Favourite *favouriteEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:context];
        
        if (![context save:&error])
        {
            
            NSLog(@"%@",error);
            
        }
        
        if (favouriteEvent.favourite == 0) {
            favouriteEvent.favourite = @"1";
            [allEvent.favouritesButton setBackgroundImage:[UIImage imageNamed:@"FilledFavourites.png"] forState:UIControlStateNormal];
        }
        else
        {
            [allEvent.favouritesButton setBackgroundImage:[UIImage imageNamed:@"Favourites.png"] forState:UIControlStateNormal];
            
            NSIndexPath *path = [fav.favouritesTable indexPathForSelectedRow];
            Favourite * deleteFavouriteEvent = [favouritesArray objectAtIndex:path.row];
            [favouritesArray removeObjectAtIndex:path.row];
            [[Favourite managedObjectContext] deleteObject:deleteFavouriteEvent];
            NSError * error;
            if (![[Favourite managedObjectContext] save:&error])
            {
                NSLog(@"Error : %@",error);
            }
            NSIndexPath * pathsToDelete = [NSIndexPath indexPathForRow:path.row inSection:0];
            [fav.favouritesTable deleteRowsAtIndexPaths:@[pathsToDelete] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 252.f;
}

#pragma mark - Filtering

- (void)filterEventsForSelectedSegmentTitle:(NSString *)segmentTitle
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    if (allEventsSegmentControl.selectedSegmentIndex != 4)
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"day == %@", segmentTitle]];
    [allEventsTableView reloadData];
}

- (void)filterEventsForSearchString:(NSString *)searchString andScopeBarTitle:(NSString *)scopeTitle
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    if (allEventsSegmentControl.selectedSegmentIndex != 4)
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"(name contains[cd] %@ OR categoryName contains[cd] %@) AND day == %@", searchString, searchString, scopeTitle]];
    else
        [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@  OR categoryName contains[cd] %@", searchString, searchString]];
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

@end
