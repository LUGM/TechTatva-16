//
//  InstagramFullViewController.h
//  TechTatva '16
//
//  Created by YASH on 06/10/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramFullViewController : UIViewController <NSURLConnectionDelegate>

@property (strong,nonatomic) NSString * requiredUrl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSString *imageUrl;

@end
