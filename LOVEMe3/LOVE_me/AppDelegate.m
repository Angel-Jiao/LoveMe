//
//  AppDelegate.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/30.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "AppDelegate.h"
#import "MainSliderViewController.h"
#import "NetRequestManager.h"

//当用友盟第三方时的头文件
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "CoreData+MagicalRecord.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)initUM
{
    //需要在友盟注册一个AppKey在这里要设置一下，否则不能用
    [UMSocialData setAppKey:@"55f81f12e0f55ad899001e79"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxdf6ffb227ff8432b" appSecret:@"70da789d74d517b2faddf2144f861e9c" url:@"http://www.1000phone.com"];
    
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)initCoreData {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"PicketCookData.sqlite"];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initCoreData];
    
    
    //初始化---友盟
    [self initUM];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    
    [NetRequestManager manager];
    
    
    MainSliderViewController *main=[[MainSliderViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController=nav;
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
