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
        if (myData && [myData isKindOfClass:[NSDictionary class]]) {
            self.catId = [myData objectForKey:@"cid"];
            self.catName = [myData objectForKey:@"cname"];
            self.catDesc = [myData objectForKey:@"cdesc"];
        }
    }
    return self;
}

+ (NSMutableArray *)getArrayFromJson:(id)myData
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

@implementation CategoriesRatedJSONModel

- (instancetype)initWithData:(id)data {
	self = [super initWithData:data];
	self.score = 0.0;
	self.totalRating = 0;
	self.counter = 0;
	return self;
}

+ (NSMutableArray *)getArrayFromJson:(id)myData {
	NSMutableArray *array = [NSMutableArray new];
	for(NSDictionary *dict in myData)
	{
		CategoriesRatedJSONModel *mod = [[CategoriesRatedJSONModel alloc] initWithData:dict];
		[array addObject:mod];
	}
	return array;
}

- (void)addScore:(NSInteger)score {
	self.counter += 1;
	self.totalRating += score;
	self.score = (self.totalRating + 0.f)/self.counter;
	NSLog(@"Added score to category %@, total = %li, average = %lf", self.catName, self.totalRating, self.score);
}

@end
