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

@implementation StatusTool

+(void)statusesWithSuccess:(StatusSuccessBlock)success failure:(StatusFailureBlock)failure
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/statuses/home_timeline.json",kBaseURL];
  [HttpTool getWithPath:strUrl params:nil success:^(id JSON) {
      if(success == nil) return ;
      
      NSMutableArray *statuses = [NSMutableArray array];
      
      WXLog(@"%@",JSON);
      //解析json对象
      NSArray *array = JSON[@"statuses"];
      for(NSDictionary *dict in array){
          Status *s = [[Status alloc] initWithDict:dict];
          [statuses addObject:s];
      }
      
      //回调block
      success(statuses);
  } failure:^(NSError *error) {
      if(failure == nil) return ;
      
      failure(error);
  }];
}

@end
