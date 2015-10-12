//
//  WMJTitleLable.m
//  LOVE_me
//
//  Created by qianfeng on 15/8/31.
//  Copyright (c) 2015年 王梦娇. All rights reserved.
//

#import "WMJTitleLable.h"

@implementation WMJTitleLable

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:14];
        
        self.scale = 0.0;
        
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    
    CGFloat minScale = 0.9;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    if(scale==minScale||scale==trueScale)
    {
        self.textColor = RGB(280, 146, 200);
    }
    else
    {
        self.textColor = [UIColor blackColor];
    }
    
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}



@end
