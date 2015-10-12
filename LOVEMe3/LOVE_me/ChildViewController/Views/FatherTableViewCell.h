//
//  FatherTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherModel.h"
//#import "FatherArrayModel.h"
@interface FatherTableViewCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UIImageView *thumb;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *tags;


-(void)showDataWithModel:(FatherModel *)model;

@end
