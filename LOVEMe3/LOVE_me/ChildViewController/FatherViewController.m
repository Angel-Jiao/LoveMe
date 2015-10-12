//
//  FatherViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "FatherViewController.h"

#import "JHRefresh.h"
#import "FatherTableViewCell.h"

#import "CellDetailContentViewController.h"

@interface FatherViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    
    //是加载更多
    BOOL _isLoadingMore;
    BOOL _isRefresh;
}

@end

@implementation FatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    
//    UIButton *leftbutton=[Factory createButtonWithTitle:@"设置" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toGetAnotherView)];
//    [self createNavigationLeftButton:leftbutton];
//    [Factory createButtonWithTitle:@"分类" frame:CGRectMake(0, 5, 40, 30) titleFont:12.f textColor:[UIColor blackColor] backgroundColor:RGB(200, 200, 200) target:self selector:@selector(toShowAppClassify)];
    
    
    
//    UIButton *rightbutton=[Factory createButtonWithTitle:@"设置" frame:CGRectMake(0, 5, 40, 30) titleFont:12.f textColor:[UIColor blackColor] backgroundColor:RGB(200, 200, 200) target:self selector:@selector(toAppShowSetting)];
//    [self createNavigationRightButton:rightbutton];
    
    
        
    
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
        weakSelf.p++;
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



-(void)createTableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}




////左按钮---分类
//-(void)toShowAppClassify
//{
//    
//    //不做实现，只为消除警告
//    
//}




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

#pragma mark---UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"XinLiJiTang";
    FatherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FatherTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    FatherModel *model=[_data.results objectAtIndex:indexPath.row];
    
   
    [cell showDataWithModel:model];
    
    return cell;
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}


//点击每一个cell进入到详细页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //消除选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取到数据
    FatherModel *model=[_data.results objectAtIndex:indexPath.row];
    //进入到详细页面
    CellDetailContentViewController *ccvc=[[CellDetailContentViewController alloc] initWithFatherModel:model];
    
    //当控制器被推送出来的时候，就隐藏底部的bar
    ccvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ccvc animated:YES];
    
    
}





@end
