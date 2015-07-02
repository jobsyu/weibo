//
//  StatusCellFrame.h
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//
#define kCellBorderWidth 10

#define kScreenNameFont [UIFont systemFontOfSize:17]
#define kTimeFont  [UIFont systemFontOfSize:13]
#define kSourceFont kTimeFont
#define kTextFont  [UIFont systemFontOfSize:15]

#define kRetweetedTextFont [UIFont systemFontOfSize:16]
#define kRetweetedScreenNameFont [UIFont systemFontOfSize:16]

#import <Foundation/Foundation.h>
@class Status;
@interface StatusCellFrame : NSObject

@property (nonatomic,strong) Status *status;

@property (nonatomic,readonly) CGFloat cellHeight; //cell的高度

@property (nonatomic,readonly) CGRect iconFrame; //头像的frame

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
