//
//  StatusTool.h
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

typedef void (^StatusSuccessBlock)(NSArray *statues);
typedef void (^StatusFailureBlock)(NSError *error);

typedef void (^CommentsSuccessBlock)(NSArray *comments, int totalNumber, long long nextCursor);
typedef void (^CommentsFailureBlock)(NSError *error);

typedef void (^RepostsSuccessBlock)(NSArray *reposts, int totalNumber,long long nextCursor);
typedef void (^RepostsFailureBlock)(NSError *error);

typedef void (^SingleStatusSuccessBlock)(Status *status);
typedef void (^SingleStatusFailureBlock)(NSError *error);
@interface StatusTool : NSObject
//抓取微博数据
+(void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure;
//抓取某条微博的评论数据
+(void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure;
//抓取某条微博的转发数据
+(void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId
    success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure;

//抓取单条微博数据
+(void)statusWithId:(long long)ID success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure;

@end
