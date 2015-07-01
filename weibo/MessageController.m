//
//  MessageController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "MessageController.h"

@implementation MessageController

-(void)viewDidLoad
{
    //1.设置标题
    self.title = @"消息";
    //2.背景颜色
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发消息"
       style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
}

@end
