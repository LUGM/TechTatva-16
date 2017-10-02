//
//  ScheduleJsonDataModel.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleJsonDataModel : NSObject

@property (strong,nonatomic) NSString *eventId;
@property (strong,nonatomic) NSString *eventName;
@property (strong,nonatomic) NSString *catId;
@property (strong,nonatomic) NSString *catName;
@property (strong,nonatomic) NSString *round;
@property (strong,nonatomic) NSString *place;
@property (strong,nonatomic) NSString *sTime;
@property (strong,nonatomic) NSString *eTime;
@property (strong,nonatomic) NSString *day;
@property (strong,nonatomic) NSString *date;

-(instancetype)initWithData:(id)myData;
+(NSMutableArray *)getArrayFromJson:(id)myData;

@end
