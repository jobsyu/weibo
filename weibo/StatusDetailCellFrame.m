//
//  StatusDetailCellFrame.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"

@implementation StatusDetailCellFrame

-(void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    if (status.retweetedStatus) {
        _RetweetedFrame.size.height += kRetweetedDockHeight;
        _cellHeight += kRetweetedDockHeight;
    }
}

@end
