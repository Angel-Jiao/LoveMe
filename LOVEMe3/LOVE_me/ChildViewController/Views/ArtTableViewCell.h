//
//  ArtTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZooCalculateModel.h"

@interface ArtTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;


@property (weak, nonatomic) IBOutlet UILabel *readedcount;

//填充数据到cell上
-(void)showDataWithModel:(ZooCalculateModel *)model;

@end
