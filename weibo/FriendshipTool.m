//
//  FriendshipTool.m
//  weibo
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "FriendshipTool.h"
#import "HttpTool.h"
#import "User.h"

@implementation FriendshipTool

+(void)followersWithId:(long long)ID success:(FollowersSuccessBlock)success failure:(FollowersFailureBlock)failure
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/2/friendships/followers.json",kBaseURL];
    [HttpTool getWithPath:strUrl params:@{
      @"uid" : @(ID)
    } success:^(id JSON) {
        NSArray *array = JSON[@"users"];
        NSMutableArray *follwers = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            User *u = [[User alloc] initWithDict:dict];
            [follwers addObject:u];
        }
        
        success(follwers);
    } failure:^(NSError *error) {
        if (failure == nil) return;
        
        failure(error);
    }];
}

+ (void)friendsWithId:(long long)ID success:(FriendsSuccessBlock)success failure:(FriendsFailureBlock)failure
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/friendships/friends.json",kBaseURL];
    [HttpTool getWithPath:strUrl params:@{
      @"uid" : @(ID)
      } success:^(id JSON) {
          NSArray *array = JSON[@"users"];
          NSMutableArray *follwers = [NSMutableArray array];
          
          for (NSDictionary *dict in array) {
              User *u = [[User alloc] initWithDict:dict];
              [follwers addObject:u];
          }
          
          success(follwers);
      } failure:^(NSError *error) {
          if (failure == nil) return;
          
          failure(error);
      }];

}


@end
