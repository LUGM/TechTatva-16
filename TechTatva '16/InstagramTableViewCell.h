//
//  InstagramTableViewCell.h
//  TechTatva '16
//
//  Created by Abhishek Vora on 21/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *appLogo;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@property (weak, nonatomic) IBOutlet UIImageView *like_img;

@property (weak, nonatomic) IBOutlet UIImageView *comment_image;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *imageUploaderLabel;

@end
