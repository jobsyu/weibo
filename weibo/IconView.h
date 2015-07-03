//
//  IconView.h
//  weibo
//
//  Created by qianfeng on 15/7/2.
//  Copyright (c) 2015年 ycp. All rights reserved.
//


#import <UIKit/UIKit.h>
@class User;

typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
}IconType;

@interface IconView : UIView
@property (nonatomic,strong) User *user;
@property (nonatomic,assign) IconType type;

-(void)setUser:(User *)user type:(IconType)type;

 + (CGSize)iconSizeWithType:(IconType)type;
@end
