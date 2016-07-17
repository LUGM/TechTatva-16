//
//  instagramJsonModel.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 15/07/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface instagramJsonModel : NSObject

@property (strong,nonatomic) NSString *objectType;  //ex: image
@property (nonatomic) NSInteger numberOfComments;  //in the "comments" key
@property (nonatomic) NSInteger numberOfLikes; //in the "likes" key
@property (strong,nonatomic) NSString *lowResolutionImageUrl;   //in "images" key
@property (strong,nonatomic) NSString *standardResolutionImageUrl;  //in "images" key
@property (strong,nonatomic) NSString *postingUserName;     //the user who posted the material
@property (strong,nonatomic) NSString *postingUserImageUrl;    //in the "from" key
@property (strong,nonatomic) NSString *captionText; //in the "caption" key

//-(id)initWithDict:(NSMutableDictionary *)mainDict;
-(instancetype)initWithData:(id)data;

+(NSMutableArray *)getArrayFromJson:(id)myData;

@end
