//
//  ZooCalculateCollectionViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "ZooCalculateCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@implementation ZooCalculateCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)showDataWithModel:(ZooCalculateModel *)model
{
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:model.Thumbnail]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
    
    self.title.text=model.Title;
    self.author.text=model.Author;
    self.readedcount.text=[NSString stringWithFormat:@"浏览量:%@",model.ReadedCount];
    
  //  NSLog(@"%@",self.author.text);
    
}







@end
