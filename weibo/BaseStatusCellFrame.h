//
//  BaseStatusCellFrame.h
//  weibo
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;
@interface BaseStatusCellFrame : NSObject
{
    CGFloat _cellHeight;
    CGRect _RetweetedFrame;
}

@property (nonatomic,strong) Status *status;

@property (nonatomic,readonly) CGFloat cellHeight; //cell的高度

@property (nonatomic,readonly) CGRect iconFrame; //头像的frame
@property (nonatomic,readonly) CGRect mbIconFrame; // 皇冠图标（会员图标）

@property (nonatomic,readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic,readonly) CGRect timeFrame;  // 时间
@property (nonatomic,readonly) CGRect sourceFrame; // 来源
@property (nonatomic,readonly) CGRect textFrame; // 内容
@property (nonatomic,readonly) CGRect imageFrame; // 配图

@property (nonatomic,readonly) CGRect RetweetedFrame; // 被转发微博的父控件
@property (nonatomic,readonly) CGRect RetweetedScreenNameFrame; // 被转发微博作者的昵称
@property (nonatomic,readonly) CGRect RetweetedTextFrame; // 被转发微博的内容
@property (nonatomic,readonly) CGRect RetweetedImageFrame; // 被转发微博的配图
@end
