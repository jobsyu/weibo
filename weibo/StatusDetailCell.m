//
//  StatusDetailCell.m
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusDetailCell.h"
#import "StatusCellFrame.h"
#import "RetweetedDock.h"
#import "Status.h"
#import "StatusDetailController.h"
#import "MainController.h"

@interface StatusDetailCell()
{
    RetweetedDock *_dock;
}
@end

@implementation StatusDetailCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.操作条
        RetweetedDock *dock = [[RetweetedDock alloc] init];
        dock.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        CGFloat x = _retweeted.frame.size.width - dock.frame.size.width;
        CGFloat y = _retweeted.frame.size.height - dock.frame.size.height;
        dock.frame = CGRectMake(x, y,0,0);
        [_retweeted addSubview:dock];
        _dock = dock;
        //2.监听被转发微博的点击
        [_retweeted addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
    }
    return self;
}

-(void)showRetweeted
{
    //展示被转发的微博
    StatusDetailController *detailVc = [[StatusDetailController alloc] init];
    detailVc.status = _dock.status;
    
    MainController *main = (MainController *)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController *)main.selectedController;
    [nav pushViewController:detailVc animated:YES];
}

-(void)setCellFrame:(BaseStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    //设置子控件的数据
    _dock.status = cellFrame.status.retweetedStatus;
}

@end
