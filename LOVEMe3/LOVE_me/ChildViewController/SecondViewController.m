//
//  SecondViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "SecondViewController.h"

#import "FunViewController.h"
#import "ArtViewController.h"
#import "CalculateViewController.h"
#import "ZooViewController.h"


#import "WMPageController.h"



@interface SecondViewController ()

@end

@implementation SecondViewController
-(BOOL)prefersStatusBarHidden
{
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    UIButton *leftbutton=[Factory createButtonWithTitle:@"" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toGetAnotherView)];
//    [leftbutton setBackgroundImage:[UIImage imageNamed:@"tab_5_xunbao_default@2x"] forState:(UIControlStateNormal)];
//    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithCustomView:leftbutton];

    
    self.title=@"开心一刻";
    
    WMPageController *pageController=[self getDefaultController];
    NSArray *ary=[NSArray arrayWithObject:pageController];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 0, 100, 30)];
    titleLabel.text=@"开心一刻";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:16.f];
    //添加左按钮，进行点击时进行跳转到设置页面
    pageController.navigationItem.titleView=titleLabel;
    
   // pageController.navigationItem.leftBarButtonItem=left;
    [self.navigationController setViewControllers:ary animated:YES];
    
    
}


////跳转到setting页面
//-(void)toGetAnotherView
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:self];
//}
//



-(WMPageController *)getDefaultController
{
    NSMutableArray *viewControllers=[[NSMutableArray alloc] init];
    NSMutableArray *titles=[[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++)
    {
        Class vcClass;
        NSString *title;
        switch (i%4)
        {
            case 0:
                vcClass=[ZooViewController class];
                title=@"小可爱";
                break;
            case 1:
                vcClass=[CalculateViewController class];
                title=@"测试";
                break;
            case 2:
                vcClass=[ArtViewController class];
                title=@"艺术";
                break;
            case 3:
                vcClass=[FunViewController class];
                title=@"娱乐";
                break;
                
            default:
                break;
        }
        
        [viewControllers addObject:vcClass];
        [titles addObject:title];
    }
    
    WMPageController *pageVC=[[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.titleSizeSelected=16;
    pageVC.pageAnimatable=YES;
    /*
     WMMenuViewStyleDefault,     // 默认
     WMMenuViewStyleLine,        // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
     WMMenuViewStyleFoold,       // 涌入效果 (填充)
     WMMenuViewStyleFooldHollow, // 涌入效果 (空心的)
     */
    pageVC.menuViewStyle=WMMenuViewStyleFoold;
    pageVC.titleColorSelected=[UIColor whiteColor];
    pageVC.titleColorNormal=[UIColor blackColor];
    
    pageVC.progressColor=RGB(280, 146, 200);
    
    return pageVC;
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
