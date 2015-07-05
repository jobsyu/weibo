//
//  RetweetedDock.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "RetweetedDock.h"
#import "Status.h"

@interface RetweetedDock()
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitude;
}
@end

@implementation RetweetedDock
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加3个按钮
        _repost = [self addBtn:@"转发" icon:@"timeline_icon_retweet.png" bg:@"timeline_card_leftbottom.png" index:0];
        _comment = [self addBtn:@"评论" icon:@"timeline_icon_comment.png" bg:@"timeline_card_middlebottom.png" index:1];
        _attitude =[self addBtn:@"赞" icon:@"timeline_icon_unlike.png" bg:@"timeline_card_rightbottom.png" index:2];
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = 200;
    frame.size.height = kRetweetedDockHeight;
    
    [super setFrame:frame];
}

-(UIButton *)addBtn:(NSString *)title icon:(NSString *)icon bg:(NSString *)bg index:(int)index
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
    
    return btn;
}


#pragma mark 给操作条赋值
-(void)setStatus:(Status *)status
{
    _status = status;
    
    //1.转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    //2.评论
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    //3.赞
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
}

#pragma mark 设置按钮文字
-(void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) {//上万
        CGFloat final = count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万",final];
        
        //替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else if (count > 0){//小于一万
        NSString *title = [NSString stringWithFormat:@"%d",count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { //没有
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
