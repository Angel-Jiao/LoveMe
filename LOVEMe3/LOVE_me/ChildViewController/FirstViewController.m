//
//  FirstViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "FirstViewController.h"
#import "WMJTitleLable.h"

@interface FirstViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_smallScrollView;
    
    UIView *_lineView;
    
    UIScrollView *_bigScrollview;
    
    shouYeViewController *_shouYevc;
    ceShiViewController *_ceShivc;
    tanMiViewController *_tanMivc;
    jiQiaoViewController *_jiQiaovc;
    pouXiViewController *_pouXivc;
    
    
    
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"心灵话语";
    
    
    
    UIButton *leftbutton=[Factory createButtonWithTitle:@"" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toGetAnotherView)];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"personalCenter_col_logo"] forState:(UIControlStateNormal)];
    [self createNavigationLeftButton:leftbutton];
    
}


//跳转到setting页面
-(void)toGetAnotherView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:nil];
}




-(void)createView
{
    //防止，滚动视图的影响
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //创建上面的导航滚动器
    [self createSmallScrollView];
    
    //创建分隔条
    [self createLineView];
    
    //创建下部的滚动器
    [self createBigScrollView];
    
    //添加所有的栏目到大滚动图
    [self addViewControllersToBigScrollView];
    
    //添加栏目标题到上面导航滚动器
    [self addLabelsToSmallScrollView];
    
    //添加默认的栏目
    [self setDefaultColumnViewController];
    
    
}


//创建上面的导航滚动器
-(void)createSmallScrollView
{
    _smallScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, Default)];
    _smallScrollView.showsHorizontalScrollIndicator=NO;
    _smallScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_smallScrollView];
    
    
}

 //创建分隔条
-(void)createLineView
{
    _lineView=[Factory createViewWithBackgroundColor:[UIColor grayColor] frame:CGRectMake(0, _smallScrollView.height+64, _smallScrollView.width, 0.5)];
    [self.view addSubview:_lineView];
    
    
}


 //创建下部的滚动器
-(void)createBigScrollView
{
    _bigScrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,64+_smallScrollView.height+_lineView.height, _lineView.width, [UIScreen mainScreen].bounds.size.height-108.5-Default)];
    _bigScrollview.delegate=self;
    _bigScrollview.pagingEnabled=YES;
    [self.view addSubview:_bigScrollview];
    
}

//添加所有的栏目到大滚动图
-(void)addViewControllersToBigScrollView
{
    _shouYevc=[[shouYeViewController alloc] init];
    _shouYevc.title=@"心灵鸡汤";
    [self addChildViewController:_shouYevc];
    
    _ceShivc=[[ceShiViewController alloc] init];
    _ceShivc.title=@"心理测试";
    [self addChildViewController:_ceShivc];
    
    _tanMivc=[[tanMiViewController alloc] init];
    _tanMivc.title=@"心灵探秘";
    [self addChildViewController:_tanMivc];
    
    _jiQiaovc=[[jiQiaoViewController alloc] init];
    _jiQiaovc.title=@"读心技巧";
    [self addChildViewController:_jiQiaovc];
    
    _pouXivc=[[pouXiViewController alloc] init];
    _pouXivc.title=@"行为剖析";
    [self addChildViewController:_pouXivc];
    
    
    _bigScrollview.contentSize=CGSizeMake(self.childViewControllers.count*[UIScreen mainScreen].bounds.size.width, 0);
    
}


//添加栏目标题到上面导航滚动器
-(void)addLabelsToSmallScrollView
{
    for (int i=0; i<5; i++)
    {
        WMJTitleLable *label=[[WMJTitleLable alloc] init];
        label.frame=CGRectMake(i*75, 0, 70, 40);
        label.text=[[self.childViewControllers objectAtIndex:i] title];
        label.tag=i+20;
        label.userInteractionEnabled=YES;
        //给标签添加一个手势，使当点击时会有反应
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDidClicked:)]];
        
        
        _smallScrollView.contentSize=CGSizeMake(75*5, 0);
        [_smallScrollView addSubview:label];
        
    }
    
    
}


//label的点击事件
-(void)labelDidClicked:(UIGestureRecognizer *)gesture
{
    UILabel *label=(UILabel *)gesture.view;
    //NSLog(@"%lf",label.tag*_bigScrollview.width);
    CGFloat offsetX=(label.tag-20)*_bigScrollview.frame.size.width;
    
    CGFloat offsetY=_bigScrollview.contentOffset.y;
    CGPoint offset=CGPointMake(offsetX, offsetY);
    
    
    [_bigScrollview setContentOffset:offset animated:YES];
    
}




//添加默认的栏目
-(void)setDefaultColumnViewController
{
    UIViewController *vc=[self.childViewControllers firstObject];
    vc.view.frame=_bigScrollview.bounds;
    WMJTitleLable *label=[_smallScrollView.subviews firstObject];
    label.scale=1.0;
    [_bigScrollview addSubview:vc.view];
    
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



#pragma mark---UIScrollViewDelegate
//只要滚动就调用，控制导航栏滚动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //取出绝对值  避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    WMJTitleLable *labelLeft = _smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < _smallScrollView.subviews.count) {
        WMJTitleLable *labelRight = _smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }

}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / _bigScrollview.width;
    
    UIViewController *currentVC = [self.childViewControllers objectAtIndex:index];
    
    WMJTitleLable *titleLabel = (WMJTitleLable *)[_smallScrollView.subviews objectAtIndex:index];
    
    CGFloat offSetX = titleLabel.center.x - _smallScrollView.width * 0.5;
    CGFloat offSetMaxX = _smallScrollView.contentSize.width - _smallScrollView.width;
    
    if (offSetX < 0) {
        offSetX = 0;
    } else if (offSetX > offSetMaxX) {
        offSetX = offSetMaxX;
    }
    
    CGPoint offSet = CGPointMake(offSetX, 0);
    [_smallScrollView setContentOffset:offSet animated:YES];
    
    [_smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            WMJTitleLable *tempLabel = [_smallScrollView.subviews objectAtIndex:idx];
            tempLabel.scale = 0.0;
        }
    }];
    
    //    NSLog(@"%ld",index);
    //    NSLog(@"%@",[currentVC class]);
    if (!currentVC.view.subviews) {
        return;
    }
    currentVC.view.frame = scrollView.bounds;
    [_bigScrollview addSubview:currentVC.view];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}











@end
