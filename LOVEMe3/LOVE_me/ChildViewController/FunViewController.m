//
//  FunViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/13.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "FunViewController.h"

#import "ArtTableViewCell.h"
#import "ZooCalculateModel.h"
#import "ZooCalculateWebViewController.h"
#import "JHRefresh.h"

#define kRankUrl @"http://www.wezeit.com/?json=core.get_categoryWezeitTag_posts&flag=rand&posts_size=20&post_paged=%ld"




@interface FunViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FunViewController
{
    UITableView *_tableView;
    
    //是加载更多
    BOOL _isLoadingMore;
    BOOL _isRefresh;
    
    //一页的大小
    NSString *_posts_size;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)initData
{
    
    self.data=[[NSMutableArray alloc] init];
    _posts_size=@"20";
    
    //将页码设置为第一页
    [self resetParame];
    
    //获取网络数据
    [self getNetData];
    
    
}

//重置参数
-(void)resetParame
{
    //将参数默认为1，只拿第一页的数据
    self.post_paged=1;
}



//获取网络数据
-(void)getNetData
{
    
    
    //在block中使用变量，要使用弱引用
    __weak typeof(self) weakSelf=self;
    
    NSString *urlString=[NSString stringWithFormat:kRankUrl,self.post_paged];
    
    [NetRequestManager GET:urlString parame:nil succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        //NSLog(@"%@",operation.response.URL);
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *dataAry=[dict objectForKey:@"datas"];
        
        
        if (responseObject)
        {
            if (self.post_paged==1)
            {
                [weakSelf.data removeAllObjects];
                
                for (NSDictionary *datasDict in dataAry)
                {
                    
                    ZooCalculateModel *model=[[ZooCalculateModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:datasDict];
                    
                    [weakSelf.data addObject:model];
                  //  NSLog(@"%@",model);
                }
                
            }
            
            else
            {
                
                
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                for (NSDictionary *datasDict in dataAry)
                {
                    
                    ZooCalculateModel *model=[[ZooCalculateModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:datasDict];
                    
                    [temp addObject:model];
                    
                }
                
                
                [weakSelf.data addObjectsFromArray:temp];
            }
            
        }
        
        
        //调用刷新方法---刷新页面
        [weakSelf refreshView];
        
        
        
        
    } failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    
}


//刷新页面
-(void)refreshView
{
    if (_isRefresh)
    {
        [_tableView headerEndRefreshingWithResult:(JHRefreshResultSuccess)];
        _isRefresh=NO;
    }
    if (_isLoadingMore)
    {
        [_tableView footerEndRefreshing];
        _isLoadingMore=NO;
    }
    
    //专门刷新列表
    [_tableView reloadData];
}



-(void)createView
{
    
    
    //创建tableview
    [self createTableView];
    
    //添加刷新空间
    [self createRefreshView];
    
}



//添加刷新空间
-(void)createRefreshView
{
    //将self改为弱引用
    __weak typeof (self) weakSelf=self;
    
    //添加头部
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
        // NSLog(@"下拉");
        
        weakSelf.isRefresh=YES;
        //当刷新后，要去拿第一页的东西
        [weakSelf resetParame];
        //调用请求---调用的是limit页面的数据请求方法
        [weakSelf getNetData];
        
    }];
    
    
    //添加底部
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        // NSLog(@"上拉");
        
        weakSelf.isLoadingMore=YES;
        
        //增加页码
        weakSelf.post_paged++;
        //获取网络请求---调用的是limit页面的数据请求方法
        [weakSelf getNetData];
        
    }];
    
}



-(void)createTableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    // [_tableView registerClass:[] forCellReuseIdentifier:@"ArtTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ArtTableViewCell" bundle:nil] forCellReuseIdentifier:@"ArtTableViewCell"];
    
    [self.view addSubview:_tableView];
    
}


#pragma mark---UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArtTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ArtTableViewCell" forIndexPath:indexPath];
    
    ZooCalculateModel *model=[self.data objectAtIndex:indexPath.row];
    
    //NSLog(@"%@",model);
    [cell showDataWithModel:model];
    
    
    return cell;
    
    
}





//点击每一个cell进入到详细页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZooCalculateModel *model=[self.data objectAtIndex:indexPath.row];
    
    ZooCalculateWebViewController *detail=[[ZooCalculateWebViewController alloc] initWithArticleModel:model];
    
    //当跳转到详细页面时会隐藏下导航栏
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 218.f;
    
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
