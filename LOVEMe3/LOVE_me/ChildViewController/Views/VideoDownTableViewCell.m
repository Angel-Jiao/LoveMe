//
//  VideoDownTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/14.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "VideoDownTableViewCell.h"

#import "UIImageView+WebCache.h"


@implementation VideoDownTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)showDataWithModel:(VideoModel *)model jumpBlock:(JumpBlock1)myBlock
{
    self.myBlock=myBlock;
    self.videomodel=model;
    
    
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
    _cover.layer.masksToBounds=YES;
    _cover.layer.cornerRadius=12.f;
    _cover.layer.borderColor=[UIColor blackColor].CGColor;
    _cover.layer.borderWidth=0.8f;
    _title.text=model.title;
    
    
    double t = [model.ptime doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:t];
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    _ptime.text=[NSString stringWithFormat:@"%@",[df stringFromDate:date]];
    
    
    
    _playCount.text=[NSString stringWithFormat:@"%@",model.playCount];
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)playClick:(id)sender {
    
    if (self.myBlock) {
        
        self.myBlock(self.videomodel.mp4_url);
        NSLog(@"%@",self.videomodel.mp4_url);
    }
   
    
    
}






















@end
