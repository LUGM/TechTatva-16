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
        if (myData && [myData isKindOfClass:[NSDictionary class]]) {
            self.eventId = [myData objectForKey:@"eid"];
            self.eventName = [myData objectForKey:@"ename"];
            self.catId = [myData objectForKey:@"catid"];
            self.catName = [myData objectForKey:@"catname"];
            self.round = [myData objectForKey:@"round"];
            self.place = [myData objectForKey:@"venue"];
            self.sTime = [myData objectForKey:@"stime"];
            self.eTime = [myData objectForKey:@"etime"];
            self.date = [myData objectForKey:@"date"];
            self.day = [myData objectForKey:@"day"];
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
