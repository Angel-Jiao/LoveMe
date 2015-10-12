//
//  MainSliderViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MainSliderViewController.h"

#import "MainTabBarViewController.h"
#import "SettingViewController.h"

@interface MainSliderViewController ()

@end

@implementation MainSliderViewController

- (void)viewDidLoad {
    
    
    //切记一定要将这句话放在前面执行，不然会崩掉
    [self createViewController];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
}


//左侧可以出现两个页面，一个是主页面，另一个是左侧的页面
-(void)createViewController
{
    //主页面
    MainTabBarViewController *mainvc=[[MainTabBarViewController alloc] init];
    self.MainVC=mainvc;
    
    
    //左页面
    SettingViewController *leftvc=[[SettingViewController alloc] init];
    self.LeftVC=leftvc;
    
  
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
