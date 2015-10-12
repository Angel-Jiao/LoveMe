//
//  VideoTopTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/14.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VideoModel.h"

typedef void(^JumpBlock2)(NSString *url);

@interface VideoTopTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ptime;
@property (weak, nonatomic) IBOutlet UILabel *playCount;


@property (nonatomic,strong) VideoModel *videomodel;
@property (nonatomic,copy) JumpBlock2 myBlock;


//填充数据
-(void)showDataWithModel:(VideoModel *)model;

@end
