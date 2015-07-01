//
//  DockItem.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DockItem.h"

#define kDockItemSelectedBG @"tabbar_slider.png"

#define kDockItemScale 0.3

@implementation DockItem

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //2.文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //3.图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //4.设置选中背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{

}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    [self setImage:[UIImage imageNamed:kDockItemSelectedBG] forState:UIControlStateSelected];
     return  CGRectMake(0, 0, self.width, self.height *(1- kDockItemScale));
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat height = self.height * 0.3;
    CGRect labelRect = CGRectMake(0, self.height - height-3 ,self.width ,height);
    return labelRect;
}
@end
