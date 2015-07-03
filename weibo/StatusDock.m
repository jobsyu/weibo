//
//  StatusDock.m
//  weibo
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusDock.h"

@implementation StatusDock

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 0.设置整个dock的背景
        self.image = [UIImage resizedImage:@"timeline_card_bottom.png"];
        
        // 1.添加3个按钮
        [self addBtn:@"转发" icon:@"timeline_icon_retweet.png" bg:@"timeline_card_leftbottom.png" index:0];
        [self addBtn:@"评论" icon:@"timeline_icon_comment.png" bg:@"timeline_card_middlebottom.png" index:1];
        [self addBtn:@"赞" icon:@"timeline_icon_unlike.png" bg:@"timeline_card_rightbottom.png" index:2];
        
    }
    return self;
}

-(void)addBtn:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index
{
    //设置标题
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    //设置图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //设置普通背景
    [btn setBackgroundImage:[UIImage imageNamed:bg] forState:UIControlStateNormal];
    //设置高亮背景
    [btn setBackgroundImage:[UIImage imageNamed:[bg fileAppend:@"highlighted"]] forState:UIControlStateHighlighted];
    //文字颜色
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    //字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //设置frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, kStatusDockHeight);
    //文字左边会空出10的间距
    btn.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    
    if (index) { //index不等于0，添加分隔线
        UIImage *img =[UIImage imageNamed:@"timeline_card_bottom_line"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:img];
        divider.center =  CGPointMake(btn.frame.origin.x, kStatusDockHeight * 0.5);
        [self addSubview:divider];
    }
}

#pragma mark 在内部固定自己的宽高
-(void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    frame.size.height = kStatusDockHeight;
    
    [super setFrame:frame];
}

@end
