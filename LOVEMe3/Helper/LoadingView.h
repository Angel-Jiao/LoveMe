//
//  LoadingView.h
//  Limit爱限免
//
//  Created by qianfeng on 15/8/27.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    //菊花
    UIActivityIndicatorView *_activity;
    
    //黑色的背景
    UIView *_backView;
    //提示语
    UILabel *_alertLabel;
    
}


//初始化
+(LoadingView *)shareSingleton;

//召唤loading页
+(void)showLoadingView:(UIView *)superView;


+(void)hideLoadingView;

@end
