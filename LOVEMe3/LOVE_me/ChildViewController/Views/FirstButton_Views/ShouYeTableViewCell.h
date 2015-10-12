//
//  ShouYeTableViewCell.h
//  LOVE_me
//
//  Created by qianfeng on 15/9/2.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouYeModel.h"

@interface ShouYeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *thumb;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *tags;

@property (weak, nonatomic) IBOutlet UILabel *subcatename;

@property (weak, nonatomic) IBOutlet UILabel *edittime;



-(void)showDataWithModel:(ShouYeModel *)model;




@end
