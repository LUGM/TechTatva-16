//
//  TrendingCatsTableViewCell.h
//  TechTatva '16
//
//  Created by Avikant Saini on 10/9/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendingCatsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *catDescLabel;

@end
