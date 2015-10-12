//
//  FatherArrayModel.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "JSONModel.h"
#import "FatherModel.h"

@interface FatherArrayModel : JSONModel

@property (nonatomic,retain) NSMutableArray<FatherModel> *results;


@end
