//
//  ZooCalculateWebViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"
#import "ZooCalculateModel.h"

@interface ZooCalculateWebViewController : BaseViewController


@property (nonatomic,strong) ZooCalculateModel *model;

//将父页面的model.id传过来
-(id)initWithArticleModel:(ZooCalculateModel *)model;

//将父页面的model.ID传过来
-(id)initWithArticleURL:(NSString *)ArticleURL;

@end
