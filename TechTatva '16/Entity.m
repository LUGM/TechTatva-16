//
//  Entity.m
//  TechTatva '16
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "Entity.h"
#import "AppDelegate.h"

@implementation Entity

// Insert code here to add functionality to your managed object subclass

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
