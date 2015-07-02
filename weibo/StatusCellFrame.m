//
//  StatusCellFrame.m
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"

@implementation StatusCellFrame

-(void)setStatus:(Status *)status
{
    _status = status;
    //利用微博数据，计算所有子控件的frame
    
    //整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    _iconFrame = CGRectMake(iconX, iconY, 50, 50);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = kCellBorderWidth;
    CGSize screenNameSize = [status.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){screenNameX,screenNameY,screenNameSize};
    
    // 3.时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    CGSize timeSize = [status.createdat sizeWithFont:kTimeFont];
    _timeFrame = (CGRect){timeX,timeY,timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:kSourceFont];
    _sourceFrame = (CGRect){sourceX,sourceY,sourceSize};
    
    // 5.内容
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconFrame) + kCellBorderWidth;
    CGSize textSize = [status.text sizeWithFont:kTextFont maxW:cellWidth - kCellBorderWidth * 2];
    _textFrame = (CGRect){textX,textY,textSize};
    
    if (status.picUrls.count) {//6.有配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        _imageFrame = CGRectMake(imageX, imageY, 100, 100);
    } else if (status.retweetedStatus){// 7.有转发
        //被转发微博整体
        CGFloat retweetX = textX;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) +kCellBorderWidth;
        CGFloat retweetWidth = cellWidth - 2 * kCellBorderWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        // 8.被转发微博的昵称
        CGFloat retweetScreenNameX = kCellBorderWidth;
        CGFloat retweetScreenNameY = kCellBorderWidth;
        CGSize retweetScreenNameSize = [status.retweetedStatus.user.screenName sizeWithFont:kRetweetedScreenNameFont];
        _RetweetedScreenNameFrame = (CGRect){retweetScreenNameX, retweetScreenNameY, retweetScreenNameSize};
        
        // 9.被转发微博的内容
        CGFloat retweetTextX = retweetScreenNameX;
        CGFloat retweetTextY = CGRectGetMaxY(_RetweetedScreenNameFrame) +kCellBorderWidth;
        CGSize retweetTextSize = [status.retweetedStatus.text sizeWithFont:kRetweetedTextFont maxW:cellWidth - 2 *kCellBorderWidth];
        _RetweetedTextFrame = (CGRect){retweetTextX,retweetTextY,retweetTextSize};
        
        // 10.被转发微博的配图
        if(status.retweetedStatus.picUrls.count){
            CGFloat retweetedImageX =  retweetTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_RetweetedTextFrame) +kCellBorderWidth;
            _RetweetedImageFrame = CGRectMake(retweetedImageX, retweetedImageY, 100, 100);
            
            retweetHeight += CGRectGetMaxY(_RetweetedImageFrame);
        } else {
            retweetHeight += CGRectGetMaxY(_RetweetedTextFrame);
        }
        
        _RetweetedFrame  = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    
    //11.整个cell的高度
    _cellHeight = kCellBorderWidth;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    } else if (status.retweetedStatus){
        _cellHeight += CGRectGetMaxY(_RetweetedFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }   
}

@end
