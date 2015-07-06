//
//  BaseText.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "BaseModel.h"
@class User;
@interface BaseText : BaseModel
@property (nonatomic,copy) NSString *text; //微博内容
@property (nonatomic,strong) User *user;//微博用户
@end
