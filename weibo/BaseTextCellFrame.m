//
//  BaseTextCellFrame.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseTextCellFrame.h"
#import "IconView.h"
#import "User.h"
#import "BaseText.h"

@implementation BaseTextCellFrame

-(void)setBaseText:(BaseText *)baseText
{
    _baseText = baseText;
    
    //整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * kTableBorderWidth;
    
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = [IconView iconSizeWithType:kIconTypeSmall];
    _iconFrame = CGRectMake(iconX, iconY, iconSize.width,iconSize.height);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [baseText.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){screenNameX,screenNameY,screenNameSize};
    
    // 会员图标
    if (baseText.user.mbtype != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) +kCellBorderWidth;
        CGFloat mbIconY = (screenNameSize.height - kMBIconH) * 0.5 +screenNameY;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    // 3.内容
    CGFloat textX = screenNameX;
    CGFloat textY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGFloat textWidth = cellWidth - kCellBorderWidth - textX;
    CGSize textSize = [baseText.text sizeWithFont:kTextFont maxW:textWidth];
    _textFrame = (CGRect){textX,textY,textSize};
    
    // 4.时间
    CGFloat timeX = textX;
    CGFloat timeY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
    CGSize timeSize = CGSizeMake(textWidth, kTimeFont.lineHeight);
    _timeFrame = (CGRect){timeX,timeY,timeSize};
    
    //5.cell的高度
    _cellHeight = CGRectGetMaxY(_timeFrame) +kCellBorderWidth;

}

@end
