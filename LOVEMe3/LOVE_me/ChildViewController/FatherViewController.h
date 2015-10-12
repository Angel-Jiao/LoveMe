//
//  FatherViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"

#import "FatherModel.h"
#import "FatherArrayModel.h"

@interface FatherViewController : BaseViewController


//用来做页面计数（当被调用的时候，一定要用弱引用）----一定要写assign----页码参数的把控
@property (nonatomic,strong) FatherArrayModel *data;
@property (nonatomic,assign) NSInteger p;
@property (nonatomic,assign) BOOL isLoadingMore;
@property (nonatomic,assign) BOOL isRefresh;
@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,retain) UIAlertView *alertView;



//要实现的方法
//将分类的展示方法，公开
//这样子试图控制器就可以重写这个方法
//-(void)toShowAppClassify;
//获取网络数据
-(void)getNetData;
//重置请求参数---//当刷新后，要去拿第一页的东西
-(void)resetParame;
//刷新页面
-(void)refreshView;







@end
