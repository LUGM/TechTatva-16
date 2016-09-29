//
//  CategoriesJSONModel.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 29/09/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesJSONModel : NSObject

@property (strong,nonatomic) NSString *catId;
@property (strong,nonatomic) NSString *catName;
@property (strong,nonatomic) NSString *catDesc;

-(instancetype)initWithData:(id)data;
+(NSMutableArray *)getArrayFromJson:(id)myData;

@end
