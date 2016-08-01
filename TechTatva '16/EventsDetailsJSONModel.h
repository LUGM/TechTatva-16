//
//  EventsDetailsJSONModel.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 02/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsDetailsJSONModel : NSObject

@property (strong,nonatomic) NSString *eventName;
@property (nonatomic) NSInteger eventId;
@property (strong,nonatomic) NSString *eventDescription;
@property (nonatomic) NSInteger eventMaxTeamSize;
@property (strong,nonatomic) NSString *categoryEventId;
@property (strong,nonatomic) NSString *categoryEventName;

-(instancetype)initWithData:(id)data;
+(NSMutableArray *)getArrayFromJson:(id)myData;

@end
