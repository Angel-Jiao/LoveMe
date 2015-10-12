//
//  SettingViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "SettingViewController.h"
#import "MyBiJiViewController.h"

#import "ViewPointViewController.h"
#import "WeViewController.h"
#import "HelpViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
    NSMutableArray *_imageData;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initdata];
    
    [self createView];
    
}



-(void)initdata
{
    
    _data=[[NSMutableArray alloc] initWithObjects:@"",@"我的心情笔记",@"意见反馈",@"关于我们",@"帮助", nil];
    _imageData=[[NSMutableArray alloc] initWithObjects:@"",@"personalCenter_col_logo",@"plaza_examination",@"personalCenter_visitor_logo",@"plaza_activity",nil];
}




-(void)createView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 145, self.view.frame.size.width, 300) style:(UITableViewStylePlain)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    //设置背景色
    _tableView.backgroundColor=[UIColor clearColor];//使表格的背景显示为添加的背景图片，而不是白色
    //分割线的颜色
   // _tableView.separatorColor=[UIColor yellowColor];
    //分割线的风格
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //允许单项选择，默认是单项
    _tableView.allowsMultipleSelection=NO;
    //为其添加背景图片
    UIImageView *image=[[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image=[UIImage imageNamed:@"美女19.jpg"];
    image.userInteractionEnabled=YES;
    [self.view addSubview:image];
    [image addSubview:_tableView];
    
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




#pragma mark---UITableViewDataSource,UITableViewDelegate

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
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text=[_data objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[_imageData objectAtIndex:indexPath.row]];
    //给tableview上的字体的颜色设置为白色
    cell.textLabel.textColor=[UIColor whiteColor];
    //设置字体的大小
    cell.textLabel.font=[UIFont fontWithName:@"Khmer" size:16];
    
    cell.backgroundColor=[UIColor clearColor];
    
    
    //给每个cell上都填一个右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}








//每行对应的详细页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消每行的选中状态
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row)
    {
        case 1://我的心情笔记
        {
            //第一个界面 切换到第二个界面,我们需要看到一个转场的动画
            //这时我们可以用CATransition 给导航控制器view的layer
            //1.创建底层动画
            CATransition *animation = [CATransition animation];
            //2.设置动画的类型
            animation.type = @"cube";
            //3.设置动画的方向
            animation.subtype = @"fromright";
            //4.设置动画的时间
            animation.duration = 0.5;
            //5.设置动画的节奏
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //6.把动画增加到导航的view 的layer
            
            //在转场之前把动画导入 导航的view的layer
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            
            MyBiJiViewController *mvc=[[MyBiJiViewController alloc] init];
            
            [self.navigationController pushViewController:mvc animated:YES];
            
        }
            break;
            
//@"",@"我的心情笔记",@"意见反馈",@"关于我们",@"帮助"
        case 2://@"意见反馈"
        {
            /*
             界面1 要跳转到界面2 我们需要一个绚丽的跳转效果，这时我们可以使用转场动画
             1.创建转场动画对象
             2.转场动画 需要加在  视图的layer层(发生转场效果的view的父视图的layer)
             //导航的子视图控制器 都在导航的view上
             */
            //1.实例化一个动画对象
            CATransition *animation = [CATransition animation];
            //2.动画的类型
            /*
             kCATransitionFade 全局变量
             或者 字符串 @"fade"
             */
            animation.type = @"suckEffect";
            //3.动画的方向
            animation.subtype = @"fromLeft";//或kCATransitionFromLeft
            //4.动画时间
            animation.duration = 3;
            //5.动画节奏
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//匀速
            
            //6.把动画添加到导航的view的layer
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            
            ViewPointViewController *viewPoint=[[ViewPointViewController alloc] init];
            
            [self.navigationController pushViewController:viewPoint animated:YES];
        }
            break;
            
        case 3://@"关于我们"
        {
            //1.创建底层动画
            CATransition *animation = [CATransition animation];
            //2.设置动画的类型
            animation.type = @"cameraIrisHollowOpen";
            //3.设置动画的方向
            animation.subtype = @"90ccw";
            //4.设置动画的时间
            animation.duration = 0.5;
            //5.设置动画的节奏
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //6.把动画增加到导航的view 的layer
            
            //在转场之前把动画导入 导航的view的layer
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            
            WeViewController *we=[[WeViewController alloc] init];
            
            [self.navigationController pushViewController:we animated:YES];
            
        }
            break;
            
        case 4://@"帮助"
        {
            //1.创建底层动画
            CATransition *animation = [CATransition animation];
            //2.设置动画的类型
            animation.type = @"cameraIrisHollowOpen";
            //3.设置动画的方向
            animation.subtype = @"90ccw";
            //4.设置动画的时间
            animation.duration = 0.5;
            //5.设置动画的节奏
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //6.把动画增加到导航的view 的layer
            
            //在转场之前把动画导入 导航的view的layer
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            
            HelpViewController *help=[[HelpViewController alloc] init];
            
            [self.navigationController pushViewController:help animated:YES];
            
            
        }
            break;
            
        default:
            break;
    }
    
}


































@end
