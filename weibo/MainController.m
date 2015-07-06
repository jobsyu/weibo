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

@interface MainController() <UINavigationControllerDelegate,DockDelegate>

@end

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
    //首页
    HomeController *homeVc = [[HomeController alloc] init];
    WBNavigationController *nav1 = [[WBNavigationController alloc] initWithRootViewController:homeVc];
    nav1.delegate =self;
    [self addChildViewController:nav1];
    
    //消息
    MessageController *messageVc = [[MessageController alloc] init];
    WBNavigationController *nav2 = [[WBNavigationController alloc] initWithRootViewController:messageVc];
    nav2.delegate =self;
    [self addChildViewController:nav2];
    
    //我
    MeController *meVc = [[MeController alloc] init];
    WBNavigationController *nav3 = [[WBNavigationController alloc] initWithRootViewController:meVc];
    nav2.delegate =self;
    [self addChildViewController:nav3];
    
    //广场
    SquareController *squareVc = [[SquareController alloc] init];
    WBNavigationController *nav4 = [[WBNavigationController alloc] initWithRootViewController:squareVc];
    nav4.delegate =self;
    [self addChildViewController:nav4];
    
    //更多
    MoreController *moreVc = [[MoreController alloc] init];
    WBNavigationController *nav5 = [[WBNavigationController alloc] initWithRootViewController:moreVc];
    nav5.delegate =self;
    [self addChildViewController:nav5];
}


#pragma mark － UINavigationControllerDelegate代理方法
//1> 即将显示新控制器时调用
/*
 navigationController : 导航控制器
 viewController : 即将显示的新控制器
 */
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) {//不是根控制器
        // {0, 20}, {320, 460}
        // 2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height +20;
        navigationController.view.frame =frame;
        
        // 3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.frame.size.height -_dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        // 4.添加左上角的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_back.png" highlightedIcon:@"navigationbar_back_highlighted" target:self action:@selector(back)];
    }
}

-(void)back
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}
//2> 新控制器显示完毕时调用
/*
 navigationController : 导航控制器
 viewController : 显示完毕的新控制器
 */
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root =navigationController.viewControllers[0];
    if (viewController == root) {
        //1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height -_dock.frame.size.height +20;
        navigationController.view.frame =frame;
        
        //添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
}

#pragma mark - 初始化DockItem
-(void)addDockItem
{
    //1.设置背景
    [_dock setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]]];
    
    //2.给Dock添加内容
    [_dock addItemWithIcon:@"tabbar_home" selectedIcon:@"tabbar_home_selected" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_message_center" selectedIcon:@"tabbar_message_center_selected" title:@"消息"];
    [_dock addItemWithIcon:@"tabbar_profile" selectedIcon:@"tabbar_profile_selected" title:@"我"];
    [_dock addItemWithIcon:@"tabbar_discover" selectedIcon:@"tabbar_discover_selected" title:@"广场"];
    [_dock addItemWithIcon:@"tabbar_more" selectedIcon:@"tabbar_more_selected" title:@"更多"];
    
    
    [_dock setDockframe];
}

@end
