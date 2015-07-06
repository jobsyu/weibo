//
//  StatusTool.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "StatusTool.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Status.h"
#import "Comment.h"

@implementation StatusTool

+(void)statusesWithSinceId:(long long)sinceId maxId:(long long)maxId success:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/statuses/home_timeline.json",kBaseURL];
    [HttpTool getWithPath:strUrl params:@{
         @"count" : @50,
         @"since_id" : @(sinceId),
         @"max_id" : @(maxId)
      } success:^(id JSON) {
        if (success == nil) return;
      
         NSMutableArray *statuses = [NSMutableArray array];
      
         //WXLog(@"%@",JSON);
         //解析json对象
         NSArray *array = JSON[@"statuses"];
         for (NSDictionary *dict in array){
            Status *s = [[Status alloc] initWithDict:dict];
            [statuses addObject:s];
         }
      
         //回调block
         success(statuses);
      } failure:^(NSError *error) {
         if(failure == nil) return;
      
         failure(error);
      }];
}

+(void)commentsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(CommentsSuccessBlock)success failure:(CommentsFailureBlock)failure
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/comments/show.json",kBaseURL];
    [HttpTool getWithPath:strUrl params:@{
          @"id" : @(statusId),
          @"since_id" : @(sinceId),
          @"max_id" : @(maxId),
          @"count"  :@20
          } success:^(id JSON) {
              if (success == nil) return;
              
              //WXLog(@"%@",JSON);
              //解析json对象
              //JSON数组（装着所有的评论）
              NSArray *array = JSON[@"comments"];
              
              NSMutableArray *comments = [NSMutableArray array];
            
              for (NSDictionary *dict in array){
                  Comment *s = [[Comment alloc] initWithDict:dict];
                  [comments addObject:s];
              }
              
              //回调block
              success(comments,[JSON[@"total_number"] intValue],[JSON[@"next_cursor"] longLongValue]);
          } failure:^(NSError *error) {
              if(failure == nil) return;
              
              failure(error);
          }];
}

+(void)repostsWithSinceId:(long long)sinceId maxId:(long long)maxId statusId:(long long)statusId success:(RepostsSuccessBlock)success failure:(RepostsFailureBlock)failure
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/statuses/repost_timeline.json",kBaseURL];
    [HttpTool getWithPath:strUrl params:@{
          @"id" : @(statusId),
          @"since_id" : @(sinceId),
          @"max_id" : @(maxId),
          @"count"  :@20
          } success:^(id JSON) {
              if (success == nil) return;
              
              //WXLog(@"%@",JSON);
              //解析json对象
              //JSON数组（装着所有的评论）
              NSArray *array = JSON[@"reposts"];
              
              NSMutableArray *reposts = [NSMutableArray array];
              
              for (NSDictionary *dict in array){
                  Status *s = [[Status alloc] initWithDict:dict];
                  [reposts addObject:s];
              }
              
              //回调block
              success(reposts,[JSON[@"total_number"] intValue],[JSON[@"next_cursor"] longLongValue]);
          } failure:^(NSError *error) {
              if(failure == nil) return;
              
              failure(error);
          }];
}

+(void)statusWithId:(long long)ID success:(SingleStatusSuccessBlock)success failure:(SingleStatusFailureBlock)failure
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/statuses/show.json",kBaseURL];
    WXLog(@"%@",strUrl);
    [HttpTool getWithPath:strUrl params:@{
          @"id" : @(ID),
          @"source" : kAppKey
          } success:^(id JSON) {
              if (success == nil) return;
              
              Status *s = [[Status alloc] initWithDict:JSON];
              
              //回调block
              success(s);
          } failure:^(NSError *error) {
              if(failure == nil) return;
              
              failure(error);
          }];
}

@end
