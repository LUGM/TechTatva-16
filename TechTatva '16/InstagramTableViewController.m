//
//  InstagramTableViewController.m
//  TechTatva '16
//
//  Created by Abhishek Vora on 21/06/16.
//  Copyright © 2016 YASH. All rights reserved.
//

#import "InstagramTableViewController.h"
#import "InstagramTableViewCell.h"
#import "instagramJsonModel.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface InstagramTableViewController ()
{
    NSMutableArray *instaArray;
    NSURL *mainInstagramUrl;
}

@end

@implementation InstagramTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainInstagramUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/techtatva16/media/recent?access_token=630237785.f53975e.8dcfa635acf14fcbb99681c60519d04c"]];
    SVHUD_SHOW;
    [self getInstaData];
    
}

- (void) getInstaData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @try {
            NSData *mydata = [NSData dataWithContentsOfURL:mainInstagramUrl];
            NSError *error;
            
            if (mydata!=nil)
            {
                id jsonData = [NSJSONSerialization JSONObjectWithData:mydata options:kNilOptions error:&error];
                id requiredArray = [jsonData valueForKey:@"data"];
                instaArray = [instagramJsonModel getArrayFromJson:requiredArray];
//                NSLog(@"INSTA %@",jsonData);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    SVHUD_HIDE;
                });
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (instaArray.count == 0)
        return 0;
    return instaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstagramTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InstagramTableViewCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    if (cell == nil) {
        cell = [[InstagramTableViewCell alloc] init];
    }
    
    instagramJsonModel *model = [instaArray objectAtIndex:indexPath.row];
    cell.like_img.image = [UIImage imageNamed:[NSString stringWithFormat:@"likepic.png"]];
    cell.comment_image.image = [UIImage imageNamed:[NSString stringWithFormat:@"Comment.png"]];
    
    //cell.mainImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb_IMG_7632_1024.jpg"]];
    //[cell.mainImage.image setImageWithURL:[NSURL URLWithString:model.standardResolutionImageUrl] placeholderImage:[UIImage imageNamed:@"youtube.png"]];
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.standardResolutionImageUrl] placeholderImage:[UIImage imageNamed:@"youtube.png"]];
    
    cell.likeLabel.text = [NSString stringWithFormat:@"%ld likes", (long)model.numberOfLikes];
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld comments", (long)model.numberOfComments];
    cell.imageUploaderLabel.text = model.postingUserName;
    cell.descriptionLabel.text = model.captionText;
    NSURL *senderImage = [NSURL URLWithString:model.postingUserImageUrl];
    [cell.appLogo sd_setImageWithURL:senderImage placeholderImage:[UIImage imageNamed:@"youtube.png"]];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 477.5;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
