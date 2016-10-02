//
//  instagramJsonModel.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 15/07/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "instagramJsonModel.h"
#import "UIImageView+WebCache.h"


@implementation instagramJsonModel

-(instancetype)initWithData:(id)myData
{
    self = [super init];
    
    if(self) {
        if (myData && [myData isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:myData];
            self.objectType = [data objectForKey:@"type"];
            
            NSMutableDictionary *commentsKey = [data objectForKey:@"comments"];
            self.numberOfComments = [[commentsKey objectForKey:@"count"]integerValue];
            
            NSMutableDictionary *likesKey = [data objectForKey:@"likes"];
            self.numberOfLikes = [[likesKey objectForKey:@"count"]integerValue];
            
            NSMutableDictionary *imagesKey = [data objectForKey:@"images"];
            NSMutableDictionary *lowResolutionKey = [imagesKey objectForKey:@"low_resolution"];
            self.lowResolutionImageUrl = [lowResolutionKey objectForKey:@"url"];
            NSMutableDictionary *stdResolutionKey = [imagesKey objectForKey:@"standard_resolution"];
            self.standardResolutionImageUrl = [stdResolutionKey objectForKey:@"url"];
            
            NSMutableDictionary *captionKey = [data objectForKey:@"caption"];
            NSMutableDictionary *fromKey = [captionKey objectForKey:@"from"];
            self.captionText = [captionKey objectForKey:@"text"];
            self.postingUserName = [fromKey objectForKey:@"username"];
            self.postingUserImageUrl = [fromKey objectForKey:@"profile_picture"];
            
        }
    }
    return self;
}


+(NSMutableArray *)getArrayFromJson:(id)data
{
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in data)
    {
        instagramJsonModel *mod = [[instagramJsonModel alloc] initWithData:dict];
        [array addObject:mod];
    }
    return array;
}


@end
