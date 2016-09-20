//
//  Favourite.m
//  
//
//  Created by Abhishek Vora on 12/09/16.
//
//

#import "Favourite.h"
#import "AppDelegate.h"

@implementation Favourite

// Insert code here to add functionality to your managed object subclass
+(NSManagedObjectContext *) managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate performSelector:@selector(managedObjectContext) withObject:self])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
