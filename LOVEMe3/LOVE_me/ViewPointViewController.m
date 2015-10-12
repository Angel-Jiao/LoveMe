//
//  ViewPointViewController.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ViewPointViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
@interface ViewPointViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation ViewPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    [self initBackgroudImage];
    [self showInit];
}


-(void)showInit
{
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(110, 0,self.view.bounds.size.width-150 ,500 )];
    lable.text=@"     你好，欢迎你使用此应用！这款App目的是传递正能量，令大家在忙忙碌碌的生活中感受到快乐，为自己的生活增添色彩。人生是一种承受，需要学会支撑。支撑事业，支撑家庭，甚至支撑起整个社会，有支撑就一定会有承受，支撑起多少重量，就要承受多大压力。生活本身就是一种承受。也许此应用还存在许多值得去完善的地方，您若有什么意见，请点击上面的小图标哦。";
    lable.numberOfLines=0;
    [self.view addSubview:lable];
    
    
    UIButton *Addbutton=[Factory createButtonWithTitle:@"plugin_icon_message@2x" frame:CGRectMake(self.view.width-70, 20, 60, 50) target:self selector:@selector(btnClick:)];
    [Addbutton setImage:[UIImage imageNamed:@"plugin_icon_message@2x"] forState:(UIControlStateNormal)];
    // [Addbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:Addbutton];
    
   // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   // button.frame = CGRectMake(0, self.view.bounds.size.height/2-50, 80 ,80);
   // [button setImage:[UIImage imageNamed:@"plugin_icon_message@2x"] forState:UIControlStateNormal];
   // [button setImage:[UIImage imageNamed:@"tab_5_xunbao_pressed@2x"] forState:UIControlStateHighlighted];
   // button.backgroundColor=[UIColor redColor];
   // [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:button];
    
}
-(void)initBackgroudImage
{
    UIImageView *baImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    baImageView.image = [UIImage imageNamed:@"lanse"];
    [self.view addSubview:baImageView];
}
-(void)btnClick:(UIButton *)button
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"分享" message:@"这个文章真好" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"短信" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sharedForMessage];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self sharedForMail];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }]];
    //模态跳转
    [self presentViewController:actionSheet animated:YES completion:nil];

}


#pragma mark - 邮件
- (void)sharedForMail {
    //当前设备中是否支持 邮件功能
    if ([MFMailComposeViewController canSendMail]) {
        //检测 是否可以 发送邮件
        //如果支持那么 跳转到 一个 带邮件功能的界面
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        //设置 相关信息
        //设置 联系人
        [mail setToRecipients:@[@""]];
        //抄送
        [mail setCcRecipients:@[@""]];
        //设置标题
        [mail setSubject:@"很好的App哦"];
        //邮件内容
        [mail setMessageBody:@"这个App的文章真的很好哦，大爱!" isHTML:YES];
        //附件 转化为 NSData
        //把png 格式的图片 转化为 NSData
       // NSData *data = UIImagePNGRepresentation([UIImage imageNamed: @"20130104164115995.png"]);
        //第二个参数 是 文件的类型 第三个是 文件名字
       // [mail addAttachmentData:data mimeType:@"image/png" fileName:@"20130104164115995.png"];
        //获取 发送的状态 必须要设置代理
        mail.mailComposeDelegate = self;
        
        //模态跳转
        [self presentViewController:mail animated:YES completion:nil];
    }else {
        NSLog(@"不支持发邮件");
    }
    
}
//发邮件 回调
/*
 MFMailComposeResultCancelled,
 MFMailComposeResultSaved,
 MFMailComposeResultSent,
 MFMailComposeResultFailed
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"被取消");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"保存");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"发送");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"失败");
            break;
            
        default:
            break;
    }
    //跳转返回
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 短信
- (void)sharedForMessage {
    //当前设备中是否支持 短信
    if ([MFMessageComposeViewController canSendText]) {
        //检测 是否可以 发送短息
        //如果支持那么 跳转到 一个 带短信模块的视图控制器中
        MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc] init];
        //设置联系人 支持群发
        message.recipients = @[@"10086",@"10011"];
        //设置短信的内容---这里你可以传值的
        // message.body = [NSString stringWithFormat:@"饿了嘛?这里有美味的饭菜:%@",self.cookModel.imagePathPortrait];
        message.body = [NSString stringWithFormat:@"这个App很好哦，文章也很好，大爱！"];
        //添加附件
        //message addAttachmentData:<#(NSData *)#> typeIdentifier:<#(NSString *)#> filename:<#(NSString *)#>
        //如果要获取发送状态 那么要设置代理
        message.messageComposeDelegate = self;
        //要模态跳转
        [self presentViewController:message animated:YES completion:nil];
    }else {
        NSLog(@"不支持短信");
    }
}
/*
 MessageComposeResultCancelled,
 MessageComposeResultSent,
 MessageComposeResultFailed
 */
//发送短信之后回调这个方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultCancelled:
        {
            NSLog(@"短信被取消");
        }
            break;
        case MessageComposeResultSent:
        {
            NSLog(@"短信 已 发送");
        }
            break;
        case MessageComposeResultFailed:
        {
            NSLog(@"短信失败");
        }
            break;
        default:
            break;
    }
    //最后模态跳转返回
    [controller dismissViewControllerAnimated:YES completion:nil];
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
