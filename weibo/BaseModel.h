//
//  BaseModel.h
//  weibo
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic,assign) long long ID;
@property (nonatomic,copy) NSString *createdAt; //微博创建时间

- (id)initWithDict:(NSDictionary *)dict;
@end
