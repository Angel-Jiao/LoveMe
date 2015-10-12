//
//  FatherTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "FatherTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "LZXHelper.h"


@implementation FatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)showDataWithModel:(FatherModel *)model
{
    
    
    //动态计算宽度
    CGRect thumbFrame=self.thumb.frame;
    
    if (model.thumb.length) {
        
        thumbFrame.size.width=70;
        
        [_thumb sd_setImageWithURL:[NSURL URLWithString:model.thumb]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
        _thumb.layer.cornerRadius=12.f;
        _thumb.layer.masksToBounds=YES;
    }
    else
    {
        thumbFrame.size.width=0;
        
    }
    
    _thumb.frame=thumbFrame;
    
    
    CGRect titleFrame=self.title.frame;
    titleFrame.origin.x=CGRectGetMaxX(thumbFrame)+10;
    _title.frame=titleFrame;
    _title.text=model.title;
    
    
    CGRect tagsFrame=self.tags.frame;
    tagsFrame.origin.x=CGRectGetMaxX(thumbFrame)+10;
    _tags.frame=tagsFrame;
    _tags.text=model.tags;
    
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
