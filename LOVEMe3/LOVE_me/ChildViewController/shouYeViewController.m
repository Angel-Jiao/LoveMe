//
//  shouYeViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/2.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "shouYeViewController.h"
#import "ShouYeModel.h"
#import "ShouYeAryModel.h"
#import "ShouYeTableViewCell.h"
#import "JHRefresh.h"
#import "CellDetailContentViewController.h"


#define shouYeUrlString @"http://iapi.ipadown.com/api/yangshen/index.api.php?siteid=2&catename=%E5%BF%83%E7%81%B5%E7%99%BE%E7%A7%91"

@interface shouYeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation shouYeViewController
{
    UITableView *_tableView;
    NSMutableArray *_data;
    
    UIButton *_button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title=@"心灵鸡汤";
    
  
}



-(void)initData
{
    _data=[[NSMutableArray alloc] init];
}

-(void)createView
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=200;
   // _tableView.tableHeaderView=;
    [self.view addSubview:_tableView];
    
    
    [self getNetData];
    [self createRefreshView];
    
}


-(void)getNetData
{
   // __weak typeof(self) weakSelf=self;
    
    
    [NetRequestManager GET:shouYeUrlString parame:nil succes:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        
        NSArray *listMainAry=[dic objectForKey:@"list"];
        
        for (NSDictionary *listMainDic in listMainAry)
        {
            ShouYeAryModel *modelAry=[[ShouYeAryModel alloc] init];
            modelAry.title=[listMainDic objectForKey:@"title"];
            NSArray *ary=listMainDic[@"list"];
            
            NSMutableArray *Mary=[[NSMutableArray alloc] init];
            //modelAry.list=[[NSMutableArray alloc] init];
            for (NSDictionary *sublistDic in ary)
            {
                ShouYeModel *model=[[ShouYeModel alloc] init];
                model.title=[sublistDic objectForKey:@"title"];
                model.thumb=[sublistDic objectForKey:@"thumb"];
                model.tags=[sublistDic objectForKey:@"tags"];
                model.subcatename=[sublistDic objectForKey:@"subcatename"];
                model.edittime=[sublistDic objectForKey:@"edittime"];
                model.ID=[sublistDic objectForKey:@"ID"];
               
                
               // [modelAry.list addObject:model];
                [Mary addObject:model];
                
                
            }
            
            
            modelAry.list=Mary;
            
            [_data addObject:modelAry];
      //     NSLog(@"%@",modelAry.title);
            
        }
        
        
        [_tableView reloadData];
       
        
    } failed:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
}



-(void)createRefreshView
{
    
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return _data.count;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShouYeAryModel *modelAry=[_data objectAtIndex:section];

    return modelAry.list.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"ShouYeTableViewCell";
    ShouYeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ShouYeTableViewCell" owner:self options:nil] lastObject];
    }
    
    //给每个cell上都填一个右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    ShouYeAryModel *modelAry=[_data objectAtIndex:indexPath.section] ;
   // modelAry.list=[_data objectAtIndex:indexPath.section];
    
    ShouYeModel *model=[modelAry.list objectAtIndex:indexPath.row];
    
    [cell showDataWithModel:model];
    
    return cell;
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ShouYeAryModel *modelAry=[_data objectAtIndex:section];
    return modelAry.title;
  
    
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView=[[UIView alloc] init];
//    ShouYeAryModel *model=[self.data objectAtIndex:section];
//    [headerView sett];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 30;
    }
    else
    {
        return 15;
    }
    
    
}


//给两个组的头标题进行加颜色
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, Default)];
//    view.backgroundColor=RGB(280, 146, 200);
//    return view;
//}




//点击每一个cell进入到详细页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取到数据
     ShouYeAryModel *modelAry=[_data objectAtIndex:indexPath.section];
    ShouYeModel *model=[modelAry.list objectAtIndex:indexPath.row];
    //进入到详细页面
    //进入到详细页面
  //  NSLog(@"%@",model.ID);
    
    CellDetailContentViewController *ccvc=[[CellDetailContentViewController alloc] initWithShouYeModel:model];
    //当控制器被推送出来的时候，就隐藏底部的bar
    ccvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ccvc animated:YES];

    
}












@end
