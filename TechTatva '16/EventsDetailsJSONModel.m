//
//  EventsDetailsJSONModel.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 02/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "EventsDetailsJSONModel.h"

@implementation EventsDetailsJSONModel

-(instancetype)initWithData:(id)myData
{
    self = [super init];
    
    if(self) {
        if (myData && [myData isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:myData];
            self.eventName = [data objectForKey:@"ename"];
            self.eventId = [[data objectForKey:@"eid"]integerValue];
            self.eventDescription = [data objectForKey:@"edesc"];
            self.eventMaxTeamSize = [data objectForKey:@"emaxteamsize"];
            self.categoryEventId = [data objectForKey:@"cid"];
            self.categoryEventName = [data objectForKey:@"cname"];
            self.cntctname = [data objectForKey:@"cntctname"];
            self.cntctno = [data objectForKey:@"cntctno"];
            self.hs1 = [data objectForKey:@"hs1"];
            self.hs2 = [data objectForKey:@"hs2"];
        }
    }
    return self;
}

+(NSMutableArray *)getArrayFromJson:(id)myData
{
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in myData)
    {
        EventsDetailsJSONModel *mod = [[EventsDetailsJSONModel alloc] initWithData:dict];
        [array addObject:mod];
    }
    return array;
}

/*  code to run the events details model

 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
 @try {
 NSURL *custumUrl = [[NSURL alloc]initWithString:@"https://api.myjson.com/bins/26qtt"];
 NSData *mydata = [NSData dataWithContentsOfURL:custumUrl];
 NSError *error;
 
 if (mydata!=nil)
 {
 id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
 id requiredArray = [jsonData valueForKey:@"data"];
 array = [jsonModel getArrayFromJson:requiredArray];
 
 dispatch_async(dispatch_get_main_queue(), ^{
 //[self.tableView reloadData];
 });
 
 jsonModel *model = [array objectAtIndex:1];
 NSLog(@"%@",model.categoryEventId);
 }
 
 
 }
 @catch (NSException *exception) {
 
 }
 @finally {
 
 }
 });
 
*/
@end
