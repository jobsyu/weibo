//
//  User.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic,copy) NSString *screenName; //昵称
@property (nonatomic,copy) NSString *profileImageUrl; //头像

@property (nonatomic,assign) BOOL verified; //微博认证(是否是微博认证用户，即加V用户)
@property (nonatomic,assign) int verified_type; //微博认证类型

@property (nonatomic,assign) int mbrank; //会员等级
@property (nonatomic,assign) int mbtype; //会员类型


-(id)initWithDict:(NSDictionary *)dict;
@end
