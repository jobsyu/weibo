//
//  DetailHeader.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DetailHeader.h"
#import "Status.h"

@interface DetailHeader()
{
    UIButton *_selectedBtn;
}
@end

@implementation DetailHeader

-(void)awakeFromNib
{
    [self btnClick:_comment];
}

+ (id)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailHeader" owner:nil options:nil][0];
}

-(IBAction)btnClick:(UIButton *)sender
{
    //控制器状态转换
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    //移动
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _hint.center;
        center.x = sender.center.x;
        _hint.center =center;
    }];
}

-(void)setStatus:(Status *)status
{
    _status = status;
    
    [self setBtn:_comment title:@"评论" count:status.commentsCount];
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count > 10000) {//大于一万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万 %@",final,title];
        //替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {//一万一下
        [btn setTitle:[NSString stringWithFormat:@"%d %@",count,title] forState:UIControlStateNormal];
    }
    
}
@end
