//
//  BaseStatusCell.h
//  weibo
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseWordCell.h"

@class BaseStatusCellFrame;
@interface BaseStatusCell : BaseWordCell
{
    UIImageView *_retweeted;//被转发微博的父控件
}
@property (nonatomic,strong) BaseStatusCellFrame *cellFrame;
@end
