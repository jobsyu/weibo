//
//  Status.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Status : NSObject

@property (nonatomic,copy) NSString *text; //微博内容
@property (nonatomic,strong) User *user;

-(id)initWithDict:(NSDictionary *)dict;

@end
