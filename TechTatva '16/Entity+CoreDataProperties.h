//
//  Entity+CoreDataProperties.h
//  TechTatva '16
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *evename;
@property (nullable, nonatomic, retain) NSString *eveid;
@property (nullable, nonatomic, retain) NSString *evedesc;
@property (nullable, nonatomic, retain) NSString *evemaxteamsize;
@property (nullable, nonatomic, retain) NSString *cveid;
@property (nullable, nonatomic, retain) NSString *cvename;
@property (nullable, nonatomic, retain) NSString *cventcvetname;
@property (nullable, nonatomic, retain) NSString *cventcvetno;

@end

NS_ASSUME_NONNULL_END
