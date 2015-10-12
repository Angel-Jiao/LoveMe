//
//  VideoTopTableViewCell.m
//  LOVE_me
//
//  Created by qianfeng on 15/9/14.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "VideoTopTableViewCell.h"

#import "UIImageView+WebCache.h"


@implementation VideoTopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)showDataWithModel:(VideoModel *)model
{
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"53.jpg"]];
    
    _title.text=model.title;
    
    
    //时间的处理
    //转化为Double
//    double t = [timerStr doubleValue];
//    //计算出距离1970的NSDate
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
//    //转化为 时间格式化字符串
//    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
//    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    //转化为 时间字符串
//    return [df stringFromDate:date];
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






@end
