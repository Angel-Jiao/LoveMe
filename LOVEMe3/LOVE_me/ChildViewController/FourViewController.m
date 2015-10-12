//
//  FourViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "FourViewController.h"
#import "SDImageCache.h"//用于清除缓存的

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "MyFavoriteViewController.h"
#import "MyBiJiViewController.h"

//定义雪花的宽高
#define SNOW_W   35
#define SNOW_H   35
//获取屏幕大小
#define kScreenSize [UIScreen mainScreen].bounds.size

@interface FourViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_data;
   // UIImageView *_imageView;
    NSMutableArray *_imageData;//存放图片 的数组
    
}

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title=@"个人中心";
    
    
    UIButton *leftbutton=[Factory createButtonWithTitle:@"" frame:CGRectMake(0, 5, 40, 30) target:self selector:@selector(toGetAnotherView)];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"personalCenter_col_logo"] forState:(UIControlStateNormal)];
    [self createNavigationLeftButton:leftbutton];

   
    //增加个定时器，添加雪花
    // self.view.backgroundColor = [UIColor lightGrayColor];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    
    
}

//雪花的代码
- (void)updateTimer:(NSTimer*)timer
{
    NSInteger w = kScreenSize.width;
    //计算开始和结束时，x轴的坐标
    CGFloat startXPos = arc4random()%w;
    CGFloat endXPos   = arc4random()%w;
    
    //让雪花模拟从屏幕外飘入，我们把y的坐标设置为-SNOW_H
    UIImageView *snowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(startXPos, -SNOW_H, SNOW_W, SNOW_H)];
    snowImageView.image = [UIImage imageNamed:@"flake"];
    [self.view addSubview:snowImageView];
    
    [UIView animateWithDuration:5 animations:^{
        //这里写动画的最终的状态，也就是雪花的最终位置
        CGRect endFrame = CGRectMake(endXPos, 667-SNOW_H, SNOW_W, SNOW_H);
        snowImageView.frame = endFrame;
        snowImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        //第一个动画完成之后继续
        //模拟雪花被融化掉的动画
        [UIView animateWithDuration:1 animations:^{
            snowImageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            //这里正对alpha的动画已经结束，这是可以把视图从父视图上删除
            [snowImageView removeFromSuperview];
        }];
    }];
}







//跳转到setting页面
-(void)toGetAnotherView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:self];
}



-(void)initData
{
    
   // _data=[[NSMutableArray alloc] initWithObjects:@"我的收藏",@"清除缓存",@"分享好友",@"二维码", nil];
    //_data=[[NSMutableArray alloc] initWithObjects:@"我的收藏",@"清除缓存",@"分享",@"给我鼓励",nil];
    _data=[[NSMutableArray alloc] init];
    _imageData=[[NSMutableArray alloc] init];
    
    NSArray *arr1=@[@"我的收藏",@"清除缓存",@"分享"];
    NSArray *imageArr1=@[@"personalCenter_col_logo",@"plaza_examination",@"personalCenter_task_logo"];
    [_data addObject:arr1];
    [_imageData addObject:imageArr1];
//    
    NSArray *arr2=@[@"给我鼓励"];
    NSArray *imageArr2=@[@"personalCenter_group"];
    [_data addObject:arr2];
    [_imageData addObject:imageArr2];
//    
//    NSArray *arr3=@[@"分享"];
//    [_data addObject:arr3];
//    
//    NSArray *arr4=@[@"给我评分"];
//    [_data addObject:arr4];
//    
//    NSArray *arr5=@[@"扫一扫"];
//    [_data addObject:arr5];
//    
//    NSArray *arr6=@[@""];
//    [_data addObject:arr6];
    
   
    [_tableView reloadData];
    
    
}

