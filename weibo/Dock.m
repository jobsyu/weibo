//
//  Dock.m
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock()
{
    DockItem *_selectedDockItem;
}

@end

@implementation Dock

//添加DockItem
-(void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectIcon title:(NSString *)title
{
    DockItem *item = [[DockItem alloc] init];
    [item setTitle:title forState:UIControlStateNormal];
    
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
    
    [item addTarget:self action:@selector(dockSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
}

//调整DockItem的frame
-(void)setDockframe
{
    NSInteger count = self.subviews.count;
    
    //调整DockItem的frame
    CGFloat width = self.width / count;
    CGFloat height = self.height;
    for (NSInteger i = 0; i<count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i;
        dockItem.frame = CGRectMake(i * width, 0, width, height);
        if (dockItem.tag == 0) {
            [self dockSelected:dockItem];
        }
    }
}

-(void)dockSelected:(DockItem *)dockItemTo{
    if ([self.delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [self.delegate dock:self itemSelectedFrom:_selectedDockItem.tag to:dockItemTo.tag];
    }
    
    //
    _selectedIndex = _selectedDockItem.tag;
    
    // 1.取消选中当前选中的item
    _selectedDockItem.selected =NO;
    
    // 2.选中点击的item
    dockItemTo.selected = YES;
    
    // 3.赋值
    _selectedDockItem = dockItemTo;
    
}
@end
