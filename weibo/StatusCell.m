//
//  StatusCell.m
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "StatusDock.h"

@interface StatusCell()
{
    StatusDock *_statusDock; //底部的操作条
}
@end

@implementation StatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //底部的操作条
        CGFloat y = self.frame.size.height - kStatusDockHeight;
        _statusDock = [[StatusDock alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
        [self.contentView addSubview:_statusDock];
    }
    return self;
}

-(void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    //底部的操作条
    _statusDock.status = cellFrame.status;
}
@end
