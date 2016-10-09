//
//  TrendingTableViewController.m
//  TechTatva '16
//
//  Created by YASH on 08/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "TrendingTableViewController.h"
#import "CategoriesJSONModel.h"
#import "EventsViewController.h"
#import "TrendingCatsTableViewCell.h"

@interface TrendingTableViewController () {
	NSMutableArray *array;
}

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation TrendingTableViewController {
	Reachability *reachability;
	BOOL loadedFirebase;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"TrendingCatsTableViewCell" bundle:nil] forCellReuseIdentifier:@"categoriesCell"];
	
	reachability = [Reachability reachabilityForInternetConnection];
	if (reachability.isReachable) {
		[self loadFromCache];
	} else {
		SVHUD_FAILURE(@"Internet required for trending.");
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	
	loadedFirebase = NO;
	
    self.ref = [[FIRDatabase database] reference];
    [self checkTheDate];
    [self loadTrending];
	
	SVHUD_SHOW;
	
	self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void) loadFromCache {
	NSUserDefaults *categoryData =[NSUserDefaults standardUserDefaults];
	//    NSLog(@"CACHE %@", [categoryData objectForKey:@"category"]);
	if ([categoryData objectForKey:@"category"] != nil)
	{
		id savedData = [categoryData objectForKey:@"category"];
		id requiredArray = [savedData valueForKey:@"data"];
		array = [CategoriesRatedJSONModel getArrayFromJson:requiredArray];
//		CategoriesRatedJSONModel *turing;
//		for (CategoriesRatedJSONModel *item in array) {
//			if ([item.catName isEqualToString:@"Turing"]) {
//				turing = item;
//				break;
//			}
//		}
//		[array removeObject:turing];
//		[array insertObject:turing atIndex:(arc4random_uniform(3) + 3)];
	}

}

- (void) loadTrending
{
    [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *data = snapshot.value;
        for (id catName in data)
        {
			NSArray *filteredCat = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"catName contains[cd] %@", catName]];
			CategoriesRatedJSONModel *currentCat = [filteredCat firstObject];
			if (currentCat != nil) {
				NSDictionary *catDetails = [data objectForKey:catName];
				NSLog(@"Category: %@", catName);
				for (id innerKey in catDetails)
				{
					NSInteger rate = [[[catDetails objectForKey:innerKey] objectForKey:@"rating"] integerValue];
//					NSLog(@"rater woohoo %li", (long) rate);
					[currentCat addScore:rate];
				}
			}
        }
		[array sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO]]];
		dispatch_async(dispatch_get_main_queue(), ^{
			SVHUD_HIDE;
			loadedFirebase = YES;
			[self.tableView reloadData];
		});
//		NSLog(@"Firebase data: %@", data);
    }];
}

- (void) checkTheDate {
    NSDate *now = [NSDate date];
    NSString *dateString = @"2016-10-12";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD"];
    NSDate *startTT = [formatter dateFromString:dateString];
    NSComparisonResult result = [now compare:startTT];
    if (result == NSOrderedAscending)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Early!" message:@"TechTatva 16 has not yet started. No categories are trending. Check back later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
	return 3 * loadedFirebase;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
	UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"eventListNav"];
	EventsViewController *destController = [navController viewControllers][0];
	CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
	destController.title = model.catName;
	destController.categoryID = model.catId;
	[self presentViewController:navController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *simpleTableIdentifier = @"categoriesCell";
	TrendingCatsTableViewCell *cell = (TrendingCatsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
	if (cell == nil) {
		cell = [[TrendingCatsTableViewCell alloc] init];
	}
	CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
	cell.catNameLabel.text = model.catName;
	cell.catImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.catId]];
	cell.catDescLabel.text = model.catDesc;
	return cell;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	CategoriesJSONModel *model = [array objectAtIndex:indexPath.row];
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:model.catName message:model.catDesc delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [UIView new];
}

@end
