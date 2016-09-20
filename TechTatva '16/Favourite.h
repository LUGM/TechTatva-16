//
//  Favourite.h
//  
//
//  Created by Abhishek Vora on 12/09/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Favourite : NSManagedObject

+(NSManagedObjectContext *) managedObjectContext;

@end

NS_ASSUME_NONNULL_END

#import "Favourite+CoreDataProperties.h"
