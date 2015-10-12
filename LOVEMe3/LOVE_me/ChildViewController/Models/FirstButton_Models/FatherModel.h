//
//  FatherModel.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/1.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "JSONModel.h"

@protocol FatherModel <NSObject>

@end


@interface FatherModel : JSONModel

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *catename;
@property (nonatomic,copy) NSString *subcatename;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *views;
@property (nonatomic,copy) NSString *tags;
@property (nonatomic,copy) NSString *edittime;




@end
