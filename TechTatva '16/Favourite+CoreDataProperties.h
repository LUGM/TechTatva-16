//
//  Favourite+CoreDataProperties.h
//  
//
//  Created by YASH on 06/10/16.
//
//

#import "Favourite+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Favourite (CoreDataProperties)

+ (NSFetchRequest<Favourite *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *eventID;
@property (nullable, nonatomic, copy) NSString *eventName;
@property (nullable, nonatomic, copy) NSString *categoryName;
@property (nullable, nonatomic, copy) NSString *categoryID;
@property (nullable, nonatomic, copy) NSString *round;
@property (nullable, nonatomic, copy) NSString *favourite;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *startTime;
@property (nullable, nonatomic, copy) NSString *endTime;

@end

NS_ASSUME_NONNULL_END
