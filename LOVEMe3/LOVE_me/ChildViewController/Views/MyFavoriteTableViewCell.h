//
//  MyFavoriteTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface MyFavoriteTableViewCell : UITableViewCell






@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



-(void)showDataWithModel:(Common *)model;


@end
