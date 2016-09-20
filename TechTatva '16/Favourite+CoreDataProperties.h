//
//  Favourite+CoreDataProperties.h
//  
//
//  Created by Abhishek Vora on 12/09/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Favourite.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favourite (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cveid;
@property (nullable, nonatomic, retain) NSString *cvename;
@property (nullable, nonatomic, retain) NSString *cventcvetname;
@property (nullable, nonatomic, retain) NSString *cventcvetno;
@property (nullable, nonatomic, retain) NSString *evedesc;
@property (nullable, nonatomic, retain) NSString *eveid;
@property (nullable, nonatomic, retain) NSString *evemaxteamsize;
@property (nullable, nonatomic, retain) NSString *evename;
@property (nullable, nonatomic, retain) NSNumber *favourite;

@end

NS_ASSUME_NONNULL_END
