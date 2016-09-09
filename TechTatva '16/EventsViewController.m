//
//  EventsViewController.m
//  TechTatva '16
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsPopupView.h"
#import "EventsTableViewCell.h"
#import "EventsDetailsView.h"
#import "EventsDetailsJSONModel.h"

@interface EventsViewController ()
{
    UIView *overlay;
    EventsPopupView *Event;  //object of main xib class
    NSArray *array;
    EventsDetailsJSONModel *jsonModel;
}
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            NSURL *custumUrl = [[NSURL alloc]initWithString:@"https://api.myjson.com/bins/3t0vu"];
            NSData *mydata = [NSData dataWithContentsOfURL:custumUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [EventsDetailsJSONModel getArrayFromJson:requiredArray];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.tableView reloadData];
                });
                
                EventsDetailsJSONModel *model = [array objectAtIndex:1];
                NSLog(@"%@",model.categoryEventId);
                NSLog(@"%@",model.cntctname);
                NSLog(@"%@",model.hs1);
            }
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });

}

-(IBAction)segmentSwitch{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"myCell";
    EventsTableViewCell *cell = (EventsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventsTableViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    if (cell == nil)
    {
        
        cell = [[EventsTableViewCell alloc] init];
        
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    
    if (![indexPath compare:self.selectedIndexPath] == NSOrderedSame)
        self.selectedIndexPath = indexPath;
    else
        self.selectedIndexPath = nil;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView endUpdates];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath compare:self.selectedIndexPath] == NSOrderedSame)
        return 180.f;
    return 60.f;
}


@end
