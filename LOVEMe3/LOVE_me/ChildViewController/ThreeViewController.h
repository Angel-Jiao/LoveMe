//
//  ThreeViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface ThreeViewController : BaseViewController


@property (nonatomic) BOOL isRefresh;
@property (nonatomic)  BOOL isLoadingMore;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic)NSInteger page;
@property (nonatomic,strong) UITableView *tableView;

//获取网络数据
-(void)getNetData;
//重置请求参数---//当刷新后，要去拿第一页的东西
-(void)resetParame;
//刷新页面
-(void)refreshView;




@property (nonatomic,strong) MPMoviePlayerViewController *player;


@end
