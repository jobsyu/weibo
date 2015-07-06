//
//  BaseWordCell.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseWordCell.h"
#import "IconView.h"

@implementation BaseWordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMySubViews];
    }
    return self;
}


-(void)addMySubViews
{
    //头像
    _icon = [[IconView alloc] init];
    _icon.type = kIconTypeSmall;
    [self.contentView addSubview:_icon];
    
    //昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;  //17号字体
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    //会员图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    //时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;  //13号字体
    _time.textColor = kColor(246, 165, 68);
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    //内容
    _text = [[UILabel alloc] init];
    _text.font = kTextFont; //15号字体
    _text.numberOfLines = 0; //换行
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
}
@end
