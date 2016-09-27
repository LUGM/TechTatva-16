//
//  ResultsJsonDataModel.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 26/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsJsonDataModel : NSObject

@property (strong,nonatomic) NSString *teamID;
@property (strong,nonatomic) NSString *category;
@property (strong,nonatomic) NSString *event;
@property (strong,nonatomic) NSString *position;
@property (strong,nonatomic) NSString *round;


-(instancetype)initWithData:(id)data;
+(NSMutableArray *)getArrayFromJson:(id)myData;

@end
