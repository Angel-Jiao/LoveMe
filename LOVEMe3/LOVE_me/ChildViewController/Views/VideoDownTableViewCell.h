//
//  VideoDownTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/14.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoModel.h"
#import <MediaPlayer/MediaPlayer.h>

typedef void(^JumpBlock1)(NSString *url);


@interface VideoDownTableViewCell : UITableViewCell
{
    MPMoviePlayerViewController *_mpVc;
}


@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ptime;
@property (weak, nonatomic) IBOutlet UILabel *playCount;



@property (nonatomic,strong) VideoModel *videomodel;
@property (nonatomic,copy) JumpBlock1 myBlock;

//填充数据
-(void)showDataWithModel:(VideoModel *)model jumpBlock:(JumpBlock1)myBlock;




@end
