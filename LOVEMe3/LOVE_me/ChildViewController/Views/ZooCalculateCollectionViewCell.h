//
//  ZooCalculateCollectionViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZooCalculateModel.h"


@interface ZooCalculateCollectionViewCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@property (weak, nonatomic) IBOutlet UILabel *title;


@property (weak, nonatomic) IBOutlet UILabel *readedcount;

@property (weak, nonatomic) IBOutlet UILabel *author;

//cell分类 属于哪个界面的
@property (nonatomic,copy) NSString *category;

//填充数据到cell上
-(void)showDataWithModel:(ZooCalculateModel *)model;








@end
