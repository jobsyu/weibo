//
//  MessageController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "MessageController.h"
#import "AccountTool.h"
#import "FriendshipTool.h"


@implementation MessageController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //1.设置标题
    self.title = @"消息";
    //2.背景颜色
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发消息"
       style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
    long long ID = [[AccountTool sharedAccountTool].account.uid longLongValue];
    [FriendshipTool followersWithId:ID success:^(NSArray *followers) {
        [_data addObjectsFromArray:followers];
        
        [self.tableView reloadData];
    } failure:nil];
    
}

-(void)sendMessage
{
    WXLog(@"senmessage");
}

@end
