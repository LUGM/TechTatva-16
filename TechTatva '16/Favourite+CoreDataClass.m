//
//  Favourite+CoreDataClass.m
//  
//
//  Created by YASH on 06/10/16.
//
//

#import "Favourite+CoreDataClass.h"

@implementation Favourite

+ (NSManagedObjectContext *) managedObjectContext
{
    
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext) withObject:self])
    {
        
        context = [delegate managedObjectContext];
        
    }
    
    return context;
    
}

@end
