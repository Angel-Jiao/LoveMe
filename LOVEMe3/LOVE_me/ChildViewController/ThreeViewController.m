//
//  ThreeViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ThreeViewController.h"

#import "JHRefresh.h"

#import "VideoModel.h"
#import "VideoTopTableViewCell.h"
#import "VideoDownTableViewCell.h"

#define VideoUrl @"http://c.3g.163.com/nc/video/list/V9LG4B3A0/y/%ld-10.html"




@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MPMoviePlayerViewController *_mpVC;
    
    
    UITableView *_tableView;
    
    //是加载更多
    BOOL _isLoadingMore;
    BOOL _isRefresh;
    
    //一页的大小
    NSInteger _page;
}


//@property (nonatomic) NSInteger page;
//@property (nonatomic) NSInteger count;



@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"开心视频";
    
    
    
    UIButton *leftbutton=[Factory createButtonWithTitle:@"" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toGetAnotherView)];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"personalCenter_col_logo"] forState:(UIControlStateNormal)];
    [self createNavigationLeftButton:leftbutton];

    
    
}




//跳转到setting页面
-(void)toGetAnotherView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:self];
}






-(void)initData
{
    
    self.data=[[NSMutableArray alloc] init];
    _page=0;
    
    //将页码设置为第一页
    [self resetParame];
    
    //获取网络数据
    [self getNetData];
    
    
}

//重置参数
-(void)resetParame
{
    //将参数默认为1，只拿第一页的数据
    self.page=0;
}



//获取网络数据
-(void)getNetData
{
    
    
    //在block中使用变量，要使用弱引用
    __weak typeof(self) weakSelf=self;
    
    NSString *urlString=[NSString stringWithFormat:VideoUrl,self.page];
    
    [NetRequestManager GET:urlString parame:nil succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      //  NSLog(@"%@",responseObject);
        //NSLog(@"%@",operation.response.URL);
        
        if (responseObject)
        {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            NSArray *dataAry=[dict objectForKey:@"V9LG4B3A0"];
            
            for (NSDictionary *dic in dataAry)
            {
                VideoModel *model=[[VideoModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.data addObject:model];
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
        weakSelf.page+=10;
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
    
    //上面的cell
    [_tableView registerNib:[UINib nibWithNibName:@"VideoTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoTopTableViewCell"];
    
    //下面的cell
    [_tableView registerNib:[UINib nibWithNibName:@"VideoDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoDownTableViewCell"];
    
    
    
    
    [self.view addSubview:_tableView];
    
}




#pragma mark---代理


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0)
    {
        VideoTopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"VideoTopTableViewCell"];
        if (cell==nil)
        {
            cell=[[NSBundle mainBundle] loadNibNamed:@"VideoTopTableViewCell" owner:self options:nil][0];
        }
        
        VideoModel *model=[_data objectAtIndex:indexPath.row];
        
        [cell showDataWithModel:model];
        
        return cell;
        
    }
    else
    {
        VideoModel *model=[_data objectAtIndex:indexPath.row-1];
        
        VideoDownTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"VideoDownTableViewCell"];
        
        if (cell==nil)
        {
            cell=[[NSBundle mainBundle] loadNibNamed:@"VideoDownTableViewCell" owner:self options:nil][0];
        }
        
        __weak typeof(self) mySelf=self;
        
        [cell showDataWithModel:model jumpBlock:^(NSString *url) {
            
            [mySelf createVideoWithPath:url];
            
        }];
        
        return cell;
        
    }
    
    
}


-(void)createVideoWithPath:(NSString *)path
{
    NSURL *url=nil;
    
    if ([path hasPrefix:@"http://"]||[path hasPrefix:@"https://"])
    {
        //网络视频
        url=[NSURL URLWithString:path];//加载网络地址，转化为NSURL
    }
    else
    {
        url=[NSURL fileURLWithPath:path];
    }
    
    //注册一个观察者对象，监听视频是否播放完毕（1.点击Done  2.正常播放完  3.异常）
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    if (!_mpVC)
    {
        //将 MPMoviePlayerViewController 实例化
        _mpVC=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        //是否允许自动播放
        _mpVC.moviePlayer.shouldAutoplay=YES;
        
    }
    
    //播放
    [_mpVC.moviePlayer play];
    
    //模态跳转
    [self presentViewController:_mpVC animated:YES completion:nil];
    
    
}


-(void)playVideoBack:(NSNotification *)nf
{
    NSLog(@"播放完毕");
    NSLog(@"info:%@",nf.userInfo); //通知对象的内容
    
    //获取返回的原因
    NSInteger type=[nf.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]integerValue];
    if (type==0)
    {
        NSLog(@"正常播放结束返回");
    }
    else if (type==1)
    {
        NSLog(@"异常播放");
    }
    else if (type==2)
    {
        NSLog(@"点击Done返回");
    }
    
    if (_mpVC)
    {
        [_mpVC.moviePlayer stop];//停止播放
        _mpVC=nil;
    }
    
    //用完观察者要删除
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //模态返回
    [_mpVC dismissViewControllerAnimated:YES completion:nil];

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playOver:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    VideoModel *model=[_data objectAtIndex:indexPath.row];
    
    if (!self.player)
    {
        self.player=[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model.mp4_url]];
        self.player.moviePlayer.shouldAutoplay=YES;
    }
    
    [self.player.moviePlayer prepareToPlay];
    [self presentViewController:self.player animated:YES completion:nil];
    
    
}


-(void)playOver:(NSNotification *)noti
{
    if (self.player)
    {
        [self.player.moviePlayer stop];
        self.player=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 233;
    }
    else
    {
        return 90;
    }
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
