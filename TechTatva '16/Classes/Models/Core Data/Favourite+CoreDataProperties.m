//
//  Favourite+CoreDataProperties.m
//  
//
//  Created by YASH on 08/10/16.
//
//

#import "Favourite+CoreDataProperties.h"

@implementation Favourite (CoreDataProperties)

+ (NSFetchRequest<Favourite *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Favourite"];
}

@dynamic categoryID;
@dynamic categoryName;
@dynamic date;
@dynamic endTime;
@dynamic eventID;
@dynamic eventName;
@dynamic favourite;
@dynamic round;
@dynamic startTime;
@dynamic location;

@end
