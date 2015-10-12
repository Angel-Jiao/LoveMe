//
//  ZooViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ZooViewController.h"



#define kZooUrl @"http://www.wezeit.com/?json=core.get_categoryWezeitTag_posts&flag=zoo&posts_size=20&post_paged=%ld"

@interface ZooViewController ()
{
    //一页的大小
    NSString *_posts_size;
}

@end

@implementation ZooViewController

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
    
    NSString *urlString=[NSString stringWithFormat:kZooUrl,(long)self.post_paged];
  //  NSLog(@"%@",urlString);
    [NetRequestManager GET:urlString parame:nil succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"%@",responseObject);
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
                       // NSLog(@"%@",model.ArticleURL);
                }
                
            }
            
            else
            {
                
                
                NSMutableArray *temp=[[NSMutableArray alloc] init];
                for (NSDictionary *datasDict in dataAry)
                {
                    
                    ZooCalculateModel *model=[[ZooCalculateModel alloc] init];
                    
                    [model setValuesForKeysWithDictionary:datasDict];
                   // NSLog(@"%@",model.Title);
                
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
