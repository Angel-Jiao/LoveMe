//
//  WeViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "WeViewController.h"

@interface WeViewController ()

@end

@implementation WeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initBackgroudImage];
    [self show];
}


-(void)show
{
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(110, 0,self.view.bounds.size.width-150 ,500  )];
    
    lable.text=@"     你好，欢迎你使用此应用！这款App目的是传递正能量，令大家在忙忙碌碌的生活中感受到快乐，为自己的生活增添色彩。人生是一种承受，承受幸福，承受平淡，承受等待与无奈，承受孤独，承受失败，承受责任，承受爱情，心灵更臻充盈、完美。也许此应用还存在许多值得去完善的地方，但是请相信我们，一定会给你满意的服务。";
    //lable.textColor=[UIColor whiteColor];
    lable.numberOfLines=0;
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
   // [self dismissViewControllerAnimated:YES completion:nil];
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
