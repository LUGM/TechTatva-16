//
//  AllEventsTableViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 10/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "AllEventsTableViewController.h"
#import "AllEventsTableViewCell.h"
#import "Favourite.h"
#import "EventsDetailsJSONModel.h"
#import "FavouritesViewController.h"

@interface AllEventsTableViewController ()

@end

@implementation AllEventsTableViewController
{
    NSArray *fetchArray;
    NSMutableArray *eventByCategoryArray;
    NSMutableArray *favouritesArray;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchFavourites];
}

- (void) fetchFavourites
{
    NSFetchRequest *fetchFavourite = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    fetchArray = [[Favourite managedObjectContext]executeFetchRequest:fetchFavourite error:&error];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    
    NSIndexPath *indexPath = [someObject valueForKey:@"object"];
    NSLog(@"index is %ld",(long)indexPath.row);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    EventsDetailsJSONModel *event = [eventByCategoryArray objectAtIndex:indexPath.row];
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    NSInteger eventAlreadyThere = 0;
    
    for (int i=0; i<fetchedArray.count; i++)
    {
        
        EventsDetailsJSONModel *checkForFav = [fetchedArray objectAtIndex:i];
        if ([checkForFav.eventName isEqualToString:event.eventName])
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
            //favouriteEvent.favourite = 1;
            [Favourite setValue:@"1" forKey:@"favourite"];
            [allEvent.favouritesButton setBackgroundImage:[UIImage imageNamed:@"filledstar.png"] forState:UIControlStateNormal];
        }
        else
        {
            [allEvent.favouritesButton setBackgroundImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
            
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
