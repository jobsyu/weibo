//
//  BaseTextCell.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseTextCell.h"
#import "BaseText.h"
#import "BaseTextCellFrame.h"
#import "User.h"
#import "IconView.h"

@implementation BaseTextCell

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    //获得文件名
    int count = [_myTableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = @"statusdetail_comment_background_middle.png";
    NSString *seletcedBgName = @"statusdetail_comment_background_middle_highlighted.png";
    if (count - 1 == indexPath.row) { // 末行
        bgName = @"statusdetail_comment_background_bottom.png";
        seletcedBgName = @"statusdetail_comment_background_bottom_highlighted.png";
    }
    
    // 2.设置背景图片
    _bg.image = [UIImage resizedImage:bgName];
    _selectedBg.image = [UIImage resizedImage:seletcedBgName];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = kTableBorderWidth;
    frame.size.width -=kTableBorderWidth;
    
    [super setFrame:frame];
}

-(void)setCellFrame:(BaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    BaseText *baseText = cellFrame.baseText;
    
    //1. 头像
    _icon.frame = cellFrame.iconFrame;
    _icon.user = baseText.user;
    
    //2 .昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = baseText.user.screenName;
    
    //会员图标
    if (baseText.user.mbtype == kMBTypeNone) {
        _mbIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    } else {
        _mbIcon.hidden = NO;
        _mbIcon.frame =cellFrame.mbIconFrame;
        _screenName.textColor = kMBScreenNameColor;
    }
    
    //3. 内容
    _text.frame = cellFrame.textFrame;
    _text.text =baseText.text;
    
    //4. 时间
    _time.frame = cellFrame.timeFrame;
    _time.text = baseText.createdAt;
//    CGFloat _timeX = cellFrame.screenNameFrame.origin.x;
//    CGFloat _timeY = CGRectGetMaxY(cellFrame.screenNameFrame) + kCellBorderWidth;
//    CGSize _timeSize = [_time.text sizeWithFont:kTimeFont];
    //_time.frame = (CGRect){_timeX,_timeY,_timeSize};
   
}

@end
