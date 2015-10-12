//
//  MainTabBarViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NavigationViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"


@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //更改工具栏的背景色
    self.tabBar.barTintColor=RGB(280, 146, 200);
    
    //创建子视图控制器
    [self createViewControllers];
    
    
}


-(void)createViewControllers
{
    //心灵鸡汤
    FirstViewController *fvc=[[FirstViewController alloc] init];
    NavigationViewController *first=[[NavigationViewController alloc] initWithRootViewController:fvc];
    first.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"tabbar_limitfree.png"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] selectedImage:[[UIImage imageNamed:@"tabbar_limitfree_press"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    
    //开心一笑
    SecondViewController *svc=[[SecondViewController alloc] init];
    NavigationViewController *second=[[NavigationViewController alloc] initWithRootViewController:svc];
   // second.title=@"降价";
    second.tabBarItem.image=[[UIImage imageNamed:@"tabbar_rank@2x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    second.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_rank_press@2x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    
    //开心视频
    ThreeViewController *tvc=[[ThreeViewController alloc] init];
    NavigationViewController *three=[[NavigationViewController alloc] initWithRootViewController:tvc];
    // three.title=@"免费";
    three.tabBarItem.image=[[UIImage imageNamed:@"tabbar_subject@2x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    three.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_subject_press@2x"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    
    //个人设置
    FourViewController *fovc=[[FourViewController alloc] init];
    NavigationViewController *four=[[NavigationViewController alloc] initWithRootViewController:fovc];
   // four.title=@"专题";
    four.tabBarItem.image=[[UIImage imageNamed:@"tabbar_account@2x.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    four.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_account_press@2x.png"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    
    self.viewControllers=@[first,second,three,four];
    
    
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
