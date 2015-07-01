//
//  StatusTool.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^StatusSuccessBlock)(NSArray *statues);
typedef void (^StatusFailureBlock)(NSError *error);

@interface StatusTool : NSObject

+(void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;

@end
