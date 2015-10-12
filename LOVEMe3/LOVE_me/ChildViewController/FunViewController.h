//
//  FunViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/13.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"

@interface FunViewController : BaseViewController




@property (nonatomic) BOOL isRefresh;
@property (nonatomic)  BOOL isLoadingMore;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic)NSInteger post_paged;
@property (nonatomic,strong) UITableView *tableView;

//获取网络数据
-(void)getNetData;
//重置请求参数---//当刷新后，要去拿第一页的东西
-(void)resetParame;
//刷新页面
-(void)refreshView;







@end
