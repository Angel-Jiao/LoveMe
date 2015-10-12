//
//  MyBiJiCellViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/5.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MyBiJiCellViewController.h"

@interface MyBiJiCellViewController ()<UITextViewDelegate>

@end

@implementation MyBiJiCellViewController
{
    UITextView *_text;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.view.backgroundColor=[UIColor whiteColor];
    
    
//    UIButton *leftbutton=[Factory createButtonWithTitle:@"返回" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toBackClicked:)];
//        [self createNavigationLeftButton:leftbutton];
//    
//    
//    UIButton *rightbutton=[Factory createButtonWithTitle:@"保存" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toSaveClicked:)];
//        [self createNavigationRightButton:rightbutton];

    UIButton *BackButton=[Factory createButtonWithTitle:@"返回" frame:CGRectMake(20, 20, 50, 40) target:self selector:@selector(toBackclicked:)];
     [BackButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:BackButton];
    
//    UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonSystemItemAdd target:self action:nil];
//    self.navigationItem.leftBarButtonItem=left;
    
    UIButton *SaveButton=[Factory createButtonWithTitle:@"保存" frame:CGRectMake(self.view.width-70, 20, 50, 40) target:self selector:@selector(toSaveclicked:)];
     [SaveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:SaveButton];
    
    
  
}


//返回到上一层
-(void)toBackclicked:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popToRootViewControllerAnimated:YES];
   //  [self.navigationController popViewControllerAnimated:YES];
}



-(void)toSaveclicked:(UIButton *)button
{
    
    self.contentText=_text.text;
   // NSLog(@"%@",self.contentText);
    if (self.delegate) {
        [self.delegate DetailViewControllerDelegateSave:self];
    }
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
}



-(void)createView
{
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pu4.png"]];
    image.userInteractionEnabled=YES;
    image.frame=self.view.frame;
    [self.view addSubview:image];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 30, self.view.frame.size.width-200, 20)];
    label.text=@"我的心情笔记";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [image addSubview:label];
    
     _text=[[UITextView alloc] initWithFrame:CGRectMake(0, 80, self.view.width, 350)];
    _text.font=[UIFont systemFontOfSize:20];
   // _text.backgroundColor=[UIColor clearColor];
    _text.textColor=[UIColor blackColor];
    _text.scrollEnabled=YES;
    _text.alpha=0.6;
    _text.delegate=self;
    _text.editable=YES;
    _text.tag=10;
    [self.view addSubview:_text];
    
    if (self.navigationController!=nil)
    {
        _text.text=self.contentText;
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextView *textView=(UITextView *)[self.view viewWithTag:10];
    [textView resignFirstResponder];
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
