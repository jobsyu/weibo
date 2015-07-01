//
//  HomeController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeController.h"

@implementation HomeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_pop" highlightedIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_compose" highlightedIcon:@"navigationbar_compose_highlighted" target:self action:@selector(compose)];
    
}


-(void)pop
{
    WXLog(@"pop");
}

-(void)compose
{
    WXLog(@"compose");
}
@end
