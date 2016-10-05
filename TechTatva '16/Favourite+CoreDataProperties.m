//
//  Favourite+CoreDataProperties.m
//  
//
//  Created by YASH on 06/10/16.
//
//

#import "Favourite+CoreDataProperties.h"

@implementation Favourite (CoreDataProperties)

+ (NSFetchRequest<Favourite *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Favourite"];
}

@dynamic eventID;
@dynamic eventName;
@dynamic categoryName;
@dynamic categoryID;
@dynamic round;
@dynamic favourite;
@dynamic date;
@dynamic startTime;
@dynamic endTime;

@end
