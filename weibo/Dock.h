//
//  Dock.h
//  weibo
//
//  Created by qianfeng on 15/6/30.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dock;

@protocol DockDelegate <NSObject>

@optional
-(void)dock:(Dock *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface Dock : UIView

-(void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectIcon title:(NSString *)title;
-(void)setDockframe;

@property (nonatomic,weak) id<DockDelegate> delegate;
@end
