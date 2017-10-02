//
//  Favourite+CoreDataClass.h
//  
//
//  Created by YASH on 08/10/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Favourite : NSManagedObject

+ (NSManagedObjectContext *) managedObjectContext;

@end

NS_ASSUME_NONNULL_END

#import "Favourite+CoreDataProperties.h"
