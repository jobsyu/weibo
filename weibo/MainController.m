//
//  MainController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "MoreController.h"
#import "SquareController.h"
#import "MessageController.h"
#import "MeController.h"
#import "WBNavigationController.h"

@implementation MainController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.初始化所有的子控制器
    [self addSubViewController];
    
    //2.初始化DockItem
    [self addDockItem];
    
    
}
#pragma mark - 初始化所有的子控制器
-(void)addSubViewController
{
    //3.添加其他控制器
    WBNavigationController *nav = nil;
    //首页
    HomeController *homeVc = [[HomeController alloc] init];
    homeVc.view.backgroundColor = [UIColor whiteColor];
    nav = [[WBNavigationController alloc] initWithRootViewController:homeVc];
    
    [self addChildViewController:nav];
    
    //消息
    MessageController *messageVc = [[MessageController alloc] init];
    messageVc.view.backgroundColor = [UIColor redColor];
    nav = [[WBNavigationController alloc] initWithRootViewController:messageVc];
    
    [self addChildViewController:nav];
    
    //我
    MeController *meVc = [[MeController alloc] init];
    nav = [[WBNavigationController alloc] initWithRootViewController:meVc];
    
    [self addChildViewController:nav];
    
    //广场
    SquareController *squareVc = [[SquareController alloc] init];
    nav = [[WBNavigationController alloc] initWithRootViewController:squareVc];
    
    [self addChildViewController:nav];
    
    //更多
    MoreController *moreVc = [[MoreController alloc] init];
    nav = [[WBNavigationController alloc] initWithRootViewController:moreVc];
    
    [self addChildViewController:nav];
}

#pragma mark - 初始化DockItem
-(void)addDockItem
{
    //1.设置背景
    [_dock setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]]];
    
    //2.给Dock添加内容
    [_dock addItemWithIcon:@"tabbar_home" selectedIcon:@"tabbar_home_selected" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_message_center" selectedIcon:@"tabbar_message_center_selected" title:@"消息"];
    [_dock addItemWithIcon:@"tabbar_discover" selectedIcon:@"tabbar_discover_selected" title:@"发现"];
    [_dock addItemWithIcon:@"tabbar_profile" selectedIcon:@"tabbar_profile_selected" title:@"我"];
    [_dock addItemWithIcon:@"tabbar_more" selectedIcon:@"tabbar_more_selected" title:@"更多"];
    
    
    [_dock setDockframe];
}

@end