-(void)createView
{
    //_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.width, self.view.height-64-49) style:(UITableViewStyleGrouped)];
     _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 350) style:(UITableViewStyleGrouped)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
    //为表格添加背景颜色
    //设置背景色
    _tableView.backgroundColor=[UIColor clearColor];
    //分割线的颜色
    //_tableView.separatorColor=[UIColor yellowColor];
    //分割线的风格
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //允许单项选择，默认是单项
    _tableView.allowsMultipleSelection=NO;
    //为其添加背景图片
    UIImageView *image=[[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image=[UIImage imageNamed:@"shengdan3"];
    image.userInteractionEnabled=YES;
    [self.view addSubview:image];
    [image addSubview:_tableView];
    
    
    
    //给图片上添加一张小图片
//    UIImageView *smallImage=[[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 60, 80)];
//    smallImage.image=[UIImage imageNamed:@"YuanTuYiNdAOyE5.5"];
//    image.userInteractionEnabled=YES;
//    [image addSubview:smallImage];
    
    
    
    
}


#pragma mark---UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
    //return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_data objectAtIndex:section] count];
    //return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifer];
        
    }
    //让每个cell右侧都添加一个右箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text=[[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[[_imageData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
   // cell.textLabel.text=[_data objectAtIndex:indexPath.row];
    //设置字体的大小
    cell.textLabel.font=[UIFont fontWithName:@"Khmer" size:16];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
    
    
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消每行的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
        {
            
           
           
            if (indexPath.row==0)//我的收藏
            {
                 MyFavoriteViewController *favorite=[[MyFavoriteViewController alloc] init];
                 [self.navigationController pushViewController:favorite animated:YES];
            }
            else if (indexPath.row==1)//清除缓存
            {
                //第1组
                //清除缓存  1.自己做的缓存界面  2.SDWebImage的缓存（自带清除功能）
                UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"清除缓存:%.6fM",[self getCachesSize]] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
                [actionSheet showInView:self.view];
                
            }
            else//分享
            {
                 [self UMShared];
            }
            
        }
            break;
        case 1://给我鼓励
        {
            NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1041424277"];
            // NSString *str = [NSString stringWithFormat:@"https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/1041424277"];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                //调用另外app
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }

        }
            break;
  
        default:
            break;
    }
    
    }




#pragma mark---分享的方法

-(void)UMShared
{
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55f81f12e0f55ad899001e79"
                                      shareText:@"这个文章很棒哦"
                                     shareImage:[UIImage imageNamed: @"icon80x80"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,nil]
                                       delegate:self];
    
    //[UMSocialWechatHandler setWXAppId:@"wxdf6ffb227ff8432b" appSecret:@"70da789d74d517b2faddf2144f861e9c" url:[NSString stringWithFormat:@"%@id=%@",celldetailUrl,_shouYeModel.ID]];
    
}




//实现回调方法（可选）
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    
}




//获取所有缓存的大小
-(double)getCachesSize
{
    //1.自定义的缓存  2.sd的缓存
    NSUInteger sdFileSize=[[SDImageCache sharedImageCache] getSize];
    
    //先获取系统的Library/Caches路径
    NSString *caches=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *myCachesPath=[caches stringByAppendingPathComponent:@"MyCaches"];
    //遍历 自定义缓存文件夹
    //目录枚举器，里面存放着文件夹中的所有文件名
    NSDirectoryEnumerator *enumrator=[[NSFileManager defaultManager] enumeratorAtPath:myCachesPath];
    
    NSUInteger mySize=0;
    
    //遍历枚举器
    for (NSString *fileName in enumrator)
    {
        NSString *filePath=[myCachesPath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict=[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        //获取大小
        mySize+=fileDict.fileSize;//字节大小
        
    }
    
    //1M=1024KB=1024*1024bytes
    return (mySize+sdFileSize)/1024.0/1024.0;
    
}



//点击操作表单的按钮
#pragma mark---UIAlertViewDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==actionSheet.destructiveButtonIndex)
    {
        //删除
        //1.删除sd,清除内存的缓存
        [[SDImageCache sharedImageCache] clearMemory];
        //2.再清除磁盘的缓存
        [[SDImageCache sharedImageCache] clearDisk];
        //3.清除自己的缓存
        NSString *caches=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *myCachesPath=[caches stringByAppendingPathComponent:@"MyCaches"];
        
        //删除
        [[NSFileManager defaultManager] removeItemAtPath:myCachesPath error:nil];
        
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end







