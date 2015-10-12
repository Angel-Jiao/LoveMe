//
//  ZooCalculateFatherViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ZooCalculateFatherViewController.h"





@interface ZooCalculateFatherViewController ()
{
    UICollectionView *_collection;
    
    //是否加载更多
    BOOL isRefreshing;
    BOOL isLoadMoring;
    
}

@end

@implementation ZooCalculateFatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

//刷新页面
-(void)refreshView
{
    
    if (self.isRefreshing)
    {
        [_collection headerEndRefreshingWithResult:(JHRefreshResultSuccess)];
        self.isRefreshing=NO;
    }
    
    if (_isLoadMoring)
    {
        [_collection footerEndRefreshing];
        _isLoadMoring=NO;
    }
    
    [_collection reloadData];
    
}

-(void)createView
{
    
    //创建CollectionView
    [self creatCollectionView];
    //添加刷新空间
    [self createRefreshView];
    
    
}

 //添加刷新空间
-(void)createRefreshView
{
    //将self改为弱引用
    __weak typeof (self) weakSelf=self;
    
    //添加头部
    [_collection addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
        // NSLog(@"下拉");
        
        weakSelf.isRefreshing=YES;
        //当刷新后，要去拿第一页的东西
        [weakSelf resetParame];
        //调用请求---调用的是limit页面的数据请求方法
        [weakSelf getNetData];
        
        
    }];
    
    
    
    //添加底部
    [_collection addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        // NSLog(@"上拉");
        
        weakSelf.isLoadMoring=YES;
        
        //增加页码
        weakSelf.post_paged++;
        //获取网络请求---调用的是limit页面的数据请求方法
        [weakSelf getNetData];
        
        
    }];
    

}




//获取网络数据
-(void)getNetData
{
    //用来让姿势图控制器重写，在俯视图页面没有任何作用
    
}

//重置请求参数
-(void)resetParame
{
    //用来让姿势图控制器重写，在俯视图页面没有任何作用
}



//创建CollectionView
-(void)creatCollectionView
{
   // self.data=[[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc] init];
   flow.sectionInset=UIEdgeInsetsMake(5, (ScreenWidth1-141*2)/3, 5, (ScreenWidth1-141*2)/3);

    self.automaticallyAdjustsScrollViewInsets=NO;
    //是布局的方向是垂直的
    flow.scrollDirection=UICollectionViewScrollDirectionVertical;
    self.collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.height-34-64) collectionViewLayout:flow];
    self.collection.dataSource=self;
    self.collection.delegate=self;
    self.collection.backgroundColor=[UIColor whiteColor];
    //注册xib的cell
    [self.collection registerNib:[UINib nibWithNibName:@"ZooCalculateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ZooCalculateCollectionViewCell"];
    
    //可以给collectionview设置背景
    //self.collection.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景图"]];
    
    [self.view addSubview:self.collection];
    
    
    
}



#pragma mark---代理实现的方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZooCalculateCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ZooCalculateCollectionViewCell" forIndexPath:indexPath];
    
    ZooCalculateModel *model=[self.data objectAtIndex:indexPath.row];
    
    [cell showDataWithModel:model];
    
    return cell;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(141,200);
}


//当点击每个小布局时，会
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZooCalculateModel *model=[self.data objectAtIndex:indexPath.row];
    
    ZooCalculateWebViewController *detail=[[ZooCalculateWebViewController alloc] initWithArticleModel:model];
   
    //当跳转到详细页面时会隐藏下导航栏
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
