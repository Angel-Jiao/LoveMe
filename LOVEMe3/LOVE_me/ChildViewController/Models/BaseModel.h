//
//  BaseModel.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//防止用KVC时导致代码崩
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;



@end
