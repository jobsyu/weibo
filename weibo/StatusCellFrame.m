//
//  StatusCellFrame.m
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"

@implementation StatusCellFrame

-(void)setStatus:(Status *)status
{
    [super setStatus:status];
    
    //_RetweetedFrame.size.height += 35;
    _cellHeight += kStatusDockHeight;
}
@end
