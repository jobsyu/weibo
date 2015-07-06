//
//  MeController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "MeController.h"
#import "AccountTool.h"
#import "FriendshipTool.h"

@implementation MeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.设置标题
    self.title = @"我";
    // 2.背景颜色
    //self.view.backgroundColor = [UIColor blueColor];
    //
    long long ID = [[AccountTool sharedAccountTool].account.uid longLongValue];
    [FriendshipTool friendsWithId:ID success:^(NSArray *followers) {
        [_data addObjectsFromArray:followers];
        
        [self.tableView reloadData];
    } failure:nil];
}

@end
