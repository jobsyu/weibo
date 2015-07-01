//
//  WBNavigationController.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "WBNavigationController.h"

@implementation WBNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //2.设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    //3.设置导航栏文字的背景图片
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    //dict[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    
    [bar setTitleTextAttributes:dict];
    
    //4.修改导航栏文字的主题
    UIBarButtonItem *barItem = [UIBarButtonItem  appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *dictbarItem = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    //dict[NSShadowAttributeName] = ;
    
    [barItem setTitleTextAttributes:dictbarItem forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dictbarItem forState:UIControlStateHighlighted];
    
    //5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

@end
