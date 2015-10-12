//
//  Common.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Common : NSManagedObject

@property (nonatomic, retain) NSString * id1;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * tags1;
@property (nonatomic, retain) NSString * articleurl;
@property (nonatomic, retain) NSString * image;

@end
