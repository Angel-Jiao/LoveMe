//
//  ZooCalculateWebViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ZooCalculateWebViewController.h"

//#import "ZooCalculateModel.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "CoreData+MagicalRecord.h"
#import "Common.h"
#import "ZooCalculateModel.h"

@interface ZooCalculateWebViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    NSString *_articleUrl;
    //html视图加载
    UIWebView *_webView;
    //底部导航
    UIToolbar *_toolBar;
    //定义字体的大小
    NSInteger _fontSize;
    
}


@end

@implementation ZooCalculateWebViewController


-(id)initWithArticleURL:(NSString *)ArticleURL
{
    self=[super init];
    if (self)
    {
        _articleUrl=[ArticleURL copy];
    }
    
    return self;
}


-(id)initWithArticleModel:(ZooCalculateModel *)model
{
    self=[super init];
    if (self)
    {
        _model=model;
    }
    
    return self;
}



-(void)createView
{
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-70)];
    _webView.delegate=self;
    _webView.scrollView.bounces=NO;
    
    [self.view addSubview:_webView];
    
    
    //设置一个工具栏toolBar
    _toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, _webView.bottom, self.view.width,self.view.height-_webView.bottom)];
    
    [self.view addSubview:_toolBar];
    
    //调用为工具栏添加按钮，并添加按钮名和按钮功能的方法
    [self addToolBarItem];
    
    
}



//添加功能按键
-(void)addToolBarItem
{
    NSMutableArray *tempAry=[[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < 7; i ++)
    {
        @autoreleasepool
        {
            
            if((i % 2))
            {
                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
                [tempAry addObject:item];
                
                
            }
            else
            {
                //定义最下面的工具栏上的按钮（按钮上有按钮名和按钮功能
                UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[self getItemTitle:i] style:UIBarButtonItemStylePlain target:self action:[self getItemAction:i]];
                [tempAry addObject:item];
                
            }
        }
    }
    
    //为工具栏添加上按钮的名字
    [_toolBar setItems:tempAry animated:YES];
    
    
}

//获取item按钮的title
-(NSString *)getItemTitle:(int)num
{
    switch (num/2)
    {
        case 0:return @"缩小字体";break;
        case 1:return @"后退";break;
        case 2:return @"刷新";break;
        default:return @"加大字体";break;
    }
}


//获取item的行为
-(SEL)getItemAction:(int)num
{
    switch (num/2)
    {
        case 0:return @selector(reduceFont);break;
        case 1:return @selector(webLoadPreView);break;
        case 2:return @selector(webRefresh);break;
        default:return @selector(addFont);break;
    }
}

//点击toolBar上的按钮，则有前进的功能
-(void)reduceFont
{
    
    //设置字体的大小
    _fontSize-=5;
    NSString *str=[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='%ld%%'",(long)_fontSize];
    //为webView添加js语句
    [_webView stringByEvaluatingJavaScriptFromString:str];
    
}
//点击toolBar上的按钮，则有后退的功能
-(void)webLoadPreView
{
    [_webView goBack];
}
//点击toolBar上的按钮，则有刷新的功能
-(void)webRefresh
{
    [_webView reload];
}
//点击toolBar上的按钮，则有字体变大的功能
-(void)addFont
{
    //设置字体的大小
    _fontSize+=5;
    NSString *str=[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='%ld%%'",(long)_fontSize];
    //为webView添加js语句
    [_webView stringByEvaluatingJavaScriptFromString:str];
    
    
}




-(void)initData
{
    //设置文字大小的初始值
    _fontSize=100.f;
    
    //加载request来呈现网站内容（是手机屏幕的页面显示）
  //  NSString *urlString=[NSString stringWithFormat:@"%@id=%@",celldetailUrl,_id];
    
   // ZooCalculateModel *model=[[ZooCalculateModel alloc] init];
    if (_articleUrl.length)
    {
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_articleUrl]];
        
          [_webView loadRequest:request];
        
    }
    
    else
    {
         NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_model.ArticleURL]];
    
         [_webView loadRequest:request];
    
    }
   // NSLog(@"%@",model.ArticleURL);
   
  
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavigationItem];
}





-(void)createNavigationItem
{
    // NSArray *titles=@[@"收藏",@"分享"];
    NSArray *noSelectimageName=@[@"icon_star@2x",@"icon_share@2x"];
    NSArray *selectImageName=@[@"icon_star_full@2x",@"icon_share_chickenmedes@2x"];
    NSMutableArray *buttonArr=[[NSMutableArray alloc] init];
    for (NSInteger i=0; i<selectImageName.count; i++)
    {
        //  NSString *imageName=[NSString stringWithFormat:@"详情-%@",titles[i]];
        UIButton *button=[Factory createButtonWithTitle:@"" frame:CGRectMake(0, 0, 44, 44) target:self selector:@selector(btnClick:)];
        [button setImage:[UIImage imageNamed:noSelectimageName[i]] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:selectImageName[i]] forState:(UIControlStateSelected)];
        
        //修改内容字体下移，控制内容的上下左右移动，top正值，向下移动
        button.titleEdgeInsets=UIEdgeInsetsMake(5, 0, 0, 0);
        button.tag=100+i;
        [buttonArr addObject:button];
        
    }
    
    //右侧按钮
    [self addItemsWithCustomViews:buttonArr isLeft:NO];
    
}


#pragma mark---分享&收藏按钮的实现
-(void)btnClick:(UIButton *)button
{
    button.selected=!button.selected;
    switch (button.tag)
    {
        case 100://收藏
        {
             [self myFavorite];
            
        }
            break;
        case 101://分享
        {
            
            [self UMShared];
        }
            break;
        default:
            break;
    }
}



#pragma mark---收藏
-(void)myFavorite
{
    NSArray *arr=[Common MR_findByAttribute:@"title" withValue:self.model.Title];
    if (arr.count)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"亲，您已经收藏过了哦" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    Common *commonModel=[Common MR_createEntity];
   // NSLog(@"%@",self.model.Thumbnail);
    commonModel.image=self.model.Thumbnail;
    commonModel.title=self.model.Title;
    //  zooModel.readedCount=self.model.ReadedCount;
    commonModel.articleurl=self.model.ArticleURL;
    
    //同步保存到本地数据库
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
  
    
    
    
}











#pragma mark---分享
-(void)UMShared
{
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55f81f12e0f55ad899001e79"
                                      shareText:_model.ArticleURL
                                     shareImage:[UIImage imageNamed: @"icon80x80"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms,UMShareToWechatFavorite,UMShareToWechatSession,nil]
                                       delegate:self];
    
    [UMSocialWechatHandler setWXAppId:@"wxdf6ffb227ff8432b" appSecret:@"70da789d74d517b2faddf2144f861e9c" url:_articleUrl];
    
}


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    
}




-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //屏蔽广告代码
    if ([request.URL.absoluteString hasPrefix:@"http://iapi.ipadown.com/api"]||[request.URL.absoluteString hasPrefix:@"http://www.wezeit.com/wap"]||[request.URL.absoluteString hasPrefix:@"http://mp.weixin.qq.com"])
    {
        return YES;
    }
    
    NSLog(@"将要开始加载request");
    return NO;
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
