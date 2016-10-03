//
//  AllEventsViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 01/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "AllEventsViewController.h"
#import "AllEventsTableViewCell.h"
#import "Favourite.h"
#import "EventsDetailsJSONModel.h"
#import "FavouritesViewController.h"
#import "ScheduleJsonDataModel.h"


@interface AllEventsViewController ()

@end

@implementation AllEventsViewController
{
    NSArray *fetchArray;
    NSMutableArray *eventByCategoryArray;
    NSMutableArray *favouritesArray;
    NSMutableArray *filteredArray;
    NSArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchFavourites];
    
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
                    [allEventsTableView reloadData];
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });

    
    allEventsArray = [[NSArray alloc]initWithArray:fetchArray];
    searchedAllEventsArray = [[NSMutableArray alloc]initWithArray:allEventsArray];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyBoardShown:(NSNotification *)note{
    CGRect keyboardFrame;
    [[[note userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey]getValue:&keyboardFrame];
    CGRect tableviewFrame = allEventsTableView.frame;
    tableviewFrame.size.height -= keyboardFrame.size.height;
    [allEventsTableView setFrame:tableviewFrame];
}

-(void)keyBoardHidden:(NSNotification *)note{
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
            if(r.location != NSNotFound){
                [searchedAllEventsArray addObject:string];
            }
        }
    }
    [allEventsTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [eventsSearchBar resignFirstResponder];
}

- (void) fetchFavourites
{
    NSFetchRequest *fetchFavourite = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    fetchArray = [[Favourite managedObjectContext]executeFetchRequest:fetchFavourite error:&error];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(array.count == 0)
        return 4;
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AllEveCell";
    AllEventsTableViewCell *cell = (AllEventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AllEventsTableViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    if (cell == nil)
    {
        cell = [[AllEventsTableViewCell alloc] init];
    }
    
    
    [cell.favouritesButton addTarget:self action:@selector(switchFavourites:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) switchFavourites:(id) someObject
{
    FavouritesViewController *fav = [[FavouritesViewController alloc]init];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[someObject tag] inSection:0];
    NSLog(@"index is %ld",(long)indexPath.row);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    EventsDetailsJSONModel *event = [eventByCategoryArray objectAtIndex:indexPath.row];
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    NSInteger eventAlreadyThere = 0;
    
    for (int i=0; i<fetchedArray.count; i++)
    {
        
        Favourite *checkForFav = [fetchedArray objectAtIndex:i];
        if ([checkForFav.cvename isEqualToString:event.categoryEventName])
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
        
        favouriteEvent.evename = event.eventName;
        //favouriteEvent.location = event.location;
        //favouriteEvent.start = event.start;
        //favouriteEvent.stop = event.stop;
        //favouriteEvent.duration = event.duration;
        favouriteEvent.cvename = event.categoryEventName;
        favouriteEvent.evedesc = event.eventDescription;
        //favouriteEvent.contact = event.contact;
        //favouriteEvent.date = event.date;
        //favouriteEvent.day = event.day;
        favouriteEvent.evemaxteamsize = event.eventMaxTeamSize;
        
        if (![context save:&error])
        {
            
            NSLog(@"%@",error);
            
        }
        
        if (favouriteEvent.favourite == 0) {
            favouriteEvent.favourite = [NSNumber numberWithInteger:1];
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
    return 275.f;
}

@end
