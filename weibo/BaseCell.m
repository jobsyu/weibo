//
//  BaseCell.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.设置背景
        [self settingBg];
    }
    return self;
}

#pragma mark 设置背景
-(void)settingBg
{
    //默认背景
    UIImageView *bg = [[UIImageView alloc] init];
    self.backgroundView = bg;
    _bg = bg;
    //长按背景
    UIImageView *selectedBg = [[UIImageView alloc] init];
    self.selectedBackgroundView = selectedBg;
    _selectedBg =selectedBg;
}


@end
