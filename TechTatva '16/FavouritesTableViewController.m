//
//  FavouritesTableViewController.m
//  TechTatva '16
//
//  Created by YASH on 08/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "FavouritesTableViewController.h"
#import "Favourite+CoreDataClass.h"
#import "AppDelegate.h"
#import "AllEventsTableViewCell.h"
#import "ScheduleJsonDataModel.h"
#import "FeedbackTableViewController.h"


@interface FavouritesTableViewController ()
{
    NSMutableArray *favouritesArray;
    NSArray *fetchArray;
}

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation FavouritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadFavourites];
    self.title = @"Favourites";
	
	[self.tableView registerNib:[UINib nibWithNibName:@"AllEventsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AllEveCell"];
	
}

- (IBAction)simonGoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loadFavourites
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    NSError *error = nil;
    
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    favouritesArray = [fetchedArray mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return favouritesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Favourite *event = [favouritesArray objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"AllEveCell";
    NSLog(@"name and all %@", event.eventName);
    AllEventsTableViewCell *cell = (AllEventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AllEventsTableViewCell alloc] init];
    }
    cell.eventName.text = [NSString stringWithFormat:@"%@ R%@", event.eventName, event.round];
    cell.categoryName.text = event.categoryName;
    cell.venue.text = event.location;
    cell.date.text = event.date;
    cell.time.text = [NSString stringWithFormat:@"%@ - %@", event.startTime, event.endTime];
    NSString *favImageName;
    if ([self checkIfFavorite:event.eventID])
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
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSDate *startTT = [formatter dateFromString:dateString];
    NSComparisonResult result = [now compare:startTT];
    if (result == NSOrderedAscending)
        return false;
    else
        return true;
}

- (BOOL)checkIfFavorite:(NSString *)eventID
{
    NSFetchRequest *fetchFavourite = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    [fetchFavourite setPredicate:[NSPredicate predicateWithFormat:@"eventID == %@", eventID]];
    NSError *error = nil;
    fetchArray = [[Favourite managedObjectContext] executeFetchRequest:fetchFavourite error:&error];
    return (fetchArray.count > 0);
}

- (void) rateEvent :(id) sender
{
    if ([self checkTheDate])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender convertPoint:CGPointZero toView:self.tableView]];
        Favourite *event = [favouritesArray objectAtIndex:indexPath.row];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController * navController = [storyboard instantiateViewControllerWithIdentifier:@"feedbackNav"];
        FeedbackTableViewController * destController = [navController viewControllers][0];
        destController.title = event.eventName;
        destController.nameOfEvent = event.eventName;
        destController.eventId = event.eventID;
        destController.nameOfCategory = event.categoryName;
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
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[someObject convertPoint:CGPointZero toView:self.tableView]];
    
    Favourite *event = [favouritesArray objectAtIndex:indexPath.row];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourite"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"eventID == %@", event.eventID]];
    NSError *error = nil;
    
    NSArray *fetchedArray = [[Favourite managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedArray.count > 0)
    {
        Favourite *favouriteEvent = fetchedArray.firstObject;
        NSLog(@"delete this %@", favouriteEvent.eventID);
        
        [[Favourite managedObjectContext] deleteObject:favouriteEvent];
        
        if (![[Favourite managedObjectContext] save:&error])
        {
            NSLog(@"%@",error);
        }
		
		[favouritesArray removeObject:favouriteEvent];
		[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
