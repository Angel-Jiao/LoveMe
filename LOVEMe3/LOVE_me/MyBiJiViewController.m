//
//  MyBiJiViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/5.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MyBiJiViewController.h"
#import "MyBiJiCellViewController.h"

@interface MyBiJiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
    
    NSInteger _currentRow;
    
    UISearchBar *_searchBar;//搜索框
    NSMutableArray *_searchResult;//搜索结果
    UISearchDisplayController *_searchDispCtrl;
    
    
    
}

@end

@implementation MyBiJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //给心情笔记页面添加一个背景图片
//    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"美女22.png"]];
//    image.userInteractionEnabled=YES;
//    image.frame=self.view.frame;
//    [self.view addSubview:image];
    
//    self.navigationItem.title=@"我的心情笔记";
//    UIBarButtonItem *rightBtnAdd= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onBtnClick)];
//    self.navigationItem.rightBarButtonItem= rightBtnAdd;
    
    
    UIButton *BackButton=[Factory createButtonWithTitle:@"返回" frame:CGRectMake(20, 20, 50, 40) target:self selector:@selector(toBackclicked)];
    [BackButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:BackButton];
    
    
    
    
    UIButton *Addbutton=[Factory createButtonWithTitle:@"添加" frame:CGRectMake(self.view.width-70, 20, 50, 40) target:self selector:@selector(toAddclicked)];
     [Addbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:Addbutton];
    
    
    
}


-(void)toBackclicked
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


//点击添加，则会进入到下一个页面
-(void)toAddclicked
{
    _currentRow=-1;
    MyBiJiCellViewController *alterVC=[[MyBiJiCellViewController alloc] init];
    alterVC.delegate=self;
    
    [self presentViewController:alterVC animated:YES completion:nil];
    
    
}






-(void)initData
{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    
    _data=[[NSMutableArray alloc] init];
    [_data addObjectsFromArray:[userDef objectForKey:@"addresses"]];
    _searchResult=[[NSMutableArray alloc] init];
    
    
}


-(void)createView
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, 375, self.view.height-64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置背景色
    _tableView.backgroundColor=[UIColor clearColor];
    //分割线的颜色
    _tableView.separatorColor=[UIColor yellowColor];
    //分割线的风格
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    //允许单项选择，默认是单项
    _tableView.allowsMultipleSelection=NO;
    //为其添加背景图片
//    UIImageView *image=[[UIImageView alloc] initWithFrame:self.view.bounds];
//    image.image=[UIImage imageNamed:@"美女22.jpg"];
//    image.userInteractionEnabled=YES;
//    
//    [self.view addSubview:image];
//    [image addSubview:_tableView];
    
    
    

    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 60, self.view.width, 40)];
    //_tableView.tableHeaderView = _searchBar;
    [self.view addSubview:_searchBar];
    _searchDispCtrl = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    
    _searchDispCtrl.searchResultsDataSource = self;
    _searchDispCtrl.searchResultsDelegate = self;
    

    
}



//代理方法----保存
-(void)DetailViewControllerDelegateSave:(MyBiJiCellViewController *)alterVC
{
    
    NSDictionary *address=@{@"contentText":alterVC.contentText};
    if (_currentRow==-1)
    {
        [_data addObject:address];
    }
    else
    {
        [_data replaceObjectAtIndex:_currentRow withObject:address];
    }
    
    [_tableView reloadData];
    
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults setObject:_data forKey:@"addresses"];
    
    [userDefults synchronize];

    
    
    
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




#pragma mark---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    
    if (tableView !=_tableView )
    {
        cell.textLabel.text = _searchResult[indexPath.row][@"contentText"];
    }
    else
    {
        cell.textLabel.text =[[_data objectAtIndex:indexPath.row] valueForKey:@"contentText"];
    }
  //  cell.textLabel.textColor=[UIColor whiteColor];
    
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentRow = indexPath.row;
    
    MyBiJiCellViewController *alterVC = [[MyBiJiCellViewController alloc] init];
    alterVC.delegate = self;
    alterVC.contentText = _data[indexPath.row][@"contentText"];
    [self.navigationController pushViewController:alterVC animated:YES];
    //[self presentViewController:alterVC animated:YES completion:nil];

}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView!=_tableView) {//搜索结果
//        return @"搜索结果";
//    }
//    //原始数据
//    return [NSString stringWithFormat:@"Section:%ld",section];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != _tableView) {
        [_searchResult removeAllObjects];
        for (NSDictionary *sectionData in _data) {
            NSRange range1 =[[sectionData valueForKey:@"contentText"] rangeOfString:_searchBar.text];
            if (range1.location != NSNotFound )
            {
                [_searchResult addObject:sectionData];
            }
        }
        return _searchResult.count;
        
    }
    else
    {
        return _data.count;
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_tableView resignFirstResponder];
}



#pragma mark---每行cell的编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //允许删除
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    [_data removeObjectAtIndex:indexPath.row];
    //偷懒的一种写法
    //[_tableView reloadData];
    
    NSUserDefaults *defaluts=[NSUserDefaults standardUserDefaults];
    [defaluts setObject:_data forKey:@"addresses"];
    NSArray *rowTodelete=[NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:rowTodelete withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    
}





@end












