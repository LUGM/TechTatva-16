//
//  ResultsJsonDataModel.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "ResultsJsonDataModel.h"

@implementation ResultsJsonDataModel

-(instancetype)initWithData:(id)myData
{
    self = [super init];
    
    if(self) {
        if (myData && [myData isKindOfClass:[NSDictionary class]]) {
            self.teamID = [myData objectForKey:@"tid"];
            self.event = [myData objectForKey:@"eve"];
            self.category = [myData objectForKey:@"cat"];
            self.round = [myData objectForKey:@"round"];
            self.standing = [myData objectForKey:@"pos"];
        }
    }
    return self;
}

+(NSMutableArray *)getArrayFromJson:(id)myData
{
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in myData)
    {
        ResultsJsonDataModel *mod = [[ResultsJsonDataModel alloc] initWithData:dict];
        [array addObject:mod];
    }
    return array;
}


@end
