//
//  BaseTextCellFrame.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseText;
@interface BaseTextCellFrame : NSObject

@property (nonatomic,strong) BaseText *baseText;

@property (nonatomic,readonly) CGFloat cellHeight; //cell的高度

@property (nonatomic,readonly) CGRect iconFrame; //头像的frame
@property (nonatomic,readonly) CGRect mbIconFrame; // 皇冠图标（会员图标）
@property (nonatomic,readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic,readonly) CGRect timeFrame;  // 时间
@property (nonatomic,readonly) CGRect textFrame; // 内容
@end
