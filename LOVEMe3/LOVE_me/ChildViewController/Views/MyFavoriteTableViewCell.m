//
//  MyFavoriteTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/16.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "MyFavoriteTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation MyFavoriteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showDataWithModel:(Common *)model
{
    [_image sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
    
    _titleLabel.text=model.title;
    
}








@end
