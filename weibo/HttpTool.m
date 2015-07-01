//
//  HttpTool.m
//  weibo
//
//  Created by qianfeng on 15/7/1.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "AccountTool.h"

@implementation HttpTool

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
    // 拼接token参数
    NSString *token = [AccountTool sharedAccountTool].account.accessToken;
    if (token) {
        [allParams setObject:token forKey:@"access_token"];
    }
    
    [mgr POST:path parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    
    // 拼接token参数
    NSString *token = [AccountTool sharedAccountTool].account.accessToken;
    if (token) {
        [allParams setObject:token forKey:@"access_token"];
    }
    
    [mgr GET:path parameters:allParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

@end
