//
//  ZooCalculateFatherViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"
#import "ZooCalculateModel.h"
#import "ZooCalculateCollectionViewCell.h"
#import "ZooCalculateWebViewController.h"
#import "JHRefresh.h"

@interface ZooCalculateFatherViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//{
//    UICollectionView *_collectionView;
//    NSMutableArray *_data;
//    UITableView *_tableView;
//    NSInteger _currentPage;
//    NSInteger _post_paged;
//    BOOL _isRefreshing;
//    BOOL _isLoadMoring;
//   // AFHTTPRequestOperationManager *_manager;
//    
//}
//


//@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic)NSInteger post_paged;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMoring;

//@property (nonatomic,copy) NSString *category;


@property (nonatomic,copy) NSString *requestUrl;

//获取网络数据
-(void)getNetData;
//重置请求参数---//当刷新后，要去拿第一页的东西
-(void)resetParame;
//刷新页面
-(void)refreshView;







@end
