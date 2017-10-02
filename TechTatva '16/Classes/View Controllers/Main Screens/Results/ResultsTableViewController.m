//
//  ResultsTableViewController.m
//  TechTatva '16
//
//  Created by Apple on 17/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "ResultsTableViewCell.h"
#import "ResultsJsonDataModel.h"

@interface ResultsTableViewController () <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>
{
    NSArray *label1Array;
    NSArray *label2Array;
    NSArray *array;
    
    NSMutableArray *filteredEvents;
}

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ResultsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSearchController];
    [self loadFromApi];
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
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void) loadFromApi
{
    SVHUD_SHOW;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            NSURL *myUrl = [[NSURL alloc]initWithString:@""];
            NSData *mydata = [NSData dataWithContentsOfURL:myUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [ResultsJsonDataModel getArrayFromJson:requiredArray];
                filteredEvents = [array mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    SVHUD_HIDE;
                    [self.tableView reloadData];
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (array.count == 0)
        return 0;
    return filteredEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"resultsCell";
    ResultsTableViewCell *cell = (ResultsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ResultsTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    if (cell == nil) {
        cell = [[ResultsTableViewCell alloc] init];
    }
    ResultsJsonDataModel *model = [filteredEvents objectAtIndex:indexPath.row];
    cell.nameLabel1.text = [NSString stringWithFormat:@"Event : %@", model.event];
    cell.nameLabel2.text = [NSString stringWithFormat:@"Category : %@", model.category];
    cell.eveRound.text = [NSString stringWithFormat:@"Round : %@", model.round];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResultsJsonDataModel *model = [filteredEvents objectAtIndex:indexPath.row];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Result" message:[NSString stringWithFormat:@"Position : %@\nTeam ID : %@", model.standing, model.teamID]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

# pragma mark - Search

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    UISearchBar *searchBar = searchController.searchBar;
    if (searchBar.text.length > 0)
    {
        [self filterEventsForSearchString:searchBar.text andScopeBarTitle:searchBar.scopeButtonTitles[searchBar.selectedScopeButtonIndex]];
    } else
    {
        filteredEvents = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
    }
}

- (void)filterEventsForSearchString:(NSString *)searchString andScopeBarTitle:(NSString *)scopeTitle
{
    filteredEvents = [NSMutableArray arrayWithArray:array];
    [filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"event contains[cd] %@ OR category contains[cd] %@", searchString, searchString, searchString, searchString]];
    [self.tableView reloadData];
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
    [self.tableView reloadData];
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
