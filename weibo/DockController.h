//
//  DockController.h
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"

@interface DockController : UIViewController
{
    Dock *_dock;
}

@property (nonatomic,readonly) UIViewController *selectedController;
@end
