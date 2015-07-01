//
//  DockController.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DockController.h"
#import "Dock.h"


#define kDockHeight 44

@interface DockController()<DockDelegate>


@end

@implementation DockController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.添加Dock
    Dock *dock =[[Dock alloc] init];
    dock.frame = CGRectMake(0,self.view.frame.size.height - kDockHeight,self.view.frame.size.width,kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
    
}

#pragma mark DockDelegate 代理方法
-(void)dock:(Dock *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    if (dock.tag < 0 && dock.tag > dock.subviews.count) return;
    
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    UIViewController *newVc = self.childViewControllers[to];
    newVc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
    [self.view addSubview:newVc.view];
}

@end
