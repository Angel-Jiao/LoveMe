//
//  ArtTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/12.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ArtTableViewCell.h"

#import "UIImageView+WebCache.h"

@implementation ArtTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showDataWithModel:(ZooCalculateModel *)model
{
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:model.Thumbnail]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
    
    self.title.text=model.Title;
   // NSLog(@"%@",self.title.text);
    
    //将数字类型转换为文本类型
    self.readedcount.text=[NSString stringWithFormat:@"浏览量:%@",model.ReadedCount];
    
    
    
}






@end
