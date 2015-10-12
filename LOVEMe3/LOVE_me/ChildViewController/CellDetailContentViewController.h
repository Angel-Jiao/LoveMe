//
//  CellDetailContentViewController.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "BaseViewController.h"
#import "FatherModel.h"
#import "ShouYeModel.h"

#import "ZooCalculateModel.h"

@interface CellDetailContentViewController : BaseViewController


@property (nonatomic,strong) FatherModel *fatherModel;
@property (nonatomic,strong) ShouYeModel *shouYeModel;

//将父页面的model.ID传过来
//-(id)initWithID:(NSString *)ID;

-(id)initWithFatherModel:(FatherModel *)model;
-(id)initWithShouYeModel:(ShouYeModel *)model;


@end
