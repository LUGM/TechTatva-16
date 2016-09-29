//
//  CategoriesJSONModel.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 29/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "CategoriesJSONModel.h"

@implementation CategoriesJSONModel

-(instancetype)initWithData:(id)myData
{
    self = [super init];
    
    if(self) {
        if (myData && [myData isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:myData];
            self.catId = [data objectForKey:@"cid"];
            self.catName = [data objectForKey:@"cname"];
            self.catDesc = [data objectForKey:@"cdesc"];
        }
    }
    return self;
}

+(NSMutableArray *)getArrayFromJson:(id)myData
{
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in myData)
    {
        CategoriesJSONModel *mod = [[CategoriesJSONModel alloc] initWithData:dict];
        [array addObject:mod];
    }
    return array;
}

@end
