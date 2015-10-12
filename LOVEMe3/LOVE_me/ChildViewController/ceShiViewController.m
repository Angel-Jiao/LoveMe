//
//  ceshiViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ceshiViewController.h"

#import "MMProgressHUD.h"

#define xinLiceShiUrl @"http://iapi.ipadown.com/api/yangshen/page.list.api.php?siteid=2&catename=%@&subcatename=%@&p=%ld&pagesize=20"

#define catenameString @"%E5%BF%83%E7%81%B5%E7%99%BE%E7%A7%91"
#define subcatenameString @"%E5%BF%83%E7%90%86%E6%B5%8B%E8%AF%95"


@interface ceShiViewController ()
{
    //一页的大小
    NSString *_pagesize;
}


@end

@implementation ceShiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"心理测试";
    
    
    
}




-(void)initData
{
    _pagesize=@"20";
    
    //将页码设置为第一页
    [self resetParame];
    
    //获取网络数据
    [self getNetData];
    
}


//重置参数
-(void)resetParame
{
    //将参数默认为1，只拿第一页的数据
    self.p=1;
}

//获取网络数据
-(void)getNetData
{
    
    
    //在block中使用变量，要使用弱引用
    __weak typeof(self) weakSelf=self;
    ///http://iapi.ipadown.com/api/yangshen/page.list.api.php?siteid=2&catename=%E5%BF%83%E7%81%B5%E7%99%BE%E7%A7%91&subcatename=%E5%BF%83%E7%81%B5%E6%8E%A2%E7%A7%98&p=1&pagesize=20
    
    [MMProgressHUD setPresentationStyle:(MMProgressHUDPresentationStyleSwingLeft)];
    [MMProgressHUD showWithTitle:@"下载数据" status:@"Loading..."];
    
    NSString *urlString=[NSString stringWithFormat:xinLiceShiUrl,catenameString,subcatenameString,self.p];
    
    [NetRequestManager GET:urlString parame:nil succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        //NSLog(@"%@",operation.response.URL);
        if (self.p==1)
        {
            weakSelf.data=[[FatherArrayModel alloc] initWithData:responseObject error:nil];
        }
        
        else
        {
            FatherArrayModel *temp=[[FatherArrayModel alloc] initWithData:responseObject error:nil];
            [weakSelf.data.results addObjectsFromArray:temp.results];
        }
        
        //调用刷新方法---刷新页面
        [weakSelf refreshView];
        
         [MMProgressHUD dismissWithSuccess:@"下载数据" title:@"OK"];
        
        
    } failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MMProgressHUD dismissWithError:@"下载数据" title:@"失败"];
        
    }];
    
    
    
}



-(void)createView
{
    [super createView];
    
    
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
