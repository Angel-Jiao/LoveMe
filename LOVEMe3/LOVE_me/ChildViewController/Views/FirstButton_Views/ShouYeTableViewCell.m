//
//  ShouYeTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/2.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ShouYeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LZXHelper.h"

@implementation ShouYeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



//-(void)showDataWithModel:(ShouYeModel *)model
//{
//    _title.text=model.title;
//    [_thumb sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
//    _thumb.layer.cornerRadius=12.f;
//    _thumb.layer.masksToBounds=YES;
//    _tags.text=model.tags;
//    _subcatename.text=[NSString stringWithFormat:@"分类: %@",model.subcatename];
//    _edittime.text=[LZXHelper dateStringFromNumberTimer:model.edittime];
//    
//    
//}
//



-(void)showDataWithModel:(ShouYeModel *)model
{
    
    
    CGRect thumbFrame=self.thumb.frame;
    
    if (model.thumb.length) {
        
        thumbFrame.size.width=60;
        
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
    
    CGRect subcatenameFrame=self.subcatename.frame;
    subcatenameFrame.origin.x=CGRectGetMaxX(thumbFrame)+10;
    _subcatename.frame=subcatenameFrame;
    _subcatename.text=model.subcatename;
    
    _edittime.text=[LZXHelper dateStringFromNumberTimer:model.edittime];
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
