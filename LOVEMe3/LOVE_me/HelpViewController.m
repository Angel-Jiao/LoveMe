//
//  HelpViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "HelpViewController.h"

#import "SettingViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initBackgroudImage];
    [self show];
}



//-(void)createView
//{
//    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xin.png"]];
//    image.userInteractionEnabled=YES;
//    image.frame=self.view.frame;
//    [self.view addSubview:image];
//    
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 100, self.view.frame.size.width-20, 200)];
//    label.text=@"亲，当您在记录您的心情笔记的时候，可以向左滑动，进行每一行的删除。";
//    label.textAlignment=NSTextAlignmentCenter;
//    [image addSubview:label];
//    
//}

-(void)show
{
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(110, 0,self.view.bounds.size.width-150 ,500 )];
    
    lable.text=@"    你好，欢迎你使用此应用！当您在记录您的心情笔记的时候，可以向左滑动，进行每一行的删除。当您喜欢某一个页面或主题时，可以点击收藏进行收藏，在个人收藏中查看。当然也可以与您的朋友进行分享，实时记录自己的点滴。";
    lable.numberOfLines=0;
   // lable.textColor=[UIColor whiteColor];
    [self.view addSubview:lable];
}


-(void)initBackgroudImage
{
    UIImageView *baImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    baImageView.image = [UIImage imageNamed:@"lanse"];
    [self.view addSubview:baImageView];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
