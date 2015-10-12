//
//  MyFavoriteViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MyFavoriteViewController.h"

#import "CoreData+MagicalRecord.h"
#import "Common.h"

#import "FourViewController.h"

#import "ZooCalculateWebViewController.h"
#import "ZooCalculateModel.h"

//#import "CellDetailContentViewController.h"
//#import "FatherModel.h"


#import "MyFavoriteTableViewCell.h"


@interface MyFavoriteViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
}

//@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation MyFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //定制一个左按钮，点击进行返回
    UIBarButtonItem *backEdit = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnBackClick:)];
    self.navigationItem.leftBarButtonItem = backEdit;
    
    
    
    
    //定制一个右按钮，作用是编辑每个cell
    UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnEditClick:)];
    self.navigationItem.rightBarButtonItem = btnEdit;
    
    
    _data=[[NSMutableArray alloc] init];
    
    
    //初始化表格
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
    //从数据库获取本地保存的收藏数据
    NSArray *arr=[Common MR_findAll];
    [_data addObjectsFromArray:arr];
    
    
    //刷新表格
    [_tableView reloadData];

}


//返回按钮
-(void)onBtnBackClick:(UIBarButtonItem *)sender
{
   // FourViewController *four=[[FourViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}




//编辑按钮的事件
- (void)onBtnEditClick:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"完成";
        [_tableView setEditing:YES animated:YES];//进入编辑状态
    }else {
        sender.title = @"编辑";
        [_tableView setEditing:NO animated:YES];//退出编辑状态
    }
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
    static NSString *identifier=@"MyFavoriteTableViewCell";
    MyFavoriteTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyFavoriteTableViewCell" owner:self options:nil] lastObject];
        
    }
    
    Common *commonModel=[_data objectAtIndex:indexPath.row];
    
    [cell showDataWithModel:commonModel];
   // cell.textLabel.text=commonModel.title;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //消除选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取到数据
    Common *commonmodel=[_data objectAtIndex:indexPath.row];
    //进入到详细页面
    ZooCalculateWebViewController *zooWeb=[[ZooCalculateWebViewController alloc] initWithArticleURL:commonmodel.articleurl];
   
    //当控制器被推送出来的时候，就隐藏底部的bar
    zooWeb.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:zooWeb animated:YES];
 
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}




#pragma mark---删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}





-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Common *model=_data[indexPath.row];
    [model MR_deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
    [_data removeObjectAtIndex:indexPath.row];
    
    NSArray *rowTodelete=[NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:rowTodelete withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [_tableView reloadData];
    
//    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
//    
//    
//    
//    
//    NSArray *rowTodelete=[NSArray arrayWithObject:indexPath];
//    //删除tableView中指定的行
//    [tableView deleteRowsAtIndexPaths:rowTodelete withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end












