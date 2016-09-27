//
//  ScheduleJsonDataModel.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "ScheduleJsonDataModel.h"

@implementation ScheduleJsonDataModel


-(instancetype)initWithData:(id)myData
{
    self = [super init];
    
    if(self) {
        if (myData && [myData isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:myData];
            self.eventId = [data objectForKey:@"eid"];
            self.eventName = [data objectForKey:@"ename"];
            self.catId = [data objectForKey:@"catid"];
            self.catName = [data objectForKey:@"catname"];
            self.round = [data objectForKey:@"round"];
            self.venue = [data objectForKey:@"venue"];
            self.sTime = [data objectForKey:@"stime"];
            self.eTime = [data objectForKey:@"etime"];
            self.date = [data objectForKey:@"date"];
            self.day = [data objectForKey:@"day"];
        }
    }
    return self;
}

+(NSMutableArray *)getArrayFromJson:(id)myData
{
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in myData)
    {
        ScheduleJsonDataModel *mod = [[ScheduleJsonDataModel alloc] initWithData:dict];
        [array addObject:mod];
    }
    return array;
}


@end
