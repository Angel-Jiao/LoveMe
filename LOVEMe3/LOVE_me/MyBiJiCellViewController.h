//
//  MyBiJiCellViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/5.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"

@class MyBiJiCellViewController;

@protocol DetailViewControllerDelegate <NSObject>

-(void)DetailViewControllerDelegateSave:(MyBiJiCellViewController *)alterVC;


@end

@interface MyBiJiCellViewController : BaseViewController


@property (nonatomic,copy) NSString *contentText;

@property (nonatomic,assign) id<DetailViewControllerDelegate>delegate;




@end
