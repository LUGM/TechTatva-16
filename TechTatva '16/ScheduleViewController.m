//
//  ScheduleViewController.m
//  
//
//  Created by Abhishek Vora on 26/09/16.
//
//

#import "ScheduleViewController.h"
#import "ScheduleJsonDataModel.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController
{
    NSArray *array;
     ScheduleJsonDataModel *jsonModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            NSURL *myUrl = [[NSURL alloc]initWithString:@"http://api.mitportals.in/schedule/"];
            NSData *mydata = [NSData dataWithContentsOfURL:myUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                array = [ScheduleJsonDataModel getArrayFromJson:requiredArray];
                ScheduleJsonDataModel *model = [array objectAtIndex:0];
                NSLog(@"cat name: %@",model.catName);
                NSLog(@"Event name:%@",model.eventName);
                NSLog(@"date:%@",model.date);

                
                dispatch_async(dispatch_get_main_queue(), ^{
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
}



@end
